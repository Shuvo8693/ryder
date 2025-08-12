
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ryder/common/themes/dark_theme.dart';

import 'app/routes/app_pages.dart';
import 'common/app_constant/app_constant.dart';
import 'common/controller/localization_controller.dart';
import 'common/controller/theme_controller.dart';
import 'common/di/di.dart';
import 'common/themes/light_theme.dart';
import 'common/widgets/message.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //Stripe.publishableKey = SKey.sPubTestKey;
  Map<String, Map<String, String>> _languages = await init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]).then((_){
    runApp(MyApp(
      languages: _languages,
    ));
  });

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});

  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(builder: (themeController) {
      return GetBuilder<LocalizationController>(builder: (localizeController) {
        return ScreenUtilInit(
            designSize: const Size(393, 852),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return GetMaterialApp(
                title: AppConstants.APP_NAME,
                debugShowCheckedModeBanner: false,
                navigatorKey: Get.key,
                //theme: themeController.darkTheme ? dark(): light(),
                theme: dark(context: context),
                defaultTransition: Transition.topLevel,
                locale: localizeController.locale,
                translations: Messages(languages: languages),
                fallbackLocale: Locale(AppConstants.languages[0].languageCode,
                    AppConstants.languages[0].countryCode),
                transitionDuration: const Duration(milliseconds: 500),
                getPages: AppPages.routes,
                initialRoute: AppPages.INITIAL,
              );
            });
      });
    });
  }
}
