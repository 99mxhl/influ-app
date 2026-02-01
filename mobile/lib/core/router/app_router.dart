import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/onboarding_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/providers/auth_provider.dart';
import '../../features/campaigns/presentation/screens/campaign_detail_screen.dart';
import '../../features/campaigns/presentation/screens/campaigns_list_screen.dart';
import '../../features/campaigns/presentation/screens/create_campaign_screen.dart';
import '../../features/chat/presentation/screens/chat_detail_screen.dart';
import '../../features/chat/presentation/screens/chat_list_screen.dart';
import '../../features/deals/presentation/screens/deal_detail_screen.dart';
import '../../features/deals/presentation/screens/deals_list_screen.dart';
import '../../features/deals/presentation/screens/propose_terms_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/notifications/presentation/screens/notifications_screen.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/discover/presentation/screens/discover_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../shared/models/enums.dart';
import '../../shared/widgets/widgets.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String login = '/login';
  static const String register = '/register';
  static const String home = '/home';
  static const String campaigns = '/campaigns';
  static const String campaignDetail = '/campaigns/:id';
  static const String createCampaign = '/campaigns/create';
  static const String discover = '/discover';
  static const String deals = '/deals';
  static const String dealDetail = '/deals/:id';
  static const String proposeTerms = '/deals/:id/terms';
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';
  static const String settings = '/settings';
  static const String notifications = '/notifications';
  static const String messages = '/messages';
  static const String messageDetail = '/messages/:id';
}

/// Listenable that notifies when auth state changes
class AuthStateNotifier extends ChangeNotifier {
  ProviderSubscription? _subscription;

  AuthStateNotifier(Ref ref) {
    _subscription = ref.listen(authStateProvider, (_, __) => notifyListeners());
  }

  @override
  void dispose() {
    _subscription?.close();
    super.dispose();
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final authNotifier = AuthStateNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    refreshListenable: authNotifier,
    redirect: (context, state) {
      final authState = ref.read(authStateProvider);
      final isLoggedIn = authState.isAuthenticated;
      final isLoading = authState.isLoading;
      final currentPath = state.uri.path;

      // Don't redirect while loading
      if (isLoading) {
        return null;
      }

      // Public routes that don't require auth
      final publicRoutes = [
        AppRoutes.splash,
        AppRoutes.onboarding,
        AppRoutes.login,
        AppRoutes.register,
      ];

      final isPublicRoute = publicRoutes.contains(currentPath);

      // If not logged in and trying to access protected route
      if (!isLoggedIn && !isPublicRoute) {
        return AppRoutes.login;
      }

      // If logged in and on login/register, go to home
      if (isLoggedIn &&
          (currentPath == AppRoutes.login || currentPath == AppRoutes.register)) {
        return AppRoutes.home;
      }

      // CLIENT-only route check
      if (currentPath == AppRoutes.createCampaign) {
        if (ref.read(authStateProvider).user?.type != UserType.client) {
          return AppRoutes.home;
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScaffold(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.campaigns,
            builder: (context, state) => const CampaignsListScreen(),
          ),
          GoRoute(
            path: AppRoutes.discover,
            builder: (context, state) => const DiscoverScreen(),
          ),
          GoRoute(
            path: AppRoutes.messages,
            builder: (context, state) => const ChatListScreen(),
          ),
          GoRoute(
            path: AppRoutes.deals,
            builder: (context, state) => const DealsListScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) => const ProfileScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.createCampaign,
        builder: (context, state) => const CreateCampaignScreen(),
      ),
      GoRoute(
        path: AppRoutes.campaignDetail,
        builder: (context, state) => CampaignDetailScreen(
          campaignId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.dealDetail,
        builder: (context, state) => DealDetailScreen(
          dealId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.proposeTerms,
        builder: (context, state) => ProposeTermsScreen(
          dealId: state.pathParameters['id']!,
        ),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: AppRoutes.messageDetail,
        builder: (context, state) => ChatDetailScreen(
          dealId: state.pathParameters['id']!,
        ),
      ),
    ],
  );
});

/// Main scaffold with bottom navigation matching Figma design
class MainScaffold extends ConsumerWidget {
  final Widget child;

  const MainScaffold({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authStateProvider);
    final userType = authState.user?.type ?? UserType.influencer;

    return Scaffold(
      body: child,
      bottomNavigationBar: InfluBottomNavBar(
        userType: userType,
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context, userType),
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.path;
    if (location == AppRoutes.home) return 0;
    if (location.startsWith(AppRoutes.campaigns) ||
        location.startsWith(AppRoutes.discover)) return 1;
    if (location.startsWith(AppRoutes.messages)) return 2;
    if (location.startsWith(AppRoutes.deals)) return 3;
    if (location.startsWith(AppRoutes.profile)) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context, UserType userType) {
    // For influencers: Home, Discover, Messages, Applications, Profile
    // For clients: Home, Campaigns, Messages, Deals, Profile
    switch (index) {
      case 0:
        context.go(AppRoutes.home);
        break;
      case 1:
        // Influencers see Discover (browse all campaigns), Clients see their Campaigns
        if (userType == UserType.influencer) {
          context.go(AppRoutes.discover);
        } else {
          context.go(AppRoutes.campaigns);
        }
        break;
      case 2:
        context.go(AppRoutes.messages);
        break;
      case 3:
        // Both see their deals/applications
        context.go(AppRoutes.deals);
        break;
      case 4:
        context.go(AppRoutes.profile);
        break;
    }
  }
}
