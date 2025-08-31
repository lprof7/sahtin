import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart'; // Import easy_localization
import '../viewmodel/login_cubit.dart';
import '../viewmodel/login_state.dart';
import '../../../shared/widgets/atoms/shared_button.dart';
import '../../../shared/widgets/molecules/form_field.dart';
import '../../../shared/widgets/atoms/shared_spacer.dart';
import '../../../shared/widgets/atoms/shared_text.dart';
import '../../../shared/widgets/organisms/card.dart';
import '../../../shared/themes/colors.dart';
import '../../../shared/themes/text_styles.dart';
import '../../../shared/utils/validators.dart';
import '../../../../core/routing/app_router.dart';
import '../../../../data/models/user.dart'; // Import User model

/// واجهة تسجيل الدخول للويب
class LoginWeb extends StatefulWidget {
  const LoginWeb({Key? key}) : super(key: key);

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
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
    //final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(tr('loginSuccess')),
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
          return Row(
            children: [
              // الجانب الأيسر - منطقة الديكور
              Expanded(
                flex: 5,
                child: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColors.primary, AppColors.secondary],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Image(
                        image: AssetImage('assets/images/logo.png'),
                        width: 180,
                        height: 180,
                      ),
                      const SharedSpacer(size: 24),
                      SharedText(
                        text: tr('appTitle'),
                        textAlign: TextAlign.center,
                        type: TextType.heading1,
                        color: Colors.white,
                      ),
                      const SharedSpacer(size: 16),
                      Container(
                        width: 400,
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: SharedText(
                          text: tr('appSlogan'),
                          textAlign: TextAlign.center,
                          type: TextType.bodyLarge,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // الجانب الأيمن - نموذج تسجيل الدخول
              Expanded(
                flex: 4,
                child: Container(
                  color: AppColors.backgroundPrimary,
                  padding: const EdgeInsets.all(48),
                  child: Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 450),
                      child: SharedCard(
                        elevation: 4,
                        padding: const EdgeInsets.all(40),
                        content: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SharedText(
                                text: tr('loginTitle'),
                                textAlign: TextAlign.center,
                                type: TextType.heading2,
                                color: AppColors.textHeading,
                              ),
                              const SharedSpacer(size: 8),
                              SharedText(
                                text: tr('emailHint'),
                                textAlign: TextAlign.center,
                                type: TextType.bodyMedium,
                                color: AppColors.textBody,
                              ),
                              const SharedSpacer(size: 40),
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
                                    (value) => validateEmail(value, context),
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
                                validator:
                                    (value) => validatePassword(value, context),
                              ),
                              const SharedSpacer(size: 32),
                              SharedButton(
                                text: tr('loginButton'),
                                isLoading: state is LoginLoading,
                                onPressed: () {
                                  FocusScope.of(context).unfocus();
                                  final isValid =
                                      _formKey.currentState?.validate() ??
                                      false;
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
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
