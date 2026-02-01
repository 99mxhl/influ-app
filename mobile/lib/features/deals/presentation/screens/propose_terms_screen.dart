import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/enums.dart';
import '../../../../shared/utils/validators.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../data/models/deal.dart';
import '../../providers/deals_provider.dart';

class ProposeTermsScreen extends ConsumerStatefulWidget {
  final String dealId;

  const ProposeTermsScreen({
    super.key,
    required this.dealId,
  });

  @override
  ConsumerState<ProposeTermsScreen> createState() => _ProposeTermsScreenState();
}

class _ProposeTermsScreenState extends ConsumerState<ProposeTermsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _notesController = TextEditingController();
  final List<_DeliverableEntry> _deliverables = [];
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _addDeliverable();
  }

  @override
  void dispose() {
    _amountController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _addDeliverable() {
    setState(() {
      _deliverables.add(_DeliverableEntry());
    });
  }

  void _removeDeliverable(int index) {
    if (_deliverables.length > 1) {
      setState(() {
        _deliverables.removeAt(index);
      });
    }
  }

  Future<void> _handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    if (_deliverables.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please add at least one deliverable')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final deliverables = _deliverables.map((entry) {
        return DeliverableSpec(
          platform: entry.platform,
          contentType: entry.contentType,
          quantity: entry.quantity,
          description: entry.description.isNotEmpty ? entry.description : null,
        );
      }).toList();

      final request = ProposeTermsRequest(
        amount: double.parse(_amountController.text),
        deliverables: deliverables,
        notes: _notesController.text.isNotEmpty ? _notesController.text : null,
      );

      await ref.read(dealsProvider.notifier).proposeTerms(widget.dealId, request);
      ref.invalidate(dealByIdProvider(widget.dealId));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Terms proposed successfully!'),
            backgroundColor: Colors.green,
          ),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(e.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
        title: const Text('Propose Terms'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Amount',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _amountController,
                label: 'Proposed Amount (\$)',
                keyboardType: TextInputType.number,
                validator: (value) =>
                    Validators.positiveNumber(value, 'Amount'),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Deliverables',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  TextButton.icon(
                    onPressed: _addDeliverable,
                    icon: const Icon(Icons.add),
                    label: const Text('Add'),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              ..._deliverables.asMap().entries.map((entry) {
                final index = entry.key;
                final deliverable = entry.value;
                return _DeliverableCard(
                  key: ValueKey(deliverable.hashCode),
                  entry: deliverable,
                  onRemove: _deliverables.length > 1
                      ? () => _removeDeliverable(index)
                      : null,
                  onChanged: () => setState(() {}),
                );
              }),
              const SizedBox(height: 24),
              Text(
                'Notes (optional)',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 12),
              AppTextField(
                controller: _notesController,
                label: 'Additional notes or requirements',
                maxLines: 3,
                textCapitalization: TextCapitalization.sentences,
              ),
              const SizedBox(height: 32),
              AppButton(
                text: 'Submit Proposal',
                onPressed: _handleSubmit,
                isLoading: _isLoading,
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}

class _DeliverableEntry {
  Platform platform = Platform.instagram;
  ContentType contentType = ContentType.post;
  int quantity = 1;
  String description = '';
}

class _DeliverableCard extends StatelessWidget {
  final _DeliverableEntry entry;
  final VoidCallback? onRemove;
  final VoidCallback onChanged;

  const _DeliverableCard({
    super.key,
    required this.entry,
    this.onRemove,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  'Deliverable',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                if (onRemove != null)
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: onRemove,
                    visualDensity: VisualDensity.compact,
                  ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: DropdownButtonFormField<Platform>(
                    value: entry.platform,
                    decoration: const InputDecoration(
                      labelText: 'Platform',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: Platform.values.map((platform) {
                      return DropdownMenuItem(
                        value: platform,
                        child: Text(platform.displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        entry.platform = value;
                        onChanged();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: DropdownButtonFormField<ContentType>(
                    value: entry.contentType,
                    decoration: const InputDecoration(
                      labelText: 'Type',
                      contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    ),
                    items: ContentType.values.map((type) {
                      return DropdownMenuItem(
                        value: type,
                        child: Text(type.displayName),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        entry.contentType = value;
                        onChanged();
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Quantity:'),
                const SizedBox(width: 12),
                IconButton(
                  icon: const Icon(Icons.remove),
                  onPressed: entry.quantity > 1
                      ? () {
                          entry.quantity--;
                          onChanged();
                        }
                      : null,
                ),
                Text(
                  '${entry.quantity}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    entry.quantity++;
                    onChanged();
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
