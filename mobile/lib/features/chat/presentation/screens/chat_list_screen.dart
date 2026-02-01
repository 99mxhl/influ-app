import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../data/models/conversation.dart';
import '../../providers/chat_provider.dart';

/// Chat/Messages list screen matching Figma design 1:1
class ChatListScreen extends ConsumerStatefulWidget {
  const ChatListScreen({super.key});

  @override
  ConsumerState<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends ConsumerState<ChatListScreen> {
  String _selectedFilter = 'all';
  bool _searchOpen = false;
  final _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Conversation> _filterConversations(List<Conversation> conversations) {
    return conversations.where((conv) {
      // Filter by type
      if (_selectedFilter == 'unread' && conv.unreadCount == 0) return false;
      // 'active' filter would need deal status - for now show all

      // Filter by search
      if (_searchQuery.isNotEmpty) {
        final query = _searchQuery.toLowerCase();
        final name = _getOtherPartyName(conv).toLowerCase();
        final title = (conv.dealTitle ?? '').toLowerCase();
        return name.contains(query) || title.contains(query);
      }
      return true;
    }).toList();
  }

  String _getOtherPartyName(Conversation conv) {
    final currentUserId = ref.read(authStateProvider).user?.id;
    if (currentUserId == conv.influencerId) {
      return conv.clientDisplayName ?? 'Unknown';
    }
    return conv.influencerDisplayName ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final conversationsAsync = ref.watch(conversationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: _searchOpen
            ? null
            : Text('Messages', style: AppTypography.h3.copyWith(color: AppColors.gray900)),
        actions: [
          if (_searchOpen) ...[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _searchController,
                        autofocus: true,
                        onChanged: (value) => setState(() => _searchQuery = value),
                        decoration: InputDecoration(
                          hintText: 'Search conversations...',
                          border: OutlineInputBorder(
                            borderRadius: AppRadius.button,
                            borderSide: BorderSide(color: AppColors.gray300),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _searchOpen = false;
                          _searchQuery = '';
                          _searchController.clear();
                        });
                      },
                      child: Text(
                        'Cancel',
                        style: AppTypography.body.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ] else ...[
            IconButton(
              onPressed: () => setState(() => _searchOpen = true),
              icon: Icon(LucideIcons.search, color: AppColors.gray700),
            ),
          ],
        ],
      ),
      body: Column(
        children: [
          // Filter chips
          if (!_searchOpen)
            Container(
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: AppColors.gray200)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      isSelected: _selectedFilter == 'all',
                      onTap: () => setState(() => _selectedFilter = 'all'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Unread',
                      isSelected: _selectedFilter == 'unread',
                      onTap: () => setState(() => _selectedFilter = 'unread'),
                    ),
                    const SizedBox(width: 8),
                    _FilterChip(
                      label: 'Deals Active',
                      isSelected: _selectedFilter == 'active',
                      onTap: () => setState(() => _selectedFilter = 'active'),
                    ),
                  ],
                ),
              ),
            ),

          // Conversation list
          Expanded(
            child: conversationsAsync.when(
              loading: () => const Center(child: LoadingIndicator()),
              error: (error, _) => AppErrorWidget(
                message: error.toString(),
                onRetry: () => ref.read(conversationsProvider.notifier).refresh(),
              ),
              data: (conversations) {
                final filtered = _filterConversations(conversations);

                if (filtered.isEmpty) {
                  return _buildEmptyState();
                }

                return RefreshIndicator(
                  onRefresh: () => ref.read(conversationsProvider.notifier).refresh(),
                  child: ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => Divider(
                      height: 1,
                      color: AppColors.gray200,
                    ),
                    itemBuilder: (context, index) {
                      final conv = filtered[index];
                      return _ConversationTile(
                        conversation: conv,
                        otherPartyName: _getOtherPartyName(conv),
                        onTap: () => context.push('/messages/${conv.dealId}'),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: AppSpacing.page,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('💬', style: TextStyle(fontSize: 64)),
            AppSpacing.gapV4,
            Text(
              _searchQuery.isNotEmpty ? 'No conversations found' : 'No messages yet',
              style: AppTypography.h3.copyWith(color: AppColors.gray900),
            ),
            AppSpacing.gapV2,
            Text(
              _searchQuery.isNotEmpty
                  ? 'No conversations match "$_searchQuery"'
                  : 'Start a conversation by applying to a campaign',
              style: AppTypography.body.copyWith(color: AppColors.gray600),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.gray100,
          borderRadius: AppRadius.radiusFull,
        ),
        child: Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: isSelected ? Colors.white : AppColors.gray700,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  final Conversation conversation;
  final String otherPartyName;
  final VoidCallback onTap;

  const _ConversationTile({
    required this.conversation,
    required this.otherPartyName,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasUnread = conversation.unreadCount > 0;

    return InkWell(
      onTap: onTap,
      child: Container(
        color: hasUnread ? AppColors.infoLight : Colors.transparent,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Avatar with status indicator
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: UserAvatar(
                    name: otherPartyName,
                    size: AvatarSize.md,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          otherPartyName,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (conversation.lastMessage?.createdAt != null)
                        Text(
                          _formatTimestamp(conversation.lastMessage!.createdAt!),
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray500,
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    conversation.dealTitle ?? '',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray600,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    conversation.lastMessage?.content ?? 'No messages yet',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.gray500,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            // Unread badge
            if (hasUnread) ...[
              const SizedBox(width: 8),
              Container(
                width: 24,
                height: 24,
                margin: const EdgeInsets.only(top: 4),
                decoration: BoxDecoration(
                  color: AppColors.unread,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    conversation.unreadCount > 9 ? '9+' : '${conversation.unreadCount}',
                    style: AppTypography.caption.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final diff = now.difference(timestamp);

    if (diff.inMinutes < 1) return 'Just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${timestamp.day}/${timestamp.month}';
  }
}
