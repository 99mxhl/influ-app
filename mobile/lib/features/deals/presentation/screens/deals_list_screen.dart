import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../data/models/deal.dart';
import '../../providers/deals_provider.dart';
import '../widgets/deal_card.dart';

class DealsListScreen extends ConsumerStatefulWidget {
  const DealsListScreen({super.key});

  @override
  ConsumerState<DealsListScreen> createState() => _DealsListScreenState();
}

class _DealsListScreenState extends ConsumerState<DealsListScreen>
    with SingleTickerProviderStateMixin {
  final _activeScrollController = ScrollController();
  final _cancelledScrollController = ScrollController();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _activeScrollController.addListener(_onActiveScroll);
    _cancelledScrollController.addListener(_onCancelledScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _activeScrollController.dispose();
    _cancelledScrollController.dispose();
    super.dispose();
  }

  void _onActiveScroll() {
    if (_activeScrollController.position.pixels >=
        _activeScrollController.position.maxScrollExtent - 200) {
      ref.read(dealsProvider.notifier).loadMore();
    }
  }

  void _onCancelledScroll() {
    if (_cancelledScrollController.position.pixels >=
        _cancelledScrollController.position.maxScrollExtent - 200) {
      ref.read(dealsProvider.notifier).loadMore();
    }
  }

  List<Deal> _filterActiveDeals(List<Deal> deals) {
    return deals.where((deal) => deal.status != DealStatus.cancelled).toList();
  }

  List<Deal> _filterCancelledDeals(List<Deal> deals) {
    return deals.where((deal) => deal.status == DealStatus.cancelled).toList();
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final dealsState = ref.watch(dealsProvider);

    if (authState.isAuthenticated && !dealsState.isLoading && !dealsState.hasLoaded) {
      Future.microtask(() {
        ref.read(dealsProvider.notifier).loadDeals();
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Deals'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(dealsProvider.notifier).refresh(),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Active'),
            Tab(text: 'Cancelled'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildDealsList(
            dealsState,
            _filterActiveDeals(dealsState.deals),
            _activeScrollController,
            emptyIcon: Icons.handshake_outlined,
            emptyTitle: 'No active deals',
            emptySubtitle: 'Apply to campaigns to start making deals',
          ),
          _buildDealsList(
            dealsState,
            _filterCancelledDeals(dealsState.deals),
            _cancelledScrollController,
            emptyIcon: Icons.cancel_outlined,
            emptyTitle: 'No cancelled deals',
            emptySubtitle: 'Cancelled deals will appear here',
          ),
        ],
      ),
    );
  }

  Widget _buildDealsList(
    DealsState state,
    List<Deal> deals,
    ScrollController scrollController, {
    required IconData emptyIcon,
    required String emptyTitle,
    required String emptySubtitle,
  }) {
    if (state.isLoading && state.deals.isEmpty) {
      return const Center(child: LoadingIndicator());
    }

    if (state.error != null && state.deals.isEmpty) {
      return AppErrorWidget(
        message: state.error!,
        onRetry: () => ref.read(dealsProvider.notifier).refresh(),
      );
    }

    if (deals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              emptyIcon,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              emptyTitle,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              emptySubtitle,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: () => ref.read(dealsProvider.notifier).refresh(),
      child: ListView.builder(
        controller: scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: deals.length + (state.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= deals.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final deal = deals[index];
          return DealCard(
            deal: deal,
            onTap: () => context.push('/deals/${deal.id}'),
          );
        },
      ),
    );
  }
}
