import 'package:flutter/material.dart';

import '../../../../shared/models/enums.dart';
import '../../../../shared/utils/extensions.dart';
import '../../data/models/deal.dart';

class TermsCard extends StatelessWidget {
  final DealTerms terms;
  final bool isCurrentUserProposer;
  final VoidCallback? onAccept;
  final VoidCallback? onReject;
  final VoidCallback? onCounterOffer;
  final bool showActions;

  const TermsCard({
    super.key,
    required this.terms,
    required this.isCurrentUserProposer,
    this.onAccept,
    this.onReject,
    this.onCounterOffer,
    this.showActions = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isPending = terms.status == DealTermsStatus.proposed;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Terms v${terms.version}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                _TermsStatusBadge(status: terms.status),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(
                  Icons.attach_money,
                  size: 20,
                  color: colorScheme.primary,
                ),
                const SizedBox(width: 4),
                Text(
                  terms.amount.formatCurrency(),
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                      ),
                ),
              ],
            ),
            if (terms.deliverables.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Deliverables',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 8),
              ...terms.deliverables.map((deliverable) => Padding(
                    padding: const EdgeInsets.only(bottom: 4),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle_outline,
                          size: 16,
                          color: colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${deliverable.quantity}x ${deliverable.contentType.displayName} on ${deliverable.platform.displayName}',
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  )),
            ],
            if (terms.notes != null && terms.notes!.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                'Notes',
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                terms.notes!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            ],
            const SizedBox(height: 8),
            Text(
              isCurrentUserProposer ? 'You proposed' : 'Proposed by partner',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: colorScheme.onSurfaceVariant,
                    fontStyle: FontStyle.italic,
                  ),
            ),
            if (terms.createdAt != null)
              Text(
                terms.createdAt!.formatRelative(),
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurfaceVariant,
                    ),
              ),
            if (showActions && isPending && !isCurrentUserProposer) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onReject,
                      child: const Text('Reject'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: onCounterOffer,
                      child: const Text('Counter'),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: FilledButton(
                      onPressed: onAccept,
                      child: const Text('Accept'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _TermsStatusBadge extends StatelessWidget {
  final DealTermsStatus status;

  const _TermsStatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = _getColors(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status.displayName,
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
              color: color,
              fontWeight: FontWeight.w600,
            ),
      ),
    );
  }

  (Color, Color) _getColors(DealTermsStatus status) {
    switch (status) {
      case DealTermsStatus.proposed:
        return (Colors.orange.shade700, Colors.orange.shade50);
      case DealTermsStatus.accepted:
        return (Colors.green.shade700, Colors.green.shade50);
      case DealTermsStatus.rejected:
        return (Colors.red.shade700, Colors.red.shade50);
      case DealTermsStatus.superseded:
        return (Colors.grey.shade600, Colors.grey.shade200);
    }
  }
}
