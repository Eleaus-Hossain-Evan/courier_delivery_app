// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easylogger/flutter_logger.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'application/auth/loggedin_provider.dart';
import 'application/local_storage/storage_handler.dart';
import 'application/auth/auth_provider.dart';
import 'application/global.dart';
import 'route/go_router.dart';

import '../../utils/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  final container = ProviderContainer(
    observers: [ProviderLog()],
  );

  Logger.init(
    true, // isEnable ，if production ，please false
    isShowFile: false, // In the IDE, whether the file name is displayed
    isShowTime: false, // In the IDE, whether the time is displayed
    isShowNavigation: true,
    levelVerbose: 247,
    levelDebug: 15,
    levelInfo: 10,
    levelWarn: 5,
    levelError: 9,
    phoneVerbose: Colors.white,
    phoneDebug: AppColors.success,
    phoneInfo: AppColors.info,
    phoneWarn: AppColors.warning,
    phoneError: AppColors.error,
  );
  final box = container.read(hiveProvider);
  await box.init();

  container.read(themeProvider);

  final String token = box.get(AppStrings.token, defaultValue: '');

  box.delete("theme");

  NetworkHandler.instance
    ..setup(baseUrl: EndPointPickUp.BASE_URL, showLogs: false)
    ..setToken(token);

  Logger.d('token: $token');
  runApp(
    ProviderScope(
      parent: container,
      observers: [ProviderLog()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);
    // final appTheme = ref.watch(themeProvider);
    final user = ref.watch(loggedInProvider.notifier).user.copyWith(
        // name: "name",
        // email: "evan@email.com",
        // firstName: "Evan",
        // lastName: "Hossain",
        // phone: "01234567890",
        // profilePicture: "https://i.pravatar.cc/300",
        );

    useEffect(() {
      Future.wait([
        Future.microtask(
          () => ref.read(authProvider.notifier).setUser(user),
        ),
        Future.microtask(
          () => ref.read(roleProvider.notifier).state = user.role,
        ),
        // Future.delayed(
        //     const Duration(seconds: 2), () => FlutterNativeSplash.remove()),
        // Future.microtask(
        //     () => ref.read(loggedInProvider.notifier).onAppStart()),
        // Future.microtask(
        //     () => ref.read(loggedInProvider.notifier).isLoggedIn()),
      ]);
      // ref.watch(isAuthenticateProvider);

      // Logger.d(ref.watch(isAuthenticateProvider).value);

      return null;
    }, []);

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: (context, child) {
        return DismissKeyboard(
          child: MaterialApp.router(
            title: AppStrings.appName,
            debugShowCheckedModeBanner: false,
            scaffoldMessengerKey: ref.watch(scaffoldKeyProvider),
            scrollBehavior: const ScrollBehavior()
                .copyWith(physics: const BouncingScrollPhysics()),
            //: Router
            routerConfig: router,
            //:BotToast
            builder: BotToastInit(),

            //:localization
            // localizationsDelegates: AppLocalizations.localizationsDelegates,
            // supportedLocales: AppLocalizations.supportedLocales,
            locale: ref.watch(appLocalProvider),

            //:theme
            // themeMode: appTheme.theme.isEmpty
            //     ? ThemeMode.system
            //     : appTheme.theme == "dark"
            //         ? ThemeMode.dark
            //         : ThemeMode.light,

            themeMode: Hive.box(AppStrings.cacheBox)
                    .listenable(keys: ['theme'])
                    .value
                    .get("theme", defaultValue: false)
                ? ThemeMode.dark
                : ThemeMode.light,

            theme: MyTheme.lightTheme,
            darkTheme: MyTheme.darkTheme,
          ),
        );
      },
    );
  }
}
