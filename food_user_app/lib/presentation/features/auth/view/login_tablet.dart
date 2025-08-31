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

/// واجهة تسجيل الدخول للأجهزة اللوحية
class LoginTablet extends StatefulWidget {
  const LoginTablet({Key? key}) : super(key: key);

  @override
  State<LoginTablet> createState() => _LoginTabletState();
}

class _LoginTabletState extends State<LoginTablet> {
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
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        title: Text(tr('loginTitle')),
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
          return Center(
            child: SingleChildScrollView(
              child: SharedCard(
                padding: const EdgeInsets.all(40),
                elevation: 4,
                content: SizedBox(
                  width: size.width * 0.5, // 50% من عرض الشاشة
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // الشعار والعنوان
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Image(
                            image: AssetImage('assets/images/logo.png'),
                            width: 100,
                            height: 100,
                          ),
                          const SharedSpacer(size: 24),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SharedText(
                                text: tr('appTitle'),
                                type: TextType.heading1,
                                color: AppColors.primary,
                              ),
                              SharedText(
                                text: tr('appSlogan'),
                                type: TextType.bodyMedium,
                                color: AppColors.textBody,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SharedSpacer(size: 48),
                      // نموذج تسجيل الدخول
                      Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SharedText(
                              text: tr('loginTitle'),
                              textAlign: TextAlign.center,
                              type: TextType.heading2,
                              color: AppColors.textHeading,
                            ),
                            const SharedSpacer(size: 32),
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
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
