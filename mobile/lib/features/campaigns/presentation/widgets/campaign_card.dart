import 'package:flutter/material.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/utils/extensions.dart';
import '../../../../shared/widgets/platform_badge.dart';
import '../../data/models/campaign.dart';

class CampaignCard extends StatelessWidget {
  final Campaign campaign;
  final VoidCallback? onTap;

  const CampaignCard({
    super.key,
    required this.campaign,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campaign name (bold, gray-900)
              Text(
                campaign.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gray900,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              // Brand name (gray-500)
              if (campaign.clientName != null) ...[
                const SizedBox(height: 4),
                Text(
                  campaign.clientName!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.gray500,
                  ),
                ),
              ],
              // Platform badges (4px gap)
              if (campaign.platforms.isNotEmpty) ...[
                const SizedBox(height: 8),
                PlatformBadgeRow(platforms: campaign.platforms),
              ],
              // Budget range (primary color)
              const SizedBox(height: 8),
              Text(
                '${campaign.budgetMin.formatCurrency()} - ${campaign.budgetMax.formatCurrency()}',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
              // Description snippet (gray-600)
              if (campaign.description != null) ...[
                const SizedBox(height: 8),
                Text(
                  campaign.description!,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.gray600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
              // View Details button
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: onTap,
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
                child: const Text('View Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
