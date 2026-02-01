import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../data/models/message.dart';
import '../../providers/chat_provider.dart';

/// Chat detail screen with real API integration
class ChatDetailScreen extends ConsumerStatefulWidget {
  final String dealId;

  const ChatDetailScreen({
    super.key,
    required this.dealId,
  });

  @override
  ConsumerState<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends ConsumerState<ChatDetailScreen> {
  final _messageController = TextEditingController();
  final _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(messagesProvider(widget.dealId).notifier).markAsRead();
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: AppDurations.normal,
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> _handleSend() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    _messageController.clear();

    try {
      await ref.read(messagesProvider(widget.dealId).notifier).sendMessage(text);
      _scrollToBottom();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  String _getOtherPartyName(String influencerId, String? influencerName,
      String? clientName, String? currentUserId) {
    if (currentUserId == influencerId) {
      return clientName ?? 'Unknown';
    }
    return influencerName ?? 'Unknown';
  }

  @override
  Widget build(BuildContext context) {
    final conversationAsync = ref.watch(conversationProvider(widget.dealId));
    final messagesAsync = ref.watch(messagesProvider(widget.dealId));
    final currentUserId = ref.watch(authStateProvider).user?.id;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(LucideIcons.arrowLeft, color: AppColors.gray700),
          onPressed: () => context.pop(),
        ),
        titleSpacing: 0,
        title: conversationAsync.when(
          loading: () => const SizedBox.shrink(),
          error: (_, __) => const Text('Chat'),
          data: (conversation) {
            final otherName = _getOtherPartyName(
              conversation.influencerId,
              conversation.influencerDisplayName,
              conversation.clientDisplayName,
              currentUserId,
            );
            return GestureDetector(
              onTap: () {
                // Navigate to user profile
              },
              child: Row(
                children: [
                  UserAvatar(name: otherName, size: AvatarSize.sm),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          otherName,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.gray900,
                          ),
                        ),
                        Text(
                          'Online',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.success,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(LucideIcons.moreVertical, color: AppColors.gray700),
            onPressed: () {
              // Show options menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Deal status banner
          conversationAsync.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (conversation) => _buildDealBanner(
              conversation.dealTitle ?? 'Deal',
              widget.dealId,
            ),
          ),

          // Messages
          Expanded(
            child: messagesAsync.when(
              loading: () => const Center(child: LoadingIndicator()),
              error: (error, _) => AppErrorWidget(
                message: error.toString(),
                onRetry: () =>
                    ref.read(messagesProvider(widget.dealId).notifier).loadMessages(),
              ),
              data: (messages) {
                if (messages.isEmpty) {
                  return _buildEmptyState();
                }

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (_scrollController.hasClients) {
                    _scrollController.jumpTo(
                      _scrollController.position.maxScrollExtent,
                    );
                  }
                });

                return ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.all(16),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final previousMessage =
                        index > 0 ? messages[index - 1] : null;
                    final showDate = _shouldShowDateSeparator(
                      message,
                      previousMessage,
                    );

                    return Column(
                      children: [
                        if (showDate)
                          _buildDateSeparator(message.createdAt),
                        _buildMessage(message, currentUserId),
                      ],
                    );
                  },
                );
              },
            ),
          ),

          // Input area
          _buildInputArea(),
        ],
      ),
    );
  }

  bool _shouldShowDateSeparator(Message current, Message? previous) {
    if (previous == null) return true;
    if (current.createdAt == null || previous.createdAt == null) return false;

    final currentDate = DateTime(
      current.createdAt!.year,
      current.createdAt!.month,
      current.createdAt!.day,
    );
    final previousDate = DateTime(
      previous.createdAt!.year,
      previous.createdAt!.month,
      previous.createdAt!.day,
    );

    return currentDate != previousDate;
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            LucideIcons.messageCircle,
            size: 64,
            color: AppColors.gray300,
          ),
          AppSpacing.gapV4,
          Text(
            'No messages yet',
            style: AppTypography.h3.copyWith(color: AppColors.gray900),
          ),
          AppSpacing.gapV2,
          Text(
            'Start the conversation!',
            style: AppTypography.body.copyWith(color: AppColors.gray600),
          ),
        ],
      ),
    );
  }

  Widget _buildDealBanner(String dealTitle, String dealId) {
    return InkWell(
      onTap: () => context.push('/deals/$dealId'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: AppColors.gray200)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Row(
                children: [
                  Flexible(
                    child: Text(
                      'Deal: $dealTitle',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  StatusBadge(
                    label: 'Active',
                    status: BadgeStatus.primary,
                    size: BadgeSize.sm,
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.chevronRight,
              size: 20,
              color: AppColors.gray400,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSeparator(DateTime? timestamp) {
    if (timestamp == null) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Text(
          _formatDateSeparator(timestamp),
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray500,
          ),
        ),
      ),
    );
  }

  String _formatDateSeparator(DateTime timestamp) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final messageDate = DateTime(timestamp.year, timestamp.month, timestamp.day);
    final diff = today.difference(messageDate).inDays;

    if (diff == 0) return 'Today';
    if (diff == 1) return 'Yesterday';
    if (diff < 7) return '${diff} days ago';
    return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
  }

  Widget _buildMessage(Message message, String? currentUserId) {
    if (message.type == MessageType.system) {
      return _buildSystemMessage(message);
    }
    return _buildChatBubble(message, currentUserId);
  }

  Widget _buildSystemMessage(Message message) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.gray100,
            borderRadius: AppRadius.button,
          ),
          child: Text(
            message.content,
            style: AppTypography.bodySmall.copyWith(
              color: AppColors.gray700,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildChatBubble(Message message, String? currentUserId) {
    final isSent = message.senderId == currentUserId;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.75,
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSent ? AppColors.primary : AppColors.gray100,
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(16),
                topRight: const Radius.circular(16),
                bottomLeft: Radius.circular(isSent ? 16 : 4),
                bottomRight: Radius.circular(isSent ? 4 : 16),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  message.content,
                  style: AppTypography.body.copyWith(
                    color: isSent ? Colors.white : AppColors.gray800,
                  ),
                ),
                if (message.createdAt != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    _formatMessageTime(message.createdAt!),
                    style: TextStyle(
                      fontSize: 10,
                      color: isSent ? Colors.white70 : AppColors.gray500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatMessageTime(DateTime timestamp) {
    final hour = timestamp.hour.toString().padLeft(2, '0');
    final minute = timestamp.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.gray200)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            // Attach button
            IconButton(
              icon: Icon(LucideIcons.paperclip, color: AppColors.gray500),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('File attachment coming soon!')),
                );
              },
            ),

            // Text input
            Expanded(
              child: TextField(
                controller: _messageController,
                maxLines: null,
                textCapitalization: TextCapitalization.sentences,
                decoration: InputDecoration(
                  hintText: 'Type a message...',
                  hintStyle: AppTypography.body.copyWith(
                    color: AppColors.gray400,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: AppRadius.button,
                    borderSide: BorderSide(color: AppColors.gray300),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                ),
                onSubmitted: (_) => _handleSend(),
              ),
            ),

            const SizedBox(width: 8),

            // Send button
            Container(
              decoration: BoxDecoration(
                color: AppColors.primary,
                borderRadius: AppRadius.button,
              ),
              child: IconButton(
                icon: _isSending
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      )
                    : Icon(LucideIcons.send, color: Colors.white),
                onPressed: _isSending ? null : _handleSend,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
