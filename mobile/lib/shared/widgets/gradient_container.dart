import 'package:flutter/material.dart';

import '../../core/theme/theme.dart';

/// Container with primary gradient background
class GradientContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final Gradient? gradient;

  const GradientContainer({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? AppSpacing.p6,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.gradientPrimary,
        borderRadius: borderRadius ?? AppRadius.card,
      ),
      child: child,
    );
  }
}

/// Welcome card with gradient (for home screen)
class WelcomeCard extends StatelessWidget {
  final String greeting;
  final String name;
  final String? subtitle;

  const WelcomeCard({
    super.key,
    required this.greeting,
    required this.name,
    this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return GradientContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$greeting, $name!',
            style: AppTypography.h2.copyWith(
              color: Colors.white,
            ),
          ),
          if (subtitle != null) ...[
            AppSpacing.gapV1,
            Text(
              subtitle!,
              style: AppTypography.body.copyWith(
                color: Colors.white.withOpacity(0.9),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// Logo container with gradient
class LogoContainer extends StatelessWidget {
  final double size;
  final Widget child;
  final bool animate;

  const LogoContainer({
    super.key,
    this.size = 96,
    required this.child,
    this.animate = false,
  });

  @override
  Widget build(BuildContext context) {
    Widget container = Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: AppColors.gradientPrimary,
        borderRadius: AppRadius.logo,
      ),
      child: Center(child: child),
    );

    if (animate) {
      return _PulsingContainer(child: container);
    }
    return container;
  }
}

class _PulsingContainer extends StatefulWidget {
  final Widget child;

  const _PulsingContainer({required this.child});

  @override
  State<_PulsingContainer> createState() => _PulsingContainerState();
}

class _PulsingContainerState extends State<_PulsingContainer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Opacity(
          opacity: _animation.value,
          child: widget.child,
        );
      },
    );
  }
}
