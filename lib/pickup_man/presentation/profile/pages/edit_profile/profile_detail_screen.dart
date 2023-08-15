import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../application/auth/auth_provider.dart';
import '../../../../../application/auth/auth_state.dart';
import '../../../../../application/global.dart';
import '../../../../../domain/auth/model/hub_model.dart';
import '../../../../../domain/auth/profile_update_body.dart';
import '../../../../../presentation/profile/pages/edit_profile/widgets/profile_section.dart';
import '../../../../../presentation/widgets/widgets.dart';
import '../../../../../utils/utils.dart';
import 'widgets/view_only.dart';

enum PickUpStyle { perRequest, daily }

class ProfileDetailScreen extends HookConsumerWidget {
  static const route = '/profile-detail';

  const ProfileDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authProvider);

    final isEditable = useState(!state.user.isDisabled);

    final isLoading = useState(false);

    final formKey = useMemoized(GlobalKey<FormState>.new);

    final isUpdate = useState(false);

    final imageFile = useState<File?>(null);

    final nameController = useTextEditingController(text: state.user.name);
    final emailController = useTextEditingController(text: state.user.email);
    final phoneController = useTextEditingController(text: state.user.phone);
    final addressController =
        useTextEditingController(text: state.user.address);

    ref.listen<AuthState>(
      authProvider,
      (previous, next) {
        if (previous!.loading == false && next.loading) {
          BotToast.showLoading();
        } else {
          BotToast.closeAllLoading();
        }
      },
    );

    useEffect(() {
      Future.microtask(() => ref.read(authProvider.notifier).profileView());
      return null;
    }, const []);

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        titleText: AppStrings.profile,
        actions: [
          Visibility(
            visible: !isUpdate.value,
            // replacement: SizedBox(
            //   width: 100.w,
            //   child: TextButton(
            //     child: "Save"
            //         .text
            //         .colorSecondary(context)
            //         .bold
            //         .letterSpacing(1.2)
            //         .make(),
            //     onPressed: () {
            //       isUpdate.value = !isUpdate.value;
            //     },
            //   ),
            // ),
            child: IconButton(
              onPressed: () {
                isEditable.value
                    ? isUpdate.value = !isUpdate.value
                    : showToast(
                        "You can't edit details now,\nPlease, contact with admin.");
              },
              icon: const Icon(FontAwesome.pen_to_square)
                  .iconColor(ColorPalate.white)
                  .iconSize(18.sp),
            ),
          ),
        ],
      ),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return ref.read(authProvider.notifier).profileView();
        },
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w).copyWith(top: 150.h),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                //  Personal Info------------------

                ProfileSection(
                  title: AppStrings.personalInfo,
                  leading: Icon(
                    BoxIcons.bxs_user_account,
                    size: 18.sp,
                    color: ColorPalate.secondary,
                  ),
                  visible: true,
                  containerPadding: paddingV20,
                  child: Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      ImagePickWidget(
                        imageFile: imageFile,
                        imagePath: state.user.image,
                        defaultWidget: Icon(
                          Icons.person,
                          size: 68.sp,
                          color: context.colors.secondaryContainer,
                        ),
                        editIcon: isEditable.value ? isUpdate.value : true,
                        onTapUploadImage: isEditable.value
                            ? null
                            : (file) async {
                                Logger.w(file);
                                final success = await ref
                                    .read(authProvider.notifier)
                                    .uploadImage(file);
                                if (success) imageFile.value = null;
                              },
                      ),
                      gap24,
                      KTextFormField2(
                        hintText: AppStrings.name,
                        controller: nameController,
                        isLabel: true,
                        enabled: isUpdate.value,
                        validator: ValidationBuilder().maxLength(15).build(),
                      ),
                      gap16,
                      KTextFormField2(
                        hintText: AppStrings.email,
                        controller: emailController,
                        isLabel: true,
                        readOnly: true,
                        enabled: isUpdate.value,
                        validator:
                            ValidationBuilder().maxLength(30).email().build(),
                      ),
                      gap16,
                      KTextFormField2(
                        hintText: AppStrings.phoneNumber,
                        controller: phoneController,
                        isLabel: true,
                        readOnly: true,
                        enabled: isUpdate.value,
                        validator: ValidationBuilder()
                            .maxLength(11)
                            .minLength(11)
                            .phone()
                            .build(),
                      ),
                    ],
                  ),
                ),

                //  Address ----------------

                ProfileSection(
                  title: AppStrings.address,
                  leading: const Icon(
                    FontAwesome.address_card,
                    size: 18,
                    color: ColorPalate.secondary,
                  ),
                  visible: isEditable.value,
                  containerPadding: paddingV20,
                  replacement: Row(
                    children: [
                      gap16,
                      state.user.address.text.lg.make().flexible(),
                    ],
                  ).px16(),
                  child: KTextFormField2(
                    controller: addressController,
                    hintText: AppStrings.address,
                    enabled: isUpdate.value,
                    isLabel: true,
                  ),
                ),

                //  Hub ----------------

                ProfileSection(
                  title: AppStrings.hubDetail,
                  leading: Icon(
                    FontAwesome.map_location_dot,
                    size: 18.sp,
                    color: ColorPalate.secondary,
                  ),
                  visible: state.user.hub == HubModel.init(),
                  containerPadding: paddingV20,
                  replacement: Column(
                    children: [
                      BankDetailItem(
                        title: "Hub Name",
                        value: state.user.hub.name,
                      ),
                      gap16,
                      BankDetailItem(
                        title: "Hub Address",
                        value: state.user.hub.address,
                      ),
                    ],
                  ).px16(),
                  child: "No Hub assigned!".text.make(),
                ),

                // showing full detail when user is approved

                Visibility(
                  visible: !isEditable.value,
                  child: const ViewOnlyWidget(),
                ),
                gap20,
                Visibility(
                  visible: isUpdate.value,
                  child: KFilledButton(
                    text: AppStrings.save,
                    loading: isLoading.value,
                    onPressed: () async {
                      isLoading.value = true;
                      FocusManager.instance.primaryFocus!.unfocus();
                      ref
                          .read(authProvider.notifier)
                          .profileUpdate(
                              ProfileUpdateBody(
                                name: nameController.text.trim(),
                                email: emailController.text.trim(),
                                phone: phoneController.text.trim(),
                                address: addressController.text.trim(),
                              ),
                              imageFile.value)
                          .then((value) {
                        isLoading.value = false;
                        if (value) {
                          isUpdate.value = false;
                        }
                      });
                    },
                  ),
                ),
                gap36,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
