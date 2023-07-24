import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';

import '../../application/auth/auth_provider.dart';
import '../../application/global.dart';
import '../../utils/utils.dart';
import '../auth/login/login.dart';
import '../widgets/widgets.dart';
import 'pages/change_password_screen.dart';
import 'pages/edit_profile/edit_profile_screen.dart';
import 'widgets/picture_widget.dart';

class ProfileScreen extends HookConsumerWidget {
  static String route = "/profile";
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final state = ref.watch(authProvider);
    // final homeState = ref.watch(homeProvider);
    // final localState = ref.watch(appLocalProvider);
    // final isLoggedIn = ref.watch(loggedInProvider).loggedIn;

    return Scaffold(
      appBar: const KAppBar(titleText: AppStrings.profile),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //? Top Section
            gap18,
            ProfilePicWidget(
              onEditTap: () => context.push(EditProfileScreen.route),
            ),
            gap40,
            Container(
              padding: padding20,
              decoration: BoxDecoration(
                color: ColorPalate.bg100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorPalate.primary.withOpacity(.2),
                  width: 1.2.w,
                ),
              ),
              child: Column(
                children: [
                  ProfileOptionsItem(
                    leading: Bootstrap.bank2,
                    title: AppStrings.bankDetail,
                    onTap: () => context.push(ChangePasswordScreen.route),
                  ),
                  KDivider(height: 36.h),
                  ProfileOptionsItem(
                    leading: Iconsax.money_send,
                    title: AppStrings.paymentMethod,
                    onTap: () => context.push(ChangePasswordScreen.route),
                  ),
                  KDivider(height: 36.h),
                  ProfileOptionsItem(
                    leading: Iconsax.map,
                    title: AppStrings.updateHub,
                    onTap: () => context.push(ChangePasswordScreen.route),
                  ),
                  KDivider(height: 36.h),
                  ProfileOptionsItem(
                    leading: BoxIcons.bxs_lock,
                    title: AppStrings.changePassword,
                    onTap: () => context.push(ChangePasswordScreen.route),
                  ),
                  KDivider(height: 36.h),
                  ProfileOptionsItem(
                    leading: EvaIcons.log_out,
                    title: AppStrings.logout,
                    onTap: () => showFloatBottomSheet(context, builder: (_) {
                      return LogoutDialog(
                        onYesPressed: () {
                          ref.read(authProvider.notifier).logout();
                          context.go(LoginScreen.route);
                        },
                        onNoPressed: () {},
                      );
                    }),
                  ),
                ],
              ),
            ),
            gap18,
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: paddingLeft10,
                child: Text(
                  AppStrings.support,
                  style: CustomTextStyle.textStyle16w500HG900,
                ),
              ),
            ),
            gap12,
            Container(
              padding: padding20,
              decoration: BoxDecoration(
                color: ColorPalate.bg100,
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: ColorPalate.primary.withOpacity(.2),
                  width: 1.2.w,
                ),
              ),
              child: Column(
                children: [
                  ProfileOptionsItem(
                    leading: Icons.help_center_outlined,
                    title: AppStrings.contactUs,
                    onTap: () {},
                  ),
                  KDivider(height: 36.h),
                  ProfileOptionsItem(
                    leading: Icons.privacy_tip_outlined,
                    title: AppStrings.privacyPolicy,
                    onTap: () {},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileOptionsItem extends HookConsumerWidget {
  const ProfileOptionsItem({
    super.key,
    required this.leading,
    required this.title,
    this.trailingText,
    this.onTap,
  });

  final IconData leading;
  final String title;
  final bool visible = true;
  final String? trailingText;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Visibility(
      visible: visible,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius10,
        child: Row(
          children: [
            Icon(
              leading,
              size: 20.sp,
              color: ColorPalate.secondary,
            ),
            gap16,
            Expanded(
              child: Text(
                title,
                style: CustomTextStyle.textStyle14w400,
              ),
            ),
            trailingText == null
                ? const SizedBox.shrink()
                : Text(
                    trailingText ?? "",
                    style: CustomTextStyle.textStyle14w500Red,
                  ),
            gap12,
            Icon(
              Icons.chevron_right_rounded,
              size: 28.sp,
              color: ColorPalate.black,
            ),
          ],
        ),
      ),
    );
  }
}

class LogoutDialog extends HookConsumerWidget {
  const LogoutDialog(
      {super.key, required this.onYesPressed, required this.onNoPressed});

  final VoidCallback onYesPressed;
  final VoidCallback onNoPressed;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 40.h,
        ),
        Text(
          'LOGOUT',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                color: Theme.of(context).colorScheme.error,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          "Are you sure you want to logout?",
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 14.sp,
              ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: .3.sw,
                child: KElevatedButton(
                  text: "Cancel",
                  onPressed: () {
                    Navigator.pop(context);
                    onNoPressed.call();
                  },
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .secondaryContainer
                      .withOpacity(.4),
                  foregroundColor:
                      Theme.of(context).colorScheme.onPrimaryContainer,
                ),
              ),
              SizedBox(
                width: .3.sw,
                child: FilledButton(
                  child: const Text("Yes"),
                  onPressed: () {
                    Navigator.pop(context);
                    onYesPressed.call();
                    // context.go(LoginScreen.routeName);
                  },
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40.h,
        ),
      ],
    );
  }
}
