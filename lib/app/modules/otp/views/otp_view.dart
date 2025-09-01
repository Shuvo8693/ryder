import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:ryder/app/modules/otp/controllers/resend_otp_controller.dart';
import 'package:ryder/app/routes/app_pages.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/app_text_style/style.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';

import 'package:ryder/common/widgets/custom_button.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ryder/common/widgets/spacing.dart';
import 'package:ryder/l10n/app_localizations.dart';

import '../controllers/otp_controller.dart';

class OtpView extends StatefulWidget {
  const OtpView({super.key});

  @override
  State<OtpView> createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  OtpController otpController = Get.put(OtpController());
  ResendOtpController resendOtpController = Get.put(ResendOtpController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int _start = 159; // 3 min
  Timer _timer = Timer(const Duration(seconds: 1), () {});

  startTimer() {
    print("Start $_start");
    print("Start Time$_timer");
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_start > 0) {
          _start--;
        } else {
          _timer.cancel();
        }
      });
    });
  }

  String get timerText {
    int minutes = _start ~/ 60;

    /// ~/ eta vag kora {When (_start 179 ~/ 60=2.98 ),(_start 119 ~/ 60 = 1.98 ),(_start 59 ~/ 60 = 0.98 ) }
    int seconds = _start % 60;

    /// Vag sesh, The remainder is 150−120=30, 30 is reminder, if _start is 119 then second will set to 59 cause reminder is 59 ({60*2=120} then 60*1=60 ,if 119 then 119-60=59)
    /// When _start = 59 is divided by 60, the quotient is 0 (since 59 is less than 60), and the remainder is 59. {eta hocce vag sesh , jeta dea multiply kora jabe na obosisto number ty reminder hobe }
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  bool isResetPassword = false;

  @override
  void initState() {
    super.initState();
    startTimer();
    if(Get.arguments !=null && Get.arguments['isResetPass'] != null){
      resetPassConfirmation();
    }
  }
 resetPassConfirmation(){
  bool resetPass =  Get.arguments['isResetPass'] as bool;
  if(resetPass == true){
    isResetPassword = resetPass;
  }
 }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: ReusableAppBar(showLogo: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 55.h),
               // buildOtpSupportText(email:Get.arguments['email'].toString()),
                SizedBox(height: 30.h),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.enter_your_code,style: GoogleFontStyles.h1(fontWeight: FontWeight.w600),),
                    verticalSpacing(8.h),
                    Text("${l10n.we_sent_code_to} +1 571-289-3329 ",style: GoogleFontStyles.h5(fontWeight: FontWeight.w600),),
                    verticalSpacing(8.h),
                    Text(l10n.please_enter_to_verify,style: GoogleFontStyles.h5(fontWeight: FontWeight.w600),),
                    verticalSpacing(30.h),
                    PinCodeTextField(
                      cursorColor: Colors.white,
                      keyboardType: TextInputType.number,
                      controller: otpController.otpCtrl,
                      autoDisposeControllers: false,
                      enablePinAutofill: false,
                      appContext: context,
                      autoFocus: true,
                      textStyle: const TextStyle(),
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.circle,
                        //borderRadius: BorderRadius.circular(125.r),
                        fieldHeight: 65.h,
                        fieldWidth: 50.w,
                        activeFillColor: AppColors.gray.withOpacity(0.7),
                        selectedFillColor: AppColors.seconderyAppColor,
                        inactiveFillColor: AppColors.seconderyAppColor,
                        borderWidth: 0.5,
                        errorBorderColor: Colors.red,
                        activeBorderWidth: 0.5,
                        selectedColor: AppColors.primaryColor,
                        inactiveColor: AppColors.greyColor,
                        activeColor: AppColors.primaryColor,
                      ),
                      length: 6,
                      enableActiveFill: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return l10n.enter_your_pin_code;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 20.h),

                    Text(timerText, style: GoogleFontStyles.h4()),

                    SizedBox(height: 30.h),

                    ///======Action Button======
                    Obx(() {
                      return CustomButton(
                          loading: otpController.isLoading.value,
                          onTap: () async {
                            Get.toNamed(Routes.SIGN_UP);
                            if (_formKey.currentState!.validate()) {
                             // await otpController.sendOtp(isResetPassword);
                            }
                          },
                          text: l10n.verify_now);
                    }),

                    SizedBox(height: 35.h),

                    /// Resent Button
                    timerText == "00:00"
                        ? InkWell(
                            onTap: () async {
                             await resendOtpController.reSendOtp(false);
                              _start = 150;
                              startTimer();
                              setState(() {});
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  l10n.did_not_receive_code,
                                  style: GoogleFontStyles.h4(),
                                ),
                                Text(
                                  l10n.resend_it,
                                  style: GoogleFontStyles.h4(color: Colors.blueAccent ),
                                ),
                              ],
                            ),
                          ) : const SizedBox(),
                  ],
                ),
                // const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText buildOtpSupportText({String? email,AppLocalizations? l10n}) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: l10n?.we_sent_code_to,
        style: AppStyles.h4(color: AppColors.gray), // Use default text style
        children: [
          TextSpan(
            text: email ?? '', // Highlighted email
            style: const TextStyle(
              color: AppColors.gray, // Change color for the email
              fontWeight: FontWeight.bold,
            ),
          ),
          const TextSpan(
            text:
                ". If you don't see the email in your inbox, check your spam folder. Email codes can take up to 1-2 minutes to arrive :",
          ),
        ],
      ),
    );
  }
}
