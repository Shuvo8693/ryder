import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/app/data/locale_controller.dart';
import 'package:ryder/app/routes/app_pages.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';
import 'package:ryder/common/widgets/custom_button.dart';
import 'package:ryder/common/widgets/custom_text_field.dart';

class PhoneInputScreen extends StatefulWidget {
  const PhoneInputScreen({super.key});

  @override
  _PhoneInputScreenState createState() => _PhoneInputScreenState();
}

class _PhoneInputScreenState extends State<PhoneInputScreen> {
  String selectedCountry = 'Canada';
  String selectedCountryCode = '+1';
  String phoneNumber = '';
  bool showLanguageOptions = false;
  String selectedLanguage = 'English';
  TextEditingController phoneController = TextEditingController();
  final LocaleController localeController = Get.put(LocaleController());

  final List<Map<String, String>> countries = [
    {'name': 'Canada', 'code': '+1', 'flag': '🇨🇦', 'locale': 'en_CA'},
    {'name': 'United States', 'code': '+1', 'flag': '🇺🇸', 'locale': 'en_US'},
  ];

 // final List<String> languages = ['English', 'Français', 'Español'];

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }

  String _formatPhoneNumber(String input, String locale) {
    // Remove all non-digit characters
    String digitsOnly = input.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) return '';

    // Format based on locale
    if (locale == 'en_US' || locale == 'en_CA') {
      if (digitsOnly.length <= 3) {
        return '($digitsOnly';
      } else if (digitsOnly.length <= 6) {
        return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
      } else {
        return '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6, digitsOnly.length > 10 ? 10 : digitsOnly.length)}';
      }
    }

    return digitsOnly;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: ReusableAppBar(showLogo: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              // Language
              GestureDetector(
                onTap: () {
                  setState(() {
                    showLanguageOptions = !showLanguageOptions;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: showLanguageOptions? AppColors.butterflyBoshColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.language,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        selectedLanguage,
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.white,
                        size: 16.sp,
                      ),
                    ],
                  ),
                ),
              ),

              // Language Options Dropdown
              if (showLanguageOptions)
                Container(
                  width: 110.w,
                  margin: EdgeInsets.only(top: 8.h),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    color: AppColors.butterflyBoshColor, // Purple background like in image
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(48.r),
                      bottomRight: Radius.circular(48.r),
                      bottomLeft: Radius.circular(20.r),
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: LocaleController.supportedLocales.map((locale) {
                      bool isSelected = selectedLanguage == locale.countryCode;
                      return GestureDetector(
                        onTap: () {
                          localeController.setLocale(locale);
                          setState(() {
                            selectedLanguage = locale.countryCode!;
                            showLanguageOptions = false;
                          });
                        },
                        child: Padding(
                          padding: EdgeInsets.all(4.sp),
                          child: Text(
                            locale.countryCode!,
                            style: GoogleFonts.inter(
                              fontSize: 14.sp,
                              color: Colors.white,
                              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

              SizedBox(height: 40.h),

              // Title and subtitle
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      l10n.lets_get_started,
                      style: GoogleFonts.inter(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      l10n.enter_phone_number,
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 40.h),

              // Phone number input
              Row(
                children: [
                  // Country selector
                  GestureDetector(
                    onTap: () {
                      _showCountrySelector();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                      decoration: BoxDecoration(
                        color:  AppColors.buttonBackgroundColor,
                        shape: BoxShape.rectangle, // Default shape
                        borderRadius: BorderRadius.circular(80.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            countries.firstWhere((c) => c['name'] == selectedCountry)['flag']!,
                            style: TextStyle(fontSize: 20.sp),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            selectedCountryCode,
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Phone number input with intl formatting
                  Expanded(
                    child: Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 10.w),
                      child: TextField(
                        controller: phoneController,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.white,
                        ),
                        decoration: InputDecoration(
                          hintText: '(571) 289-3329',
                          hintStyle: GoogleFonts.inter(
                            fontSize: 16.sp,
                            color: Colors.white.withOpacity(0.5),
                          ),
                          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                        ),
                        keyboardType: TextInputType.phone,
                        onChanged: (value) {
                          String currentLocale = countries.firstWhere((c) => c['name'] == selectedCountry)['locale']!;
                          String formattedValue = _formatPhoneNumber(value, currentLocale);
                          if (formattedValue != value) {
                            phoneController.value = TextEditingValue(
                              text: formattedValue,
                              selection: TextSelection.collapsed(offset: formattedValue.length),
                            );
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Custom Button from your code
              CustomButton(
                height: 60.h,
                onTap: () {
                  Get.toNamed(Routes.OTP);
                },
                text: l10n.continueButton,
              ),
              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountrySelector() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Color(0xFF2A2B3E),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: countries.map((country) {
              return ListTile(
                leading: Text(
                  country['flag']!,
                  style: TextStyle(fontSize: 24.sp),
                ),
                title: Text(
                  country['name']!,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                trailing: Text(
                  country['code']!,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    color: Colors.white,
                  ),
                ),
                onTap: () {
                  setState(() {
                    selectedCountry = country['name']!;
                    selectedCountryCode = country['code']!;
                  });
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }
}