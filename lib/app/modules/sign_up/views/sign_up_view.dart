import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/custom_rich_text/custom_rich_text.dart';
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
    return Scaffold(
      appBar: ReusableAppBar(showLogo: true),
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
                  "Who's riding today?",
                  style: GoogleFontStyles.h1(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8.h),
                // Description Text
                Text(
                  "Your driver will verify your name upon arrival",
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
                            'First Name',
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
                                return 'Please enter your first name';
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
                            'Last Name',
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
                                return 'Please enter your last name';
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
                      'Email',
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
                        normalText: "By continuing, I agree that Rydr may collect, use, and share the information I provide in accordance with the Privacy Policy. I also confirm that I have read, understood, and agree to the Terms & Conditions",
                        clickableTexts: ["Privacy Policy", "Terms & Conditions"],
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
                    if (_formKey.currentState!.validate() && _isAgreed) {
                      Get.toNamed('/OTP');
                    } else if (!_isAgreed) {
                      Get.snackbar(
                        'Terms Required',
                        'Please agree to the Terms & Conditions to continue',
                        backgroundColor: Colors.red.withOpacity(0.8),
                        colorText: Colors.white,
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    }
                  },
                  text: 'Continue',
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