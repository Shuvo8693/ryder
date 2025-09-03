import 'package:get/get.dart';
import 'package:ryder/app/modules/home/views/add_place.dart';
import 'package:ryder/app/modules/home/views/pickup_dropoff_view.dart';
import 'package:ryder/app/modules/onboard/views/input_phone_view.dart';
import 'package:ryder/app/modules/onboard/views/update_confirmation_screen.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/onboard/bindings/onboard_binding.dart';
import '../modules/onboard/views/onboard_view.dart';
import '../modules/otp/bindings/otp_binding.dart';
import '../modules/otp/views/otp_view.dart';
import '../modules/sign_up/bindings/sign_up_binding.dart';
import '../modules/sign_up/views/sign_up_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.ONBOARD;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.ONBOARD,
      page: () => const OnboardView(),
      binding: OnboardBinding(),
    ),  GetPage(
      name: _Paths.UPDATECONFIRMATION,
      page: () => const UpdateConfirmationScreen(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.INPUTPHONENUMBER,
      page: () => PhoneInputScreen(),
      binding: OnboardBinding(),
    ),
    GetPage(
      name: _Paths.SIGN_UP,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),
    GetPage(
      name: _Paths.OTP,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: _Paths.ADDPLACE,
      page: () => AddPlaceView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PickupDropOff,
      page: () => PickupDropOffView(),
      binding: HomeBinding(),
    ),
  ];
}
