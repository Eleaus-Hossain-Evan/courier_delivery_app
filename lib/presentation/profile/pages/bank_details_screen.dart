import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../application/auth/auth_provider.dart';
import '../../../utils/utils.dart';
import '../../widgets/widgets.dart';

enum DefaultPayment { bank, bkash, nagad, rocket, cod }

enum PaymentStyle { perRequest, daily, weekly }

class BankDetailsScreen extends HookConsumerWidget {
  static const route = "/bank-details";
  const BankDetailsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bankDetail = ref.watch(authProvider).user.bankAccount;

    final accHolder = useTextEditingController(text: bankDetail.accName);
    final bankName = useTextEditingController(text: bankDetail.bankName);
    final branchName = useTextEditingController(text: bankDetail.branch);
    final routingNum = useTextEditingController(text: bankDetail.routingNum);
    final accNumber = useTextEditingController(text: bankDetail.accNum);

    final otherAcc = ref.watch(authProvider).user.othersAccount;
    final bkash = useTextEditingController(text: otherAcc.bkashNum);
    final rocket = useTextEditingController(text: otherAcc.rocketNum);
    final nagad = useTextEditingController(text: otherAcc.nagadNum);

    final newBankDetail = useState(bankDetail);

    final selectedDefaultPayment = useState<DefaultPayment?>(null);
    final selectedPaymentStyle = useState<PaymentStyle>(PaymentStyle.daily);

    final isUpdate = useState(false);

    selectedDefaultPayment.addListener(() {
      Logger.d(selectedDefaultPayment);
    });

    return CustomScaffold(
      appBar: KAppBarBGTransparent(
        title: AppStrings.bankDetails.text.make(),
        actions: [
          Visibility(
            visible: !isUpdate.value,
            child: IconButton(
                onPressed: () => isUpdate.value = !isUpdate.value,
                icon: const Icon(FontAwesome.pen_to_square)
                    .iconColor(ColorPalate.white)
                    .iconSize(18.sp)),
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: paddingH16,
        child: Padding(
          padding: EdgeInsets.only(top: 160.h),
          child: ColoredBox(
            color: ColorPalate.bg200,
            child: Column(
              children: [
                AppStrings.bankDetails.text.lg.make().objectCenterLeft(),
                gap8,
                ContainerBGWhite(
                  padding: paddingV20,
                  child: Column(
                    children: [
                      KTextFormField2(
                        controller: accHolder,
                        hintText: AppStrings.accountHolder,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(accName: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: bankName,
                        hintText: AppStrings.bankName,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(bankName: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: branchName,
                        hintText: AppStrings.branchCode,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(branch: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: routingNum,
                        hintText: AppStrings.routingNumber,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(routingNum: value),
                      ),
                      gap16,
                      KTextFormField2(
                        controller: accNumber,
                        hintText: AppStrings.accountNumber,
                        enabled: isUpdate.value,
                        onChanged: (value) =>
                            newBankDetail.value.copyWith(accNum: value),
                      ),
                    ],
                  ),
                ),
                gap24,
                AppStrings.otherPaymentMethod.text.lg.make().objectCenterLeft(),
                gap8,
                ContainerBGWhite(
                  padding: paddingV20,
                  child: Column(
                    children: [
                      KTextFormField2(
                        controller: bkash,
                        hintText: "Bkash Number",
                        enabled: isUpdate.value,
                      ),
                      gap16,
                      KTextFormField2(
                        controller: rocket,
                        hintText: "Rocket Number",
                        enabled: isUpdate.value,
                      ),
                      gap16,
                      KTextFormField2(
                        controller: nagad,
                        hintText: "Nagad Number",
                        enabled: isUpdate.value,
                      ),
                    ],
                  ),
                ),
                gap24,
                AppStrings.defaultPayment.text.lg.make().objectCenterLeft(),
                gap8,
                ContainerBGWhite(
                  padding: paddingV20,
                  child: Column(
                    children: [
                      KDropDownSearchWidget<DefaultPayment>(
                        enabled: isUpdate.value,
                        hintText: AppStrings.paymentOptions,
                        selectedItem: selectedDefaultPayment.value,
                        items: DefaultPayment.values,
                        itemAsString: (p0) => p0.name.capitalized,
                        compareFn: (p0, p1) => identical(p0.name, p0.name),
                        onChanged: (value) {
                          selectedDefaultPayment.value = value;
                        },
                      ),
                    ],
                  ),
                ),
                gap24,
                AppStrings.paymentStyle.text.lg.make().objectCenterLeft(),
                gap8,
                ContainerBGWhite(
                  padding: paddingV20,
                  child: Column(
                    children: [
                      KDropDownSearchWidget<PaymentStyle>(
                        enabled: isUpdate.value,
                        hintText: AppStrings.paymentOptions,
                        selectedItem: selectedPaymentStyle.value,
                        items: PaymentStyle.values,
                        itemAsString: (p0) => p0.name.capitalized,
                        compareFn: (p0, p1) => identical(p0.name, p0.name),
                        onChanged: (value) {
                          selectedPaymentStyle.value = value!;
                        },
                      ),
                    ],
                  ),
                ),
                gap20,
                Visibility(
                  visible: isUpdate.value,
                  child: KFilledButton(
                    text: AppStrings.save,
                    onPressed: isUpdate.value
                        ? () {
                            isUpdate.value = false;
                          }
                        : null,
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
