import 'package:flutter/material.dart';

import '../../../../shared/models/enums.dart';

class CampaignFilters extends StatelessWidget {
  final CampaignStatus? selectedStatus;
  final Platform? selectedPlatform;
  final ValueChanged<CampaignStatus?>? onStatusChanged;
  final ValueChanged<Platform?>? onPlatformChanged;

  const CampaignFilters({
    super.key,
    this.selectedStatus,
    this.selectedPlatform,
    this.onStatusChanged,
    this.onPlatformChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          _FilterChip(
            label: selectedStatus?.displayName ?? 'Status',
            isSelected: selectedStatus != null,
            onTap: () => _showStatusPicker(context),
          ),
          const SizedBox(width: 8),
          _FilterChip(
            label: selectedPlatform?.displayName ?? 'Platform',
            isSelected: selectedPlatform != null,
            onTap: () => _showPlatformPicker(context),
          ),
          if (selectedStatus != null || selectedPlatform != null) ...[
            const SizedBox(width: 8),
            ActionChip(
              label: const Text('Clear'),
              onPressed: () {
                onStatusChanged?.call(null);
                onPlatformChanged?.call(null);
              },
            ),
          ],
        ],
      ),
    );
  }

  void _showStatusPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Statuses'),
              trailing: selectedStatus == null
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                onStatusChanged?.call(null);
                Navigator.pop(context);
              },
            ),
            ...CampaignStatus.values.map((status) => ListTile(
                  title: Text(status.displayName),
                  trailing: selectedStatus == status
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    onStatusChanged?.call(status);
                    Navigator.pop(context);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showPlatformPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('All Platforms'),
              trailing: selectedPlatform == null
                  ? const Icon(Icons.check)
                  : null,
              onTap: () {
                onPlatformChanged?.call(null);
                Navigator.pop(context);
              },
            ),
            ...Platform.values.map((platform) => ListTile(
                  title: Text(platform.displayName),
                  trailing: selectedPlatform == platform
                      ? const Icon(Icons.check)
                      : null,
                  onTap: () {
                    onPlatformChanged?.call(platform);
                    Navigator.pop(context);
                  },
                )),
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
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onTap(),
      showCheckmark: false,
    );
  }
}
