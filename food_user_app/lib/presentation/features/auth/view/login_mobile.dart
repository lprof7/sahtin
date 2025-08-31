import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../viewmodel/login_cubit.dart';
import '../viewmodel/login_state.dart';
import '../../../shared/widgets/atoms/shared_button.dart';
import '../../../shared/widgets/molecules/form_field.dart';
import '../../../shared/widgets/atoms/shared_spacer.dart';
import '../../../shared/widgets/atoms/shared_text.dart';
import '../../../shared/themes/colors.dart';
import '../../../shared/themes/text_styles.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import '../../../shared/utils/validators.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../data/models/user.dart'; // Import User model

/// واجهة تسجيل الدخول للهواتف المحمولة
class LoginMobile extends StatefulWidget {
  const LoginMobile({Key? key}) : super(key: key);

  @override
  State<LoginMobile> createState() => _LoginMobileState();
}

class _LoginMobileState extends State<LoginMobile> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final l10n = AppLocalizations.of(context)!; // Remove AppLocalizations
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text(tr('loginTitle')), // Use tr('loginTitle')
        centerTitle: true,
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr('loginSuccess')), // Use tr('loginSuccess')
                backgroundColor: AppColors.success,
              ),
            );
            // التنقل إلى واجهة تحديد الموقع بعد نجاح تسجيل الدخول
            Navigator.of(
              context,
            ).pushReplacementNamed(AppRouter.setPositionRoute);
          } else if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.error,
              ),
            );
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // الشعار
                    const Center(
                      child: Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 120,
                        height: 120,
                      ),
                    ),
                    const SharedSpacer(size: 24),

                    // عنوان التطبيق
                    SharedText(
                      text: tr('appTitle'),
                      textAlign: TextAlign.center,
                      type: TextType.heading1,
                      color: AppColors.primary,
                    ),
                    const SharedSpacer(size: 8),

                    // وصف قصير
                    SharedText(
                      text: tr('appSlogan'),
                      textAlign: TextAlign.center,
                      type: TextType.bodyMedium,
                      color: AppColors.textBody,
                    ),
                    const SharedSpacer(size: 48),

                    // حقل البريد الإلكتروني
                    SharedFormField(
                      controller: _emailController,
                      label: tr('emailLabel'),
                      hint: tr('emailHint'),
                      keyboardType: TextInputType.emailAddress,
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                        color: AppColors.primary,
                      ),
                      validator:
                          (value) =>
                              validateEmail(value, context), // Remove l10n
                    ),
                    const SharedSpacer(size: 24),
                    SharedFormField(
                      controller: _passwordController,
                      label: tr('passwordLabel'),
                      hint: tr('passwordHint'),
                      obscureText: true,
                      keyboardType: TextInputType.visiblePassword,
                      prefixIcon: const Icon(
                        Icons.lock_outline,
                        color: AppColors.primary,
                      ),
                      validator: (value) => validatePassword(value, context),
                    ),
                    const SharedSpacer(size: 32),

                    // زر تسجيل الدخول
                    SharedButton(
                      text: tr('loginButton'),
                      isLoading: state is LoginLoading,
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        final isValid =
                            _formKey.currentState?.validate() ?? false;
                        if (isValid) {
                          context.read<LoginCubit>().loginWithEmail(
                            _emailController.text,
                            _passwordController.text,
                          );
                        }
                      },
                      type: ButtonType.elevated,
                      isFullWidth: true,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
