import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import 'package:courier_delivery_app/utils/utils.dart';

import '../../../application/global.dart';
import '../../../rider/application/parcel_rider/parcel_rider_provider.dart';
import '../../../rider/domain/top_level_rider_parcel_model.dart';
import '../widgets.dart';

class ParcelActionSection extends HookConsumerWidget {
  const ParcelActionSection({
    super.key,
    required this.model,
    required this.onUndoTap,
    required this.pageType,
  });

  final TopLevelRiderParcelModel model;
  final Function(bool) onUndoTap;
  final ParcelRiderType pageType;

  @override
  Widget build(BuildContext context, ref) {
    final formKey = useMemoized<GlobalKey<FormState>>(GlobalKey.new);
    final loading = useState(false);
    final isReceived = useState(false);
    final isCanceled = useState(false);
    final isUndo = useState(isReceived.value || isCanceled.value);

    final noteController = useTextEditingController(text: model.note);
    final noteFocus = useFocusNode();

    // final deliveryStatusList = useState([
    //   ParcelRiderType.values[2],
    //   ParcelRiderType.values[3],
    // ]);
    // final deliveryStatus = useState<ParcelRiderType?>(model.status);

    final deliveryParcelStatusList = useState([
      ParcelRiderStatus.values[1],
      ParcelRiderStatus.values[3],
      ParcelRiderStatus.values[4],
    ]);
    final deliveryParcelStatus =
        useState<ParcelRiderStatus>(model.parcelStatus);

    useEffect(() {
      Future.wait([
        Future.microtask(
            () => isReceived.value = model.status == ParcelRiderType.complete),
        Future.microtask(
            () => isCanceled.value = model.status == ParcelRiderType.reject),
      ]);
      return null;
    }, []);

    void undoToggle() {
      isUndo.value = !isUndo.value;
      onUndoTap(isUndo.value);
    }

    return Form(
      key: formKey,
      child: SizedBox(
        width: 1.sw,
        child: Visibility(
          visible: !model.isComplete,
          replacement: "Confirmed"
              .text
              .xl
              .colorPrimary(context)
              .makeCentered()
              .box
              .colorPrimary(context, opacity: .05)
              .border(color: context.colors.primary.withOpacity(.2))
              .make(),
          child: AnimatedSwitcher(
            // crossFadeState: isUndo.value
            //     ? CrossFadeState.showSecond
            //     : CrossFadeState.showFirst,
            // secondCurve: Curves.easeOutCubic,
            // alignment: Alignment.centerRight,
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeOutCubic,
            duration: 800.milliseconds,
            child: isUndo.value || model.status == ParcelRiderType.assign
                ? Column(
                    crossAxisAlignment: crossStart,
                    children: [
                      // ActionItem<ParcelRiderType>(
                      //   title: "Status",
                      //   list: deliveryStatusList.value,
                      //   item: deliveryStatus.value,
                      //   itemAsString: (p0) => p0.name,
                      //   onChanged: (v) {
                      //     deliveryStatus.value = v;
                      //     if (v == ParcelRiderType.reject) {
                      //       deliveryParcelStatus.value = ParcelRiderStatus.none;
                      //     }
                      //   },
                      // ),
                      // gap6,
                      ActionItem<ParcelRiderStatus>(
                        title: "Parcel Status",
                        list: deliveryParcelStatusList.value,
                        item: deliveryParcelStatus.value,
                        itemAsString: (p0) => p0.name,
                        onChanged: (v) => deliveryParcelStatus.value = v!,
                      ),
                      gap8,
                      KTextFormField(
                        controller: noteController,
                        focusNode: noteFocus,
                        labelText: "Note",
                        borderColor: AppColors.bg300,
                        validator: (value) {
                          if ((deliveryParcelStatus.value ==
                                  ParcelRiderStatus.hold ||
                              deliveryParcelStatus.value ==
                                  ParcelRiderStatus.returns)) {
                            if (value!.isEmpty) {
                              return "Please Write a Note";
                            }
                            if (value.length < 15) {
                              return "Note must be at least 15 characters";
                            }
                          }
                          return null;
                        },
                      ),
                      gap8,
                      KOutlinedButton(
                        text: "Done",
                        loading: loading,
                        onPressed: () async {
                          FocusScope.of(context).unfocus();
                          Logger.i(deliveryParcelStatus.value);

                          if (deliveryParcelStatus.value ==
                              ParcelRiderStatus.none) {
                            showErrorToast("Please select parcel status");
                            return;
                          }
                          // if ((deliveryParcelStatus.value == ParcelRiderStatus.hold ||
                          //         deliveryParcelStatus.value ==
                          //             ParcelRiderStatus.returns) &&
                          //     noteController.text.isEmpty) {
                          //   showErrorToast("Please select parcel status");
                          //   loading.value = false;
                          //   return;
                          // }
                          if (formKey.currentState!.validate()) {
                            loading.value = true;
                            await ref
                                .read(parcelRiderProvider.notifier)
                                .riderParcelUpdate(
                                  parcelId: model.id,
                                  cashCollected: model
                                      .parcel.regularPayment.cashCollection
                                      .toInt(),
                                  status: ParcelRiderType.complete,
                                  parcelStatus: deliveryParcelStatus.value,
                                  note: noteController.text,
                                  shouldRemove: pageType != ParcelRiderType.all,
                                )
                                .then((value) {
                              loading.value = false;
                              if (value) {
                                Navigator.pop(context);
                              }
                            });
                          }
                        },
                        isSecondary: false,
                      )
                    ],
                  )
                : KElevatedButton(
                    onPressed: undoToggle,
                    backgroundColor: context.colors.secondary,
                    foregroundColor: context.theme.scaffoldBackgroundColor,
                    text: 'Undo',
                  ).px8(),
          )
              .p16()
              .box
              .roundedSM
              .colorScaffoldBackground(context)
              .make()
              .pOnly(bottom: MediaQuery.of(context).viewInsets.bottom),
        ),
      ),
    );
  }
}

class ActionItem<T> extends StatelessWidget {
  const ActionItem({
    super.key,
    required this.title,
    required this.list,
    this.item,
    this.onChanged,
    this.itemAsString,
  });

  final String title;
  final List<T> list;
  final T? item;

  final void Function(T?)? onChanged;
  final String Function(T)? itemAsString;

  @override
  Widget build(BuildContext context) {
    String selectedItemAsString(T? data) {
      if (data == null) {
        return "";
      } else if (itemAsString != null) {
        return itemAsString!(data);
      } else {
        return data.toString();
      }
    }

    return Stack(
      children: [
        Row(
          children: list
              .map(
                (e) => Row(
                  mainAxisSize: mainMin,
                  children: [
                    Radio<T>(
                      value: e,
                      groupValue: item,
                      // materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      // visualDensity: VisualDensity.compact,
                      onChanged: onChanged,
                    ),
                    selectedItemAsString(e)
                        .capitalized
                        .text
                        .base
                        .letterSpacing(1)
                        .caption(context)
                        .make()
                        .onInkTap(() {
                      onChanged!(e);
                    }),
                  ],
                ),
              )
              .toList(),
        )
            .p12()
            .box
            .roundedSM
            .border(color: AppColors.bg300)
            .make()
            .pSymmetric(v: 8.w, h: 0.w),
        title.text.semiBold
            .letterSpacing(.8)
            .color(AppColors.black700)
            .make()
            .px8()
            .box
            .colorScaffoldBackground(context)
            .make()
            .positioned(top: 0, left: 4),
      ],
    );
  }
}
