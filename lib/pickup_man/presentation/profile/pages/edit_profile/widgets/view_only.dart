import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:velocity_x/velocity_x.dart';


import '../../../../../../application/auth/auth_provider.dart';
import '../../../../../../utils/utils.dart';
import 'profile_section.dart';

class ViewOnlyWidget extends HookConsumerWidget {
  const ViewOnlyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context, ref) {
    final state = ref.watch(authProvider);
    return Column(
      crossAxisAlignment: crossStart,
      children: [
        //  Bank Details------------------

        ProfileSection(
          title: AppStrings.bankDetails,
          leading: Icon(
            BoxIcons.bxs_bank,
            size: 22.sp,
            color: ColorPalate.secondary,
          ),
          visible: true,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              BankDetailItem(
                title: AppStrings.bankName,
                value: state.user.bankAccount.bankName,
              ),
              gap16,
              BankDetailItem(
                title: AppStrings.accountHolder,
                value: state.user.bankAccount.accName,
              ),
              gap16,
              BankDetailItem(
                title: AppStrings.branchCode,
                value: state.user.bankAccount.branch,
              ),
              gap16,
              BankDetailItem(
                title: AppStrings.routingNumber,
                value: state.user.bankAccount.routingNum,
              ),
              gap16,
              BankDetailItem(
                title: AppStrings.accountNumber,
                value: state.user.bankAccount.accNum,
              ),
            ],
          ),
        ),

        //  Other Payment -------------

        ProfileSection(
          title: AppStrings.otherPaymentMethod,
          leading: Icon(
            BoxIcons.bxs_credit_card,
            size: 22.sp,
            color: ColorPalate.secondary,
          ),
          visible: true,
          child: Column(
            crossAxisAlignment: crossStart,
            children: [
              BankDetailItem(
                title: AppStrings.bKashNumber,
                value: state.user.othersAccount.bkashNum,
              ),
              gap16,
              BankDetailItem(
                title: AppStrings.nahadNumber,
                value: state.user.othersAccount.nagadNum,
              ),
              gap16,
              BankDetailItem(
                title: AppStrings.rocketNumber,
                value: state.user.othersAccount.rocketNum,
              ),
            ],
          ),
        ),

        //  Default Payment -------------

        ProfileSection(
          title: AppStrings.defaultPayment,
          leading: Icon(
            FontAwesome.money_bill_1_wave,
            size: 18.sp,
            color: ColorPalate.secondary,
          ),
          visible: true,
          child: BankDetailItem(
            title: AppStrings.defaultPaymentProcessForCustomer,
            value: state.user.defaultPayment.toUpperCase(),
          ),
        ),
      ],
    );
  }
}

class BankDetailItem extends StatelessWidget {
  const BankDetailItem({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        "$title : ".text.sm.make(),
        value.text.sm.semiBold.make(),
      ],
    );
  }
}
