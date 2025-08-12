import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      this.color,
      this.textStyle,
      this.paddingInner = EdgeInsets.zero,
      required this.onTap,
      required this.text,
      this.loading = false,
      this.width,
      this.height});

  final Function() onTap;
  final String text;
  final bool loading;
  final double? height;
  final double? width;
  final Color? color;
  final EdgeInsetsGeometry paddingInner;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? () {} : onTap,
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(79.r)),
        backgroundColor: color ?? AppColors.buttonBackgroundColor,
        minimumSize: Size(width ?? Get.width, height ?? 53.h),
        padding: paddingInner,
      ),
      child: loading
          ? SizedBox(
              height: 20.h,
              width: 20.h,
              child: const CircularProgressIndicator(
                color: Colors.white,
              ),
            )
          : Text(
              text,
              style: textStyle ??
                  AppStyles.customSize(
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      family: GoogleFonts.inder.toString(),
                      letterSpacing: 1,
                      size: 18.sp
                  ),
            ),
    );
  }
}
