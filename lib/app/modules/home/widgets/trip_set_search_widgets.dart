import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';

class TripSetSearchWidget extends StatelessWidget {
  final VoidCallback? onSearchTap;
  final VoidCallback? onScheduleTap;

  const TripSetSearchWidget({
    super.key,
    this.onSearchTap,
    this.onScheduleTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      decoration: BoxDecoration(
        color: AppColors.seconderyAppColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          // Search section
          Expanded(
            child: GestureDetector(
              onTap: onSearchTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 12.h,
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.search,
                      color: Colors.grey[400],
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(l10n.where_are_you_headed,
                      style: GoogleFontStyles.h5(
                        color: Colors.grey[400],
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Divider
          Container(
            width: 1.w,
            height: 24.h,
            color: AppColors.butterflyBoshColor,
          ),

          // Schedule section
          GestureDetector(
            onTap: onScheduleTap,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 12.h,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    color: Colors.grey[400],
                    size: 18.sp,
                  ),
                  SizedBox(width: 4.w),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey[400],
                    size: 18.sp,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Usage example:
class LocationSearchExample extends StatelessWidget {
  const LocationSearchExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A1A2E),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: TripSetSearchWidget(
            onSearchTap: () {
              // Handle search tap - open location picker modal
              print('Search tapped');
              // You can call your modal here:
              // showLocationPickerModal(context);
            },
            onScheduleTap: () {
              // Handle schedule tap - open date/time picker
              print('Schedule tapped');
            },
          ),
        ),
      ),
    );
  }
}