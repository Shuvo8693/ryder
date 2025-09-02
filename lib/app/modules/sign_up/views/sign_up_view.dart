import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/app/routes/app_pages.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/custom_rich_text/custom_rich_text.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';
import 'package:ryder/common/widgets/custom_button.dart';
import 'package:ryder/common/widgets/custom_text_field.dart';



class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  _SignUpViewState createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isAgreed = false;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: CustomAppBar(showLogo: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  l10n.who_is_riding_today,
                  style: GoogleFontStyles.h1(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                // Description Text
                Text(
                  l10n.your_driver_will_verify_name,
                  style: GoogleFontStyles.h5(
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 32.h),

                // First Name and Last Name in a Row
                Row(
                  children: [
                    // First Name TextField
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.first_name,
                            style: GoogleFontStyles.h5(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                            controller: _firstNameController,
                            hintText: 'Derrick',
                            contentPaddingVertical: 16.h,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.please_enter_first_name;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Last Name TextField
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.last_name,
                            style: GoogleFontStyles.h5(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          CustomTextField(
                            controller: _lastNameController,
                            hintText: 'Rose',
                            contentPaddingVertical: 16.h,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return l10n.please_enter_last_name;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.h),

                // Email TextField
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.email,
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    CustomTextField(
                      controller: _emailController,
                      hintText: 'example@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      contentPaddingVertical: 16.h,
                      isEmail: true, // This will trigger email validation
                    ),
                  ],
                ),
                SizedBox(height: 24.h),

                // Terms and Conditions Checkbox and Text
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 24.w,
                      height: 24.h,
                      child: Checkbox(
                        value: _isAgreed,
                        onChanged: (bool? value) {
                          setState(() {
                            _isAgreed = value ?? false;
                          });
                        },
                        side: BorderSide(
                          color: Colors.white.withOpacity(0.5),
                          width: 1.5,
                        ),
                        checkColor: Colors.black,
                        fillColor: WidgetStateProperty.resolveWith<Color>((states) {
                          if (states.contains(WidgetState.selected)) {
                            return Colors.white;
                          }
                          return Colors.transparent;
                        }),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: CustomRichText(
                        normalText: l10n.terms_and_conditions,
                        clickableTexts: [l10n.privacy_policy, l10n.terms_conditions],
                        maxLines: 5,
                        normalTextStyle: GoogleFontStyles.h6(
                          color: Colors.white,
                          height: 1.5,
                        ),
                        clickableTextStyle: GoogleFontStyles.h6(
                          color: Colors.blue,
                          height: 1.5,
                        ),
                        onTapCallbacks: [
                              () {
                            // Handle Privacy Policy tap
                            print("Privacy Policy tapped");
                            // Navigate to privacy policy or open URL
                          },
                              () {
                            // Handle Terms & Conditions tap
                            print("Terms & Conditions tapped");
                            // Navigate to terms or open URL
                          },
                        ],
                      ),
                    )
                  ],
                ),

               // const Spacer(), // Push button to bottom


                SizedBox(height: 80.h),
                // Continue Button - using your CustomButton or regular button
                CustomButton(
                  height: 56.h,
                  onTap: () {
                    Get.toNamed(Routes.UPDATECONFIRMATION);
                    if (_formKey.currentState!.validate() && _isAgreed) {
                      //Get.toNamed(Routes.UPDATECONFIRMATION);
                    } else if (!_isAgreed) {
                      Get.snackbar(
                        l10n.terms_required,
                        l10n.please_agree_terms,
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  text: l10n.continueButton,
                ),
                SizedBox(height: 20.h), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    super.dispose();
  }
}