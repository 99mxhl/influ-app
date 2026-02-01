import 'package:flutter/material.dart';

import '../../../../shared/models/enums.dart';

class DealStatusBadge extends StatelessWidget {
  final DealStatus status;
  final bool large;

  const DealStatusBadge({
    super.key,
    required this.status,
    this.large = false,
  });

  @override
  Widget build(BuildContext context) {
    final (color, bgColor) = _getColors(status);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: large ? 12 : 8,
        vertical: large ? 6 : 4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(large ? 16 : 12),
      ),
      child: Text(
        status.displayName,
        style: (large
                ? Theme.of(context).textTheme.labelMedium
                : Theme.of(context).textTheme.labelSmall)
            ?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  (Color, Color) _getColors(DealStatus status) {
    switch (status) {
      case DealStatus.idle:
        return (Colors.grey.shade700, Colors.grey.shade200);
      case DealStatus.invited:
        return (Colors.purple.shade700, Colors.purple.shade50);
      case DealStatus.applied:
        return (Colors.blue.shade700, Colors.blue.shade50);
      case DealStatus.negotiating:
        return (Colors.orange.shade700, Colors.orange.shade50);
      case DealStatus.termsAccepted:
        return (Colors.teal.shade700, Colors.teal.shade50);
      case DealStatus.active:
        return (Colors.green.shade700, Colors.green.shade50);
      case DealStatus.contentSubmitted:
        return (Colors.indigo.shade700, Colors.indigo.shade50);
      case DealStatus.completed:
        return (Colors.green.shade800, Colors.green.shade100);
      case DealStatus.disputed:
        return (Colors.red.shade700, Colors.red.shade50);
      case DealStatus.cancelled:
        return (Colors.grey.shade600, Colors.grey.shade200);
    }
  }
}
