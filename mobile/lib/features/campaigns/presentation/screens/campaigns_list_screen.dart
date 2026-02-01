import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/app_router.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/error_widget.dart';
import '../../../../shared/widgets/loading_indicator.dart';
import '../../../auth/providers/auth_provider.dart';
import '../../data/models/campaign.dart';
import '../../providers/campaigns_provider.dart';
import '../widgets/campaign_card.dart';

class CampaignsListScreen extends ConsumerStatefulWidget {
  const CampaignsListScreen({super.key});

  @override
  ConsumerState<CampaignsListScreen> createState() =>
      _CampaignsListScreenState();
}

class _CampaignsListScreenState extends ConsumerState<CampaignsListScreen> {
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final authState = ref.read(authStateProvider);
    final isClient = authState.user?.type == UserType.client;

    if (!isClient &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      ref.read(campaignsProvider.notifier).loadMore();
    }
  }

  Future<void> _refresh() async {
    final authState = ref.read(authStateProvider);
    final isClient = authState.user?.type == UserType.client;

    if (isClient) {
      await ref.read(myCampaignsProvider.notifier).refresh();
    } else {
      await ref.read(campaignsProvider.notifier).refresh();
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final isClient = authState.user?.type == UserType.client;

    // Watch the appropriate provider based on user type
    final myCampaignsState = ref.watch(myCampaignsProvider);
    final allCampaignsState = ref.watch(campaignsProvider);

    final campaigns = isClient ? myCampaignsState.campaigns : allCampaignsState.campaigns;
    final isLoading = isClient ? myCampaignsState.isLoading : allCampaignsState.isLoading;
    final hasLoaded = isClient ? myCampaignsState.hasLoaded : allCampaignsState.hasLoaded;
    final error = isClient ? myCampaignsState.error : allCampaignsState.error;
    final isLoadingMore = isClient ? false : allCampaignsState.isLoadingMore;

    // Trigger load if needed (after auth is ready and hasn't loaded yet)
    if (authState.isAuthenticated && !isLoading && !hasLoaded) {
      Future.microtask(() {
        if (isClient) {
          ref.read(myCampaignsProvider.notifier).loadMyCampaigns();
        } else {
          ref.read(campaignsProvider.notifier).loadCampaigns();
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(isClient ? 'My Campaigns' : 'Campaigns'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: _buildBody(
        campaigns: campaigns,
        isLoading: isLoading,
        error: error,
        isLoadingMore: isLoadingMore,
        isClient: isClient,
      ),
      floatingActionButton: isClient
          ? FloatingActionButton.extended(
              onPressed: () => context.push(AppRoutes.createCampaign),
              icon: const Icon(Icons.add),
              label: const Text('New Campaign'),
            )
          : null,
    );
  }

  Widget _buildBody({
    required List<Campaign> campaigns,
    required bool isLoading,
    required String? error,
    required bool isLoadingMore,
    required bool isClient,
  }) {
    if (isLoading && campaigns.isEmpty) {
      return const Center(child: LoadingIndicator());
    }

    if (error != null && campaigns.isEmpty) {
      return AppErrorWidget(
        message: error,
        onRetry: _refresh,
      );
    }

    if (campaigns.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.campaign_outlined,
              size: 64,
              color: Theme.of(context).colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No campaigns yet',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              isClient
                  ? 'Tap + to create your first campaign'
                  : 'Check back later for new opportunities',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _refresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.only(top: 8, bottom: 88),
        itemCount: campaigns.length + (isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= campaigns.length) {
            return const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final campaign = campaigns[index];
          return CampaignCard(
            campaign: campaign,
            onTap: () => context.push('/campaigns/${campaign.id}'),
          );
        },
      ),
    );
  }
}
