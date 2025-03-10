import 'package:bot_toast/bot_toast.dart';
import 'package:courier_delivery_app/domain/auth/signup_body.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

class SignUpScreen extends HookConsumerWidget {
  static String route = "/sign-up";
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(GlobalKey<FormState>.new);
    final firstNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final passwordController = useTextEditingController();
    final reTypePasswordController = useTextEditingController();

    final firstNameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final phoneFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final reTypePasswordFocusNode = useFocusNode();

    ref.listen(authProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: SizedBox(
        height: 1.sh,
        width: 1.sw,
        child: SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 0, 20, 0),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: crossStart,
              children: [
                Text(
                  AppStrings.signUp.toTitleCase(),
                  style: CustomTextStyle.textStyle32w600,
                ),
                gap20,
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  child: Text(
                    AppStrings.signUpBelowText,
                    style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: AppColors.black,
                    ),
                  ),
                ),
                gap36,
                KTextFormField2(
                  containerPadding: padding0,
                  focusNode: firstNameFocusNode,
                  hintText: AppStrings.name,
                  isLabel: true,
                  controller: firstNameController,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (value) {
                    emailFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.email,
                  isLabel: true,
                  controller: emailController,
                  focusNode: emailFocusNode,
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    phoneFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.phoneNumber,
                  isLabel: true,
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) {
                    passwordFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.password,
                  isLabel: true,
                  controller: passwordController,
                  focusNode: passwordFocusNode,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) {
                    reTypePasswordFocusNode.requestFocus();
                  },
                ),
                gap16,
                KTextFormField2(
                  containerPadding: padding0,
                  hintText: AppStrings.reTypePassword,
                  isLabel: true,
                  controller: reTypePasswordController,
                  focusNode: reTypePasswordFocusNode,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) {
                    reTypePasswordFocusNode.unfocus();
                  },
                ),
                gap24,
                gap12,
                Text(
                  AppStrings.signUpPrivacyPolicy,
                  textAlign: TextAlign.center,
                  style: context.bodySmall!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    letterSpacing: .02,
                    color: AppColors.black600,
                  ),
                ),
                gap12,
                KFilledButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(authProvider.notifier).signUp(
                          SignUpBody(
                            name: firstNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            address: '',
                            password: passwordController.text,
                          ),
                        );
                  },
                  text: AppStrings.signUp,
                ),

                gap16,

                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.alreadyHaveAccount,
                      style: context.headlineSmall!.copyWith(
                        color: AppColors.black600,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                      children: [
                        const WidgetSpan(
                          child: SizedBox(
                            width: 12,
                          ),
                        ),
                        TextSpan(
                          text: AppStrings.login,
                          style: context.headlineMedium!.copyWith(
                            color: AppColors.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.pop(),
                        )
                      ],
                    ),
                  ),
                ),
                // gap16,
                // KElevatedButton(
                //   onPressed: () {
                //     context.go(LoginScreen.route);
                //   },
                //   text: AppStrings.login,
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
