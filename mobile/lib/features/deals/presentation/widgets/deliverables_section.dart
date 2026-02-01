import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../providers/deliverable_provider.dart';
import 'deliverable_card.dart';

class DeliverablesSection extends ConsumerWidget {
  final String dealId;
  final String influencerId;

  const DeliverablesSection({
    super.key,
    required this.dealId,
    required this.influencerId,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final deliverablesAsync = ref.watch(deliverablesProvider(dealId));
    final currentUser = ref.watch(authStateProvider).user;
    final isInfluencer = currentUser?.id == influencerId;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(LucideIcons.package, size: 20, color: AppColors.gray700),
            const SizedBox(width: 8),
            Text(
              'Deliverables',
              style: AppTypography.h4.copyWith(color: AppColors.gray900),
            ),
          ],
        ),
        const SizedBox(height: 16),
        deliverablesAsync.when(
          loading: () => const Center(child: LoadingIndicator()),
          error: (error, _) => AppErrorWidget(
            message: error.toString(),
            onRetry: () =>
                ref.read(deliverablesProvider(dealId).notifier).refresh(),
          ),
          data: (deliverables) {
            if (deliverables.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.gray100,
                  borderRadius: AppRadius.card,
                ),
                child: Column(
                  children: [
                    Icon(
                      LucideIcons.inbox,
                      size: 48,
                      color: AppColors.gray400,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No deliverables yet',
                      style: AppTypography.body.copyWith(color: AppColors.gray600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Deliverables will appear once terms are accepted',
                      style: AppTypography.bodySmall.copyWith(color: AppColors.gray500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              );
            }

            return Column(
              children: deliverables.map((deliverable) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: DeliverableCard(
                    dealId: dealId,
                    deliverable: deliverable,
                    isInfluencer: isInfluencer,
                  ),
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }
}
