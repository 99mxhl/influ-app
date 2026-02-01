import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../data/models/payment.dart';
import '../../providers/payment_provider.dart';

class PaymentStatusCard extends ConsumerWidget {
  final String dealId;
  final bool showActions;

  const PaymentStatusCard({
    super.key,
    required this.dealId,
    this.showActions = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final paymentAsync = ref.watch(paymentProvider(dealId));

    return paymentAsync.when(
      loading: () => const Center(child: LoadingIndicator()),
      error: (_, __) => const SizedBox.shrink(),
      data: (payment) {
        if (payment == null) {
          return _buildNoPayment();
        }
        return _buildPaymentCard(context, payment);
      },
    );
  }

  Widget _buildNoPayment() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: AppRadius.card,
      ),
      child: Row(
        children: [
          Icon(LucideIcons.creditCard, size: 24, color: AppColors.gray400),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'No payment yet',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray700,
                  ),
                ),
                Text(
                  'Payment will be created after terms are accepted',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.gray500),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentCard(BuildContext context, Payment payment) {
    final (icon, color, bgColor) = _getStatusStyle(payment.status);

    return Container(
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
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: bgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 20, color: color),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gray500),
                    ),
                    Text(
                      '\$${payment.amount.toStringAsFixed(2)}',
                      style: AppTypography.h3.copyWith(color: AppColors.gray900),
                    ),
                  ],
                ),
              ),
              _buildStatusBadge(payment.status),
            ],
          ),

          if (payment.status == PaymentStatus.escrowHeld) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.infoLight,
                borderRadius: AppRadius.button,
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.shieldCheck, size: 18, color: AppColors.info),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Payment is held securely in escrow',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.info),
                    ),
                  ),
                ],
              ),
            ),
          ],

          if (payment.influencerPayout != null && payment.status == PaymentStatus.released) ...[
            const SizedBox(height: 12),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Platform Fee (10%)',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                ),
                Text(
                  '-\$${payment.platformFee?.toStringAsFixed(2) ?? '0.00'}',
                  style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Your Payout',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
                Text(
                  '\$${payment.influencerPayout!.toStringAsFixed(2)}',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.success,
                  ),
                ),
              ],
            ),
          ],

          if (payment.status == PaymentStatus.failed && payment.failureReason != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: AppRadius.button,
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.alertCircle, size: 18, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      payment.failureReason!,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildStatusBadge(PaymentStatus status) {
    final (label, badgeStatus) = switch (status) {
      PaymentStatus.pending => ('Pending', BadgeStatus.warning),
      PaymentStatus.escrowHeld => ('In Escrow', BadgeStatus.info),
      PaymentStatus.released => ('Paid', BadgeStatus.success),
      PaymentStatus.refunded => ('Refunded', BadgeStatus.neutral),
      PaymentStatus.failed => ('Failed', BadgeStatus.error),
    };

    return StatusBadge(label: label, status: badgeStatus);
  }

  (IconData, Color, Color) _getStatusStyle(PaymentStatus status) {
    return switch (status) {
      PaymentStatus.pending => (LucideIcons.clock, AppColors.warning, AppColors.warningLight),
      PaymentStatus.escrowHeld => (LucideIcons.lock, AppColors.info, AppColors.infoLight),
      PaymentStatus.released => (LucideIcons.checkCircle, AppColors.success, AppColors.successLight),
      PaymentStatus.refunded => (LucideIcons.refreshCw, AppColors.gray600, AppColors.gray100),
      PaymentStatus.failed => (LucideIcons.xCircle, AppColors.error, AppColors.errorLight),
    };
  }
}
