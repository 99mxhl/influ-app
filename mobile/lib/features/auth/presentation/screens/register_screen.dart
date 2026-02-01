import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/router/app_router.dart';
import '../../../../core/theme/theme.dart';
import '../../../../shared/models/enums.dart';
import '../../../../shared/widgets/widgets.dart';
import '../../providers/auth_provider.dart';

/// Register screen matching Figma design 1:1
class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  UserType _userType = UserType.influencer;
  bool _agreeToTerms = false;
  bool _isLoading = false;
  String? _generalError;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Password validation
  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasUppercase => _passwordController.text.contains(RegExp(r'[A-Z]'));
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'\d'));
  bool get _isPasswordValid => _hasMinLength && _hasUppercase && _hasNumber;

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    if (!_isPasswordValid) {
      setState(() => _generalError = 'Password does not meet requirements');
      return;
    }

    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _generalError = 'Passwords do not match');
      return;
    }

    if (!_agreeToTerms) {
      setState(() => _generalError = 'You must agree to the terms');
      return;
    }

    setState(() {
      _isLoading = true;
      _generalError = null;
    });

    try {
      await ref.read(authStateProvider.notifier).register(
            email: _emailController.text.trim(),
            password: _passwordController.text,
            type: _userType,
            displayName: _nameController.text.trim().isNotEmpty
                ? _nameController.text.trim()
                : null,
          );

      if (mounted) {
        context.go(AppRoutes.home);
      }
    } catch (e) {
      if (mounted) {
        String errorMessage = 'Registration failed. Please try again.';
        if (e.toString().contains('email') && e.toString().contains('exists')) {
          errorMessage = 'An account with this email already exists';
        } else {
          errorMessage = e.toString();
        }
        setState(() => _generalError = errorMessage);
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
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: AppSpacing.page,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 24),

                // Logo
                Center(
                  child: LogoContainer(
                    size: 64,
                    child: Icon(
                      LucideIcons.users,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                ),
                AppSpacing.gapV4,

                // Heading
                Text(
                  'Create Account',
                  style: AppTypography.displayMedium.copyWith(
                    color: AppColors.gray900,
                  ),
                  textAlign: TextAlign.center,
                ),
                AppSpacing.gapV2,
                Text(
                  'Join as an influencer or brand',
                  style: AppTypography.body.copyWith(
                    color: AppColors.gray600,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                // User type toggle
                _UserTypeToggle(
                  selectedType: _userType,
                  onChanged: (type) => setState(() => _userType = type),
                ),
                AppSpacing.gapV4,

                // Name field
                AppTextField(
                  controller: _nameController,
                  label: 'Full Name',
                  hint: 'John Doe',
                  textCapitalization: TextCapitalization.words,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                ),
                AppSpacing.gapV4,

                // Email field
                AppTextField(
                  controller: _emailController,
                  label: 'Email',
                  hint: 'you@example.com',
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required';
                    }
                    if (!value.contains('@')) {
                      return 'Enter a valid email';
                    }
                    return null;
                  },
                ),
                AppSpacing.gapV4,

                // Password field
                PasswordTextField(
                  controller: _passwordController,
                  label: 'Password',
                  textInputAction: TextInputAction.next,
                  onChanged: (_) => setState(() {}),
                ),
                AppSpacing.gapV2,

                // Password requirements
                _PasswordRequirement(met: _hasMinLength, text: '8+ characters'),
                _PasswordRequirement(met: _hasUppercase, text: '1 uppercase letter'),
                _PasswordRequirement(met: _hasNumber, text: '1 number'),
                AppSpacing.gapV4,

                // Confirm password field
                PasswordTextField(
                  controller: _confirmPasswordController,
                  label: 'Confirm Password',
                  textInputAction: TextInputAction.done,
                  onEditingComplete: _handleRegister,
                ),
                AppSpacing.gapV4,

                // Terms checkbox
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: Checkbox(
                        value: _agreeToTerms,
                        onChanged: (value) =>
                            setState(() => _agreeToTerms = value ?? false),
                      ),
                    ),
                    AppSpacing.gapH3,
                    Expanded(
                      child: GestureDetector(
                        onTap: () =>
                            setState(() => _agreeToTerms = !_agreeToTerms),
                        child: Text.rich(
                          TextSpan(
                            text: 'I agree to the ',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.gray600,
                            ),
                            children: [
                              TextSpan(
                                text: 'Terms of Service',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const TextSpan(text: ' and '),
                              TextSpan(
                                text: 'Privacy Policy',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                // Error message
                if (_generalError != null) ...[
                  AppSpacing.gapV4,
                  ErrorBanner(
                    message: _generalError!,
                    onDismiss: () => setState(() => _generalError = null),
                  ),
                ],

                AppSpacing.gapV6,

                // Register button
                AppButton(
                  text: _isLoading ? 'Creating Account...' : 'Create Account',
                  onPressed: _handleRegister,
                  isLoading: _isLoading,
                ),

                AppSpacing.gapV6,

                // Login link
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: AppTypography.body.copyWith(
                        color: AppColors.gray600,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => context.go(AppRoutes.login),
                      child: Text(
                        'Log in',
                        style: AppTypography.link,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// User type toggle matching Figma design
class _UserTypeToggle extends StatelessWidget {
  final UserType selectedType;
  final ValueChanged<UserType> onChanged;

  const _UserTypeToggle({
    required this.selectedType,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: AppRadius.button,
      ),
      child: Row(
        children: [
          Expanded(
            child: _ToggleButton(
              label: "I'm an Influencer",
              isSelected: selectedType == UserType.influencer,
              onTap: () => onChanged(UserType.influencer),
            ),
          ),
          Expanded(
            child: _ToggleButton(
              label: "I'm a Brand",
              isSelected: selectedType == UserType.client,
              onTap: () => onChanged(UserType.client),
            ),
          ),
        ],
      ),
    );
  }
}

class _ToggleButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _ToggleButton({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppDurations.fast,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white : Colors.transparent,
          borderRadius: AppRadius.radiusMd,
          boxShadow: isSelected ? AppShadows.elevation1 : null,
        ),
        child: Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            color: isSelected ? AppColors.primary : AppColors.gray600,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

/// Password requirement indicator
class _PasswordRequirement extends StatelessWidget {
  final bool met;
  final String text;

  const _PasswordRequirement({
    required this.met,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(
            LucideIcons.check,
            size: 16,
            color: met ? AppColors.success : AppColors.gray500,
          ),
          AppSpacing.gapH2,
          Text(
            text,
            style: AppTypography.bodySmall.copyWith(
              color: met ? AppColors.success : AppColors.gray500,
            ),
          ),
        ],
      ),
    );
  }
}
