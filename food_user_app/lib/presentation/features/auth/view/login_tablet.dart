import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../shared/localization/app_localizations.dart';
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

/// واجهة تسجيل الدخول للأجهزة اللوحية
class LoginTablet extends StatefulWidget {
  const LoginTablet({Key? key}) : super(key: key);

  @override
  State<LoginTablet> createState() => _LoginTabletState();
}

class _LoginTabletState extends State<LoginTablet> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.backgroundSecondary,
      appBar: AppBar(
        title: Text(l10n.loginTitle),
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
                content: Text(l10n.loginSuccess),
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
                                text: l10n.appTitle,
                                type: TextType.heading1,
                                color: AppColors.primary,
                              ),
                              SharedText(
                                text: l10n.appSlogan,
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
                              text: l10n.loginTitle,
                              textAlign: TextAlign.center,
                              type: TextType.heading2,
                              color: AppColors.textHeading,
                            ),
                            const SharedSpacer(size: 32),
                            SharedFormField(
                              controller: _emailController,
                              label: l10n.emailLabel,
                              hint: l10n.emailHint,
                              keyboardType: TextInputType.emailAddress,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: AppColors.primary,
                              ),
                              validator: (value) => validateEmail(value, l10n),
                            ),
                            const SharedSpacer(size: 32),
                            SharedButton(
                              text: l10n.loginButton,
                              isLoading: state is LoginLoading,
                              onPressed: () {
                                FocusScope.of(context).unfocus();
                                final isValid =
                                    _formKey.currentState?.validate() ?? false;
                                if (isValid) {
                                  context.read<LoginCubit>().loginWithEmail(
                                    _emailController.text,
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
