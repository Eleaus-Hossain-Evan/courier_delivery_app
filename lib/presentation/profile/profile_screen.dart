import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/auth/auth_provider.dart';
import '../../utils/utils.dart';
import '../auth/login/login.dart';
import '../widgets/widgets.dart';
import 'pages/bank_details_screen.dart';
import 'pages/change_password_screen.dart';
import 'pages/edit_profile/profile_detail_screen.dart';
import 'pages/html_text.dart';
import 'widgets/picture_widget.dart';

class ProfileScreen extends HookConsumerWidget {
  static String route = "/profile";
  const ProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);
    // final homeState = ref.watch(homeProvider);
    // final localState = ref.watch(appLocalProvider);
    // final isLoggedIn = ref.watch(loggedInProvider).loggedIn;

    final isEditable = useState(!state.user.isDisabled);
    final refreshController =
        useMemoized(() => RefreshController(initialRefresh: false));

    return Scaffold(
      appBar: const KAppBar(titleText: AppStrings.profile),
      body: SmartRefresher(
        controller: refreshController,
        enablePullDown: true,
        onRefresh: () => ref.read(authProvider.notifier).profileView().then(
            (_) => refreshController.refreshCompleted(resetFooterState: true)),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // "${local.value?.value}".text.make(),
              //? Top Section
              gap18,
              ProfilePicWidget(
                onEditTap: () => context.push(ProfileDetailScreen.route),
              ),
              gap40,
              Container(
                padding: padding20,
                decoration: BoxDecoration(
                  color: AppColors.bg100,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(.2),
                    width: 1.2.w,
                  ),
                ),
                child: Column(
                  children: [
                    ProfileOptionsItem(
                      visible: isEditable.value,
                      leading: Bootstrap.bank2,
                      title: AppStrings.bankDetail,
                      secondaryTrailing: const Icon(Icons.warning_rounded)
                          .iconColor(AppColors.warning),
                      onTap: () => context.push(BankDetailsScreen.route),
                    ),
                    KDivider(
                      height: 36.h,
                    ),
                    ProfileOptionsItem(
                      leading: BoxIcons.bxs_lock,
                      title: AppStrings.changePassword,
                      onTap: () => context.push(ChangePasswordScreen.route),
                    ),
                    KDivider(height: 36.h),

                    //. ---- Logout -----

                    ProfileOptionsItem(
                      leading: EvaIcons.log_out,
                      title: AppStrings.logout,
                      onTap: () => kShowFloatBottomSheet(
                        context: context,
                        child: LogoutDialog(
                          onYesPressed: () {
                            ref.read(authProvider.notifier).logout();
                            context.go(LoginScreen.route);
                          },
                          onNoPressed: () {},
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              gap18,
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: paddingLeft10,
                  child: const Text(AppStrings.support),
                ),
              ),
              gap12,
              Container(
                padding: padding20,
                decoration: BoxDecoration(
                  color: AppColors.bg100,
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: AppColors.primary.withOpacity(.2),
                    width: 1.2.w,
                  ),
                ),
                child: Column(
                  children: [
                    ProfileOptionsItem(
                      leading: Icons.help_center_outlined,
                      title: AppStrings.contactUs,
                      onTap: () => context.push(HtmlTextScreen.route),
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
      ),
    );
  }
}

class ProfileOptionsItem extends HookConsumerWidget {
  const ProfileOptionsItem({
    super.key,
    required this.leading,
    required this.title,
    this.visible = true,
    this.trailingText,
    this.onTap,
    this.trailing,
    this.secondaryTrailing,
  });

  final IconData leading;
  final String title;
  final bool visible;
  final String? trailingText;
  final VoidCallback? onTap;
  final Widget? trailing;
  final Widget? secondaryTrailing;
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
              color: AppColors.secondary,
            ),
            gap16,
            Expanded(
              child: Text(
                title,
                style: CustomTextStyle.textStyle14w400,
              ),
            ),
            trailing ??
                (secondaryTrailing ??
                    (trailingText == null
                        ? const SizedBox.shrink()
                        : Text(
                            trailingText ?? "",
                            style: CustomTextStyle.textStyle14w500Red,
                          ))),
            gap12,
            trailing == null
                ? Icon(
                    Icons.chevron_right_rounded,
                    size: 28.sp,
                    color: AppColors.black,
                  )
                : const SizedBox.shrink(),
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
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: mainMin,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Text(
            AppStrings.logout,
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
                  // fontWeight: FontWeight.bold,
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
                  child: KFilledButton(
                    text: "Cancel",
                    onPressed: () {
                      Navigator.pop(context);
                      onNoPressed.call();
                    },
                    backgroundColor: context.colors.secondary,
                    foregroundColor:
                        Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                ),
                SizedBox(
                  width: .3.sw,
                  child: KFilledButton(
                    text: "Yes",
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
      ),
    );
  }
}
