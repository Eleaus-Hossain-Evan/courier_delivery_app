import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

import '../../application/home/home_provider.dart';
import '../../application/notification/notification_provider.dart';
import '../../utils/utils.dart';
import '../widgets/widgets.dart';

class NotificationScreen extends HookConsumerWidget {
  static String route = "/notification";
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(notificationProvider);
    final loading = useState(false);

    ref.listen(notificationProvider, (previous, next) {
      if (previous!.loading == false && next.loading) {
        BotToast.showLoading();
        loading.value = true;
      }
      if (previous.loading == true && next.loading == false) {
        BotToast.closeAllLoading();
        loading.value = false;
      }
    });

    useEffect(() {
      Future.microtask(() {
        ref.read(notificationProvider.notifier).getNotification();
      });
      Future.microtask(() {
        ref.read(homeProvider.notifier).removeNotificationBadge();
      });
      return () => ref.invalidate(notificationProvider);
    }, const []);
    return Scaffold(
      appBar: const KAppBar(
        titleText: AppStrings.notifications,
        leading: BackButton(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            KListViewSeparated(
              shrinkWrap: true,
              padding: EdgeInsetsDirectional.fromSTEB(20.w, 16.h, 20.w, 16.h),
              itemBuilder: (context, index) {
                // final notification = state.notifications[index];
                return const SizedBox();
              },
              itemCount: state.notifications.length,
              separator: SizedBox(height: 12.h),
              alternateWidget: "No Notification available"
                  .text
                  .caption(context)
                  .lg
                  .color(ColorPalate.black700)
                  .make(),
            ),
          ],
        ),
      ),
    );
  }
}
