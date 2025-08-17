import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:ryder/app/data/locale_controller.dart';

import 'app/routes/app_pages.dart';
import 'common/app_constant/app_constant.dart';
import 'common/controller/theme_controller.dart';
import 'common/themes/dark_theme.dart';
import 'l10n/app_localizations.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Stripe.publishableKey = SKey.sPubTestKey;

  Get.put(ThemeController());
  Get.put(LocaleController());

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_){
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final localeController = Get.find<LocaleController>();

    return GetBuilder<ThemeController>(
        builder: (themeController) {
          return ScreenUtilInit(
              designSize: const Size(393, 852),
              minTextAdapt: true,
              splitScreenMode: true,
              builder: (_, child) {
                return Obx(() => GetMaterialApp(
                  title: AppConstants.APP_NAME,
                  debugShowCheckedModeBanner: false,
                  navigatorKey: Get.key,
                  theme: dark(context: context),
                  defaultTransition: Transition.topLevel,

                  localizationsDelegates: const [
                    AppLocalizations.delegate,
                    GlobalMaterialLocalizations.delegate,
                    GlobalWidgetsLocalizations.delegate,
                    GlobalCupertinoLocalizations.delegate,
                  ],
                  supportedLocales: LocaleController.supportedLocales,
                  locale: localeController.locale,
                  fallbackLocale: const Locale('en', 'US'),

                  transitionDuration: const Duration(milliseconds: 500),
                  getPages: AppPages.routes,
                  initialRoute: AppPages.INITIAL,
                ));
              }
          );
        }
    );
  }
}