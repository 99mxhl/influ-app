import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/widgets/widgets.dart';

/// Onboarding data
class _OnboardingSlide {
  final String title;
  final String description;
  final Widget icon;

  const _OnboardingSlide({
    required this.title,
    required this.description,
    required this.icon,
  });
}

/// Onboarding screen matching Figma design 1:1
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<_OnboardingSlide> _slides = [
    _OnboardingSlide(
      title: 'Find Perfect Collaborations',
      description: 'Browse campaigns that match your niche and audience',
      icon: _OnboardingIcon(
        child: Icon(
          LucideIcons.check,
          color: Colors.white,
          size: 48,
        ),
      ),
    ),
    _OnboardingSlide(
      title: 'Negotiate With Confidence',
      description: 'Chat-based deals with clear terms and expectations',
      icon: _OnboardingIcon(
        child: Icon(
          LucideIcons.messageSquare,
          color: Colors.white,
          size: 48,
        ),
      ),
    ),
    _OnboardingSlide(
      title: 'Secure Payments, Always',
      description: 'Funds held in escrow until you deliver and get approved',
      icon: _OnboardingIcon(
        child: Icon(
          LucideIcons.shield,
          color: Colors.white,
          size: 48,
        ),
      ),
    ),
    _OnboardingSlide(
      title: 'Ready to Start?',
      description: 'Join thousands of creators and brands already collaborating',
      icon: _OnboardingIcon(
        child: Icon(
          LucideIcons.users,
          color: Colors.white,
          size: 48,
        ),
      ),
    ),
  ];

  bool get _isLastSlide => _currentPage == _slides.length - 1;

  void _handleNext() {
    if (_isLastSlide) {
      _handleGetStarted();
    } else {
      _pageController.nextPage(
        duration: AppDurations.normal,
        curve: Curves.easeInOut,
      );
    }
  }

  void _handleSkip() {
    _pageController.animateToPage(
      _slides.length - 1,
      duration: AppDurations.normal,
      curve: Curves.easeInOut,
    );
  }

  void _handleGetStarted() {
    // TODO: Save onboarding seen flag
    context.go(AppRoutes.register);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!_isLastSlide)
                    TextButton(
                      onPressed: _handleSkip,
                      child: Text(
                        'Skip',
                        style: AppTypography.body.copyWith(
                          color: AppColors.gray600,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Page content
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                itemCount: _slides.length,
                itemBuilder: (context, index) {
                  final slide = _slides[index];
                  return Padding(
                    padding: AppSpacing.page,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        slide.icon,
                        const SizedBox(height: 32),
                        Text(
                          slide.title,
                          style: AppTypography.displayMedium.copyWith(
                            color: AppColors.gray900,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        AppSpacing.gapV4,
                        Text(
                          slide.description,
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.gray600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Bottom section
            Padding(
              padding: AppSpacing.page,
              child: Column(
                children: [
                  // Pagination dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _slides.length,
                      (index) => GestureDetector(
                        onTap: () {
                          _pageController.animateToPage(
                            index,
                            duration: AppDurations.normal,
                            curve: Curves.easeInOut,
                          );
                        },
                        child: AnimatedContainer(
                          duration: AppDurations.fast,
                          margin: const EdgeInsets.symmetric(horizontal: 4),
                          width: _currentPage == index ? 24 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: _currentPage == index
                                ? AppColors.primary
                                : AppColors.gray300,
                            borderRadius: AppRadius.radiusFull,
                          ),
                        ),
                      ),
                    ),
                  ),
                  AppSpacing.gapV6,

                  // Action button
                  AppButton(
                    text: _isLastSlide ? 'Get Started' : 'Next',
                    onPressed: _handleNext,
                    suffixIcon: Icon(LucideIcons.chevronRight),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Onboarding icon with gradient circle
class _OnboardingIcon extends StatelessWidget {
  final Widget child;

  const _OnboardingIcon({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 192,
      height: 192,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary.withOpacity(0.2),
            AppColors.escrow.withOpacity(0.2),
          ],
        ),
      ),
      child: Center(
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            gradient: AppColors.gradientPrimary,
            shape: BoxShape.circle,
          ),
          child: Center(child: child),
        ),
      ),
    );
  }
}
