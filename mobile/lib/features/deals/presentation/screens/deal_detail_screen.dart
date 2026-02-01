import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../providers/deals_provider.dart';

/// Deal detail screen matching Figma design 1:1
class DealDetailScreen extends ConsumerStatefulWidget {
  final String dealId;

  const DealDetailScreen({
    super.key,
    required this.dealId,
  });

  @override
  ConsumerState<DealDetailScreen> createState() => _DealDetailScreenState();
}

class _DealDetailScreenState extends ConsumerState<DealDetailScreen> {
  bool _isActionLoading = false;

  // Mock data for fields not in backend yet
  static const _mockData = _MockDealData(
    deliverables: [
      _DeliverableData(
        id: '1',
        type: 'Instagram Feed Post',
        platform: 'Instagram',
        status: 'pending',
        dueDate: 'Dec 20, 2026',
      ),
      _DeliverableData(
        id: '2',
        type: 'Instagram Stories',
        platform: 'Instagram',
        status: 'pending',
        dueDate: 'Dec 22, 2026',
      ),
      _DeliverableData(
        id: '3',
        type: 'TikTok Video',
        platform: 'TikTok',
        status: 'pending',
        dueDate: 'Dec 25, 2026',
      ),
    ],
    payment: _PaymentData(
      status: 'In Escrow',
      fundedDate: 'Dec 1, 2026',
    ),
    timeline: [
      _TimelineItem(event: 'Deal Created', date: 'Nov 28, 2026', time: '2:30 PM'),
      _TimelineItem(event: 'Terms Proposed', date: 'Nov 28, 2026', time: '3:15 PM'),
      _TimelineItem(event: 'Terms Accepted', date: 'Nov 29, 2026', time: '10:45 AM'),
      _TimelineItem(event: 'Payment Funded to Escrow', date: 'Dec 1, 2026', time: '9:00 AM'),
    ],
    platformFeePercent: 10,
  );

  @override
  Widget build(BuildContext context) {
    final dealAsync = ref.watch(dealByIdProvider(widget.dealId));
    final authState = ref.watch(authStateProvider);
    final currentUserId = authState.user?.id;

    return Scaffold(
      backgroundColor: AppColors.elevated,
      body: dealAsync.when(
        loading: () => const Center(child: LoadingIndicator()),
        error: (error, _) => AppErrorWidget(
          message: error.toString(),
          onRetry: () => ref.invalidate(dealByIdProvider(widget.dealId)),
        ),
        data: (deal) {
          // Calculate payment values
          final totalAmount = deal.agreedAmount ?? 1500.0;
          final platformFee = totalAmount * (_mockData.platformFeePercent / 100);
          final netAmount = totalAmount - platformFee;

          return Column(
            children: [
              // App Bar
              AppBar(
                backgroundColor: AppColors.elevated,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(LucideIcons.arrowLeft, color: AppColors.gray700),
                  onPressed: () => context.pop(),
                ),
                title: Text(
                  'Deal Details',
                  style: AppTypography.h3.copyWith(color: AppColors.gray900),
                ),
                actions: [
                  IconButton(
                    icon: Icon(LucideIcons.moreVertical, color: AppColors.gray700),
                    onPressed: () {
                      // TODO: Show options menu
                    },
                  ),
                ],
              ),

              // Status banner
              _buildStatusBanner(deal.status),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Parties section
                      _buildPartiesSection(deal, currentUserId),
                      AppSpacing.gapV6,

                      // Terms section
                      _buildTermsSection(deal, totalAmount),
                      AppSpacing.gapV6,

                      // Deliverables section
                      _buildDeliverablesSection(),
                      AppSpacing.gapV6,

                      // Payment section
                      _buildPaymentSection(totalAmount, platformFee, netAmount),
                      AppSpacing.gapV6,

                      // Timeline section
                      _buildTimelineSection(),
                      AppSpacing.gapV8,
                    ],
                  ),
                ),
              ),

              // Action bar
              _buildActionBar(deal, currentUserId),
            ],
          );
        },
      ),
    );
  }

  Widget _buildStatusBanner(DealStatus status) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimary,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Status',
                style: AppTypography.bodySmall.copyWith(
                  color: Colors.white.withAlpha(230),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                status.displayName,
                style: AppTypography.h2.copyWith(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Icon(
            LucideIcons.checkCircle2,
            size: 48,
            color: Colors.white.withAlpha(192),
          ),
        ],
      ),
    );
  }

  Widget _buildPartiesSection(deal, String? currentUserId) {
    final currentUserName = ref.watch(authStateProvider).user?.profile?.displayName;
    final influencerName = deal.influencerId == currentUserId
        ? (currentUserName ?? deal.influencerName ?? 'Unknown')
        : (deal.influencerName ?? 'Unknown');
    final clientName = deal.clientId == currentUserId
        ? (currentUserName ?? deal.clientName ?? 'Unknown')
        : (deal.clientName ?? 'Unknown');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Parties'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: [
              // Brand
              InkWell(
                onTap: () {
                  // TODO: Navigate to brand profile
                },
                child: Row(
                  children: [
                    UserAvatar(
                      name: clientName,
                      size: AvatarSize.md,
                      verified: true,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Brand',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                          Text(
                            clientName,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: AppColors.gray200),
              ),
              // Influencer
              InkWell(
                onTap: () {
                  // TODO: Navigate to influencer profile
                },
                child: Row(
                  children: [
                    UserAvatar(
                      name: influencerName,
                      size: AvatarSize.md,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Influencer',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                          Text(
                            influencerName,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '150K',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermsSection(deal, double totalAmount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Terms'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: [
              // Total Amount
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Amount',
                    style: AppTypography.body.copyWith(
                      color: AppColors.gray700,
                    ),
                  ),
                  Text(
                    '\$${totalAmount.toStringAsFixed(0)}',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.gray900,
                    ),
                  ),
                ],
              ),
              AppSpacing.gapV3,
              _buildTermRow('Platform', 'Instagram, TikTok'),
              AppSpacing.gapV2,
              _buildTermRow('Content Types', 'Feed Post, Story, Video'),
              AppSpacing.gapV2,
              _buildTermRow('Deadline', 'Dec 31, 2026'),
              if (deal.currentTerms?.notes != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Divider(height: 1, color: AppColors.gray200),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Special Requirements',
                      style: AppTypography.bodySmall.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppColors.gray900,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      deal.currentTerms!.notes!,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTermRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray600,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray700,
          ),
        ),
      ],
    );
  }

  Widget _buildDeliverablesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Deliverables'),
        AppSpacing.gapV3,
        ..._mockData.deliverables.map((deliverable) {
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: AppRadius.card,
              border: Border.all(color: AppColors.gray200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            deliverable.type,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            deliverable.platform,
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildDeliverableStatusBadge(deliverable.status),
                  ],
                ),
                AppSpacing.gapV2,
                Row(
                  children: [
                    Icon(
                      LucideIcons.calendar,
                      size: 16,
                      color: AppColors.gray600,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Due: ${deliverable.dueDate}',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _buildDeliverableStatusBadge(String status) {
    switch (status) {
      case 'completed':
        return StatusBadge(
          label: 'Completed',
          status: BadgeStatus.success,
          size: BadgeSize.sm,
        );
      case 'submitted':
        return StatusBadge(
          label: 'Submitted',
          status: BadgeStatus.warning,
          size: BadgeSize.sm,
        );
      case 'pending':
      default:
        return StatusBadge(
          label: 'Pending',
          status: BadgeStatus.neutral,
          size: BadgeSize.sm,
        );
    }
  }

  Widget _buildPaymentSection(double totalAmount, double platformFee, double netAmount) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Payment'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: [
              // Escrow status
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: AppColors.escrow.withAlpha(51),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      LucideIcons.shield,
                      size: 24,
                      color: AppColors.escrow,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment Status',
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                        Text(
                          _mockData.payment.status,
                          style: AppTypography.body.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.escrow,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              AppSpacing.gapV4,
              // Amount breakdown
              _buildPaymentRow('Total Amount', '\$${totalAmount.toStringAsFixed(0)}', isBold: true),
              AppSpacing.gapV2,
              _buildPaymentRow('Platform Fee (10%)', '-\$${platformFee.toStringAsFixed(0)}'),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Divider(height: 1, color: AppColors.gray200),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Net to Influencer',
                    style: AppTypography.body.copyWith(
                      fontWeight: FontWeight.w600,
                      color: AppColors.gray900,
                    ),
                  ),
                  Text(
                    '\$${netAmount.toStringAsFixed(0)}',
                    style: AppTypography.h2.copyWith(
                      color: AppColors.success,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray600,
          ),
        ),
        Text(
          value,
          style: AppTypography.bodySmall.copyWith(
            color: AppColors.gray900,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionTitle('Activity Timeline'),
        AppSpacing.gapV3,
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: AppRadius.card,
            border: Border.all(color: AppColors.gray200),
          ),
          child: Column(
            children: _mockData.timeline.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isLast = index == _mockData.timeline.length - 1;

              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Timeline indicator
                  Column(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: isLast ? AppColors.primary : AppColors.gray200,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: isLast ? Colors.white : AppColors.gray500,
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                      ),
                      if (!isLast)
                        Container(
                          width: 2,
                          height: 40,
                          color: AppColors.gray200,
                        ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  // Content
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.event,
                            style: AppTypography.body.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.gray900,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${item.date} at ${item.time}',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: AppTypography.body.copyWith(
        fontWeight: FontWeight.w600,
        color: AppColors.gray900,
      ),
    );
  }

  Widget _buildActionBar(deal, String? currentUserId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        border: Border(top: BorderSide(color: AppColors.gray200)),
      ),
      child: SafeArea(
        top: false,
        child: AppButton(
          text: 'Open Chat',
          variant: AppButtonVariant.outline,
          isLoading: _isActionLoading,
          onPressed: () {
            // Navigate to chat
            context.push('/messages/1');
          },
        ),
      ),
    );
  }
}

// Mock data classes
class _MockDealData {
  final List<_DeliverableData> deliverables;
  final _PaymentData payment;
  final List<_TimelineItem> timeline;
  final int platformFeePercent;

  const _MockDealData({
    required this.deliverables,
    required this.payment,
    required this.timeline,
    required this.platformFeePercent,
  });
}

class _DeliverableData {
  final String id;
  final String type;
  final String platform;
  final String status;
  final String dueDate;

  const _DeliverableData({
    required this.id,
    required this.type,
    required this.platform,
    required this.status,
    required this.dueDate,
  });
}

class _PaymentData {
  final String status;
  final String fundedDate;

  const _PaymentData({
    required this.status,
    required this.fundedDate,
  });
}

class _TimelineItem {
  final String event;
  final String date;
  final String time;

  const _TimelineItem({
    required this.event,
    required this.date,
    required this.time,
  });
}
