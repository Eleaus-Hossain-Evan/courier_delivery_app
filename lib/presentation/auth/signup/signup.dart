import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../domain/auth/signup_body.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';
import '../login/login.dart';

class SignupScreen extends HookConsumerWidget {
  static String route = "/signup";
  const SignupScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final formKey = useMemoized(GlobalKey<FormState>.new);
    final firstNameController = useTextEditingController();
    final lastNameController = useTextEditingController();
    final emailController = useTextEditingController();
    final phoneController = useTextEditingController();
    final referralController = useTextEditingController();

    final firstNameFocusNode = useFocusNode();
    final lastNameFocusNode = useFocusNode();
    final emailFocusNode = useFocusNode();
    final phoneFocusNode = useFocusNode();
    final referralFocusNode = useFocusNode();

    ref.listen(authProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
      }
    });
    return Scaffold(
      backgroundColor: ColorPalate.white,
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
                  AppStrings.signup.toTitleCase(),
                  style: CustomTextStyle.textStyle32w600,
                ),
                gap20,
                Padding(
                  padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 40, 0),
                  child: Text(
                    AppStrings.signupBelowText,
                    style: context.bodyMedium.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                      color: ColorPalate.black,
                    ),
                  ),
                ),
                gap36,
                Row(
                  children: [
                    Flexible(
                      child: KTextFormField2(
                        focusNode: firstNameFocusNode,
                        hintText: AppStrings.firstName,
                        isLabel: true,
                        controller: firstNameController,
                        textInputAction: TextInputAction.next,
                        onFieldSubmitted: (value) {
                          lastNameFocusNode.requestFocus();
                        },
                      ),
                    ),
                    gap16,
                    Flexible(
                      child: KTextFormField2(
                        hintText: AppStrings.lastName,
                        isLabel: true,
                        controller: lastNameController,
                        textInputAction: TextInputAction.next,
                        focusNode: lastNameFocusNode,
                        onFieldSubmitted: (value) {
                          emailFocusNode.requestFocus();
                        },
                      ),
                    ),
                  ],
                ),
                gap16,
                KTextFormField2(
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
                  hintText: AppStrings.phoneNumber,
                  isLabel: true,
                  controller: phoneController,
                  focusNode: phoneFocusNode,
                  keyboardType: TextInputType.phone,
                  onFieldSubmitted: (value) {
                    referralFocusNode.requestFocus();
                  },
                ),
                gap24,
                gap12,
                Text(
                  AppStrings.signUpPrivacyPolicy,
                  textAlign: TextAlign.center,
                  style: context.caption.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    letterSpacing: .02,
                    color: ColorPalate.black600,
                  ),
                ),
                gap12,
                KFilledButton(
                  onPressed: () async {
                    FocusManager.instance.primaryFocus?.unfocus();
                    ref.read(authProvider.notifier).signUp(
                          SignupBody(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                            usedReferralCode: referralController.text,
                            language: state.language,
                          ),
                        );
                  },
                  text: AppStrings.signup,
                ),
                gap24,
                Center(
                  child: Text(
                    AppStrings.orSignupWith,
                    textAlign: TextAlign.center,
                    style: context.headline6.copyWith(
                      color: ColorPalate.black600,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.50,
                    ),
                  ),
                ),
                gap16,
                Row(
                  children: [
                    Flexible(
                      child: KElevatedButton(
                        // backgroundColor: ColorPalate.fbColor,
                        onPressed: () => context.push(SignupScreen.route),
                        text: '',
                        child: Image.asset(
                          Images.iconFacebook,
                          height: 40.h,
                          width: 40.w,
                        ),
                      ),
                    ),
                    gap16,
                    Flexible(
                      child: KElevatedButton(
                        // backgroundColor: ColorPalate.googleColor,
                        onPressed: () => context.push(SignupScreen.route),
                        text: '',
                        child: Image.asset(
                          Images.iconGoogle,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ),
                  ],
                ),
                gap28,
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: AppStrings.alreadyHaveAccount,
                      style: context.headline6.copyWith(
                        color: ColorPalate.black600,
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
                          style: context.headlineMedium.copyWith(
                            color: ColorPalate.primary,
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () => context.go(LoginScreen.route),
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
