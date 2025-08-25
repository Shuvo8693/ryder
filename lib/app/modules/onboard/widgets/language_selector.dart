import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/app/data/locale_controller.dart';
import 'package:ryder/common/app_color/app_colors.dart';

class LanguageSelectorWidget extends StatefulWidget {

  const LanguageSelectorWidget({
    super.key,
  });

  @override
  State<LanguageSelectorWidget> createState() => _LanguageSelectorWidgetState();
}

class _LanguageSelectorWidgetState extends State<LanguageSelectorWidget> {
  final LocaleController localeController = Get.put(LocaleController());
  bool showLanguageOptions = false;
  String selectedLanguage = 'English';
  @override
  Widget build(BuildContext context) {
    return Column(
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
                bool isSelected =selectedLanguage == locale.countryCode;
                return GestureDetector(
                  onTap: () {
                    localeController.setLocale(locale);
                    setState(() {
                      selectedLanguage = locale.countryCode!;
                      // showLanguageOptions = false;
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
      ],
    );
  }
}