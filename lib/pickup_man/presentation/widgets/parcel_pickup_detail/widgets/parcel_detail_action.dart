import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../../../../presentation/widgets/widgets.dart';
import '../../../../../utils/utils.dart';
import '../../../../domain/parcel/model/top_level_pickup_parcel_model.dart';

class ParcelDetailAction extends HookConsumerWidget {
  const ParcelDetailAction({
    super.key,
    required this.model,
    required this.isUndo,
    required this.onTapCancel,
    required this.onTapReceive,
  });

  final TopLevelPickupParcelModel model;
  final ValueNotifier<bool> isUndo;
  final FutureOr<bool>? Function(String) onTapCancel;
  final FutureOr<bool>? Function(String) onTapReceive;

  @override
  Widget build(BuildContext context, ref) {
    final noteController = useTextEditingController(text: model.note);
    void undoToggle() {
      isUndo.value = !isUndo.value;
    }

    void pop() {
      Navigator.pop(context);
    }

    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      // height: 34.w,
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
          child: isUndo.value || model.status == ParcelPickupStatus.assign
              ? Column(
                  children: [
                    KTextFormField2(
                      containerPadding: padding0,
                      controller: noteController,
                      hintText: "Note",
                    ),
                    gap16,
                    Row(
                      mainAxisSize: mainMin,
                      mainAxisAlignment: mainEnd,
                      crossAxisAlignment: crossEnd,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await onTapCancel.call(noteController.text);
                            undoToggle.call();
                            pop();
                          },
                          style: ElevatedButton.styleFrom(
                            padding: padding0,
                            foregroundColor: context.colors.primary,
                          ),
                          child: "Cancel".text.base.make(),
                        ).flexible(),
                        gap18,
                        FilledButton(
                          onPressed: () async {
                            FocusScope.of(context).unfocus();
                            await onTapReceive.call(noteController.text);
                            undoToggle.call();
                            pop();
                          },
                          style: FilledButton.styleFrom(
                            padding: padding0,
                            foregroundColor: Colors.white,
                          ),
                          child: "Receive".text.base.make(),
                        ).flexible(),
                      ],
                    ),
                  ],
                )
              : Column(
                  mainAxisAlignment: mainStart,
                  children: [
                    Visibility(
                      visible: model.note.isNotBlank,
                      replacement: "No Note"
                          .text
                          .caption(context)
                          .makeCentered()
                          .p12()
                          .box
                          .roundedSM
                          .gray100
                          .width(1.sw)
                          .make()
                          .px8(),
                      child: Text.rich(
                        'Note:  '
                            .textSpan
                            .withChildren([
                              model.note.textSpan.make(),
                            ])
                            .bodySmall(context)
                            .letterSpacing(.8)
                            .make(),
                      )
                          .p12()
                          .box
                          .roundedSM
                          .colorPrimary(context, opacity: .1)
                          .border(color: ColorPalate.primary300.withOpacity(.4))
                          .width(1.sw)
                          .make()
                          .px8(),
                    ),
                    gap16,
                    KElevatedButton(
                      onPressed: undoToggle,
                      backgroundColor: context.colors.secondary,
                      foregroundColor: context.theme.scaffoldBackgroundColor,
                      text: 'Undo',
                    ).px8(),
                  ],
                ),
        ),
      ),
    );
  }
}
