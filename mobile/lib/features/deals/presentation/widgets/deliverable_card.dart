import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../files/data/models/file_upload.dart' as file_upload;
import '../../../files/presentation/widgets/file_picker_button.dart';
import '../../data/models/deliverable.dart';
import '../../providers/deliverable_provider.dart';

class DeliverableCard extends ConsumerStatefulWidget {
  final String dealId;
  final Deliverable deliverable;
  final bool isInfluencer;

  const DeliverableCard({
    super.key,
    required this.dealId,
    required this.deliverable,
    required this.isInfluencer,
  });

  @override
  ConsumerState<DeliverableCard> createState() => _DeliverableCardState();
}

class _DeliverableCardState extends ConsumerState<DeliverableCard> {
  bool _isSubmitting = false;

  Future<void> _handleSubmit(String contentUrl) async {
    setState(() => _isSubmitting = true);

    try {
      await ref.read(deliverablesProvider(widget.dealId).notifier).submitDeliverable(
            widget.deliverable.id,
            SubmitDeliverableRequest(contentUrl: contentUrl),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Content submitted successfully')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to submit: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  Future<void> _handleApprove() async {
    try {
      await ref
          .read(deliverablesProvider(widget.dealId).notifier)
          .approveDeliverable(widget.deliverable.id);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Deliverable approved')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to approve: $e')),
        );
      }
    }
  }

  Future<void> _handleReject() async {
    final reason = await showDialog<String>(
      context: context,
      builder: (context) => _RejectDialog(),
    );

    if (reason == null || reason.isEmpty) return;

    try {
      await ref.read(deliverablesProvider(widget.dealId).notifier).rejectDeliverable(
            widget.deliverable.id,
            RejectDeliverableRequest(reason: reason),
          );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Revision requested')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final deliverable = widget.deliverable;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.gray200),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Row(
            children: [
              Icon(
                _getPlatformIcon(deliverable.platform),
                size: 20,
                color: AppColors.gray600,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '${deliverable.platform.displayName} - ${deliverable.contentType.displayName}',
                  style: AppTypography.body.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.gray900,
                  ),
                ),
              ),
              _buildStatusBadge(deliverable.status),
            ],
          ),

          if (deliverable.description != null) ...[
            const SizedBox(height: 8),
            Text(
              deliverable.description!,
              style: AppTypography.bodySmall.copyWith(color: AppColors.gray600),
            ),
          ],

          // Content preview
          if (deliverable.contentUrl != null) ...[
            const SizedBox(height: 12),
            _buildContentPreview(),
          ],

          // Rejection reason
          if (deliverable.status == DeliverableStatus.rejected &&
              deliverable.rejectionReason != null) ...[
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.errorLight,
                borderRadius: AppRadius.button,
              ),
              child: Row(
                children: [
                  Icon(LucideIcons.alertCircle, size: 16, color: AppColors.error),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      deliverable.rejectionReason!,
                      style: AppTypography.bodySmall.copyWith(color: AppColors.error),
                    ),
                  ),
                ],
              ),
            ),
          ],

          // Actions
          const SizedBox(height: 16),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildStatusBadge(DeliverableStatus status) {
    final (label, badgeStatus) = switch (status) {
      DeliverableStatus.pending => ('Pending', BadgeStatus.warning),
      DeliverableStatus.submitted => ('Submitted', BadgeStatus.info),
      DeliverableStatus.approved => ('Approved', BadgeStatus.success),
      DeliverableStatus.rejected => ('Rejected', BadgeStatus.error),
      DeliverableStatus.revisionRequested => ('Revision Needed', BadgeStatus.warning),
    };

    return StatusBadge(label: label, status: badgeStatus, size: BadgeSize.sm);
  }

  Widget _buildContentPreview() {
    final deliverable = widget.deliverable;
    final isVideo = deliverable.contentType == ContentType.video;

    return ClipRRect(
      borderRadius: AppRadius.button,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl: deliverable.thumbnailUrl ?? deliverable.contentUrl!,
              fit: BoxFit.cover,
              placeholder: (_, __) => Container(color: AppColors.gray200),
              errorWidget: (_, __, ___) => Container(
                color: AppColors.gray200,
                child: Icon(LucideIcons.image, color: AppColors.gray400),
              ),
            ),
            if (isVideo)
              Center(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(LucideIcons.play, color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildActions() {
    final deliverable = widget.deliverable;

    // Influencer actions
    if (widget.isInfluencer) {
      if (deliverable.status == DeliverableStatus.pending ||
          deliverable.status == DeliverableStatus.rejected ||
          deliverable.status == DeliverableStatus.revisionRequested) {
        return FilePickerButton(
          fileType: deliverable.contentType == ContentType.video
              ? file_upload.FileType.video
              : file_upload.FileType.image,
          onUploadComplete: _handleSubmit,
          onError: (error) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Upload failed: $error')),
            );
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: AppRadius.button,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(LucideIcons.upload, size: 18, color: Colors.white),
                const SizedBox(width: 8),
                Text(
                  deliverable.status == DeliverableStatus.pending
                      ? 'Upload Content'
                      : 'Upload Revision',
                  style: AppTypography.body.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

    // Client actions
    if (!widget.isInfluencer && deliverable.status == DeliverableStatus.submitted) {
      return Row(
        children: [
          Expanded(
            child: OutlinedButton.icon(
              onPressed: _handleReject,
              icon: Icon(LucideIcons.x, size: 18),
              label: const Text('Request Revision'),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: BorderSide(color: AppColors.error),
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: ElevatedButton.icon(
              onPressed: _handleApprove,
              icon: Icon(LucideIcons.check, size: 18),
              label: const Text('Approve'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }

  IconData _getPlatformIcon(Platform platform) {
    return switch (platform) {
      Platform.instagram => LucideIcons.instagram,
      Platform.tiktok => LucideIcons.music2,
      Platform.youtube => LucideIcons.youtube,
      Platform.twitter => LucideIcons.twitter,
      Platform.facebook => LucideIcons.facebook,
    };
  }
}

class _RejectDialog extends StatefulWidget {
  @override
  State<_RejectDialog> createState() => _RejectDialogState();
}

class _RejectDialogState extends State<_RejectDialog> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Request Revision'),
      content: TextField(
        controller: _controller,
        maxLines: 3,
        decoration: InputDecoration(
          hintText: 'Explain what needs to be changed...',
          border: OutlineInputBorder(borderRadius: AppRadius.button),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, _controller.text),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.error,
            foregroundColor: Colors.white,
          ),
          child: const Text('Request Revision'),
        ),
      ],
    );
  }
}
