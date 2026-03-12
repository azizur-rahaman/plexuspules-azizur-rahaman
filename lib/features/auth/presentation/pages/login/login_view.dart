import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:plexuspules/config/app_router.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_bloc.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_event.dart';
import 'package:plexuspules/features/auth/presentation/bloc/login_state.dart';
import 'package:plexuspules/features/auth/presentation/widgets/login_email_field.dart';
import 'package:plexuspules/features/auth/presentation/widgets/login_footer.dart';
import 'package:plexuspules/features/auth/presentation/widgets/login_header.dart';
import 'package:plexuspules/features/auth/presentation/widgets/login_password_field.dart';

import '../../../../../../core/constants/app_sizes.dart';
import '../../../../../../core/widgets/primary_button.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late AnimationController _animationController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero)
        .animate(
          CurvedAnimation(
            parent: _animationController,
            curve: Curves.easeOutCubic,
          ),
        );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 300), () {
        if (mounted) _animationController.forward();
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginPressed(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      context.read<LoginBloc>().add(
        LoginSubmitted(
          email: _emailController.text.trim(),
          password: _passwordController.text,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          context.go(AppRouter.dashboard);
        } else if (state is LoginFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Theme.of(context).colorScheme.error,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppSizes.radiusMedium),
              ),
            ),
          );
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          color: Theme.of(context).scaffoldBackgroundColor,
          child: SafeArea(
            bottom: false,
            child: Stack(
              children: [
                // ── Brand Header ───────────────────────────────────────────
                const LoginHeader(),

                // ── Animated Form Sheet ────────────────────────────────────
                _LoginFormSheet(
                  slideAnimation: _slideAnimation,
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                  onLoginPressed: () => _onLoginPressed(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Animated bottom-sheet that holds the form — pure presentation, no BLoC
// ---------------------------------------------------------------------------

class _LoginFormSheet extends StatelessWidget {
  final Animation<Offset> slideAnimation;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback onLoginPressed;

  const _LoginFormSheet({
    required this.slideAnimation,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.onLoginPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: SlideTransition(
        position: slideAnimation,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.radiusCircular / 3),
              topRight: Radius.circular(AppSizes.radiusCircular / 3),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 20,
                offset: const Offset(0, -5),
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(
            AppSizes.p32,
            AppSizes.p40,
            AppSizes.p32,
            AppSizes.p40 + MediaQuery.of(context).padding.bottom,
          ),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome back',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                AppSizes.gap32,

                LoginEmailField(controller: emailController),
                AppSizes.gap24,

                LoginPasswordField(
                  controller: passwordController,
                  onSubmitted: onLoginPressed,
                ),
                AppSizes.gap32,

                // Sign In Button — watches BLoC for loading state
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return PrimaryButton(
                      text: 'Sign In',
                      isLoading: state is LoginLoading,
                      onPressed: onLoginPressed,
                    );
                  },
                ),
                AppSizes.gap24,

                LoginFooter(onCreateAccount: () {}),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
