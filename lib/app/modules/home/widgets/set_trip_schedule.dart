import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';

import 'package:ryder/common/widgets/custom_button.dart';


class TripSetScheduleBottomSheetItem extends StatefulWidget {
  const TripSetScheduleBottomSheetItem({super.key});

  @override
  State<TripSetScheduleBottomSheetItem> createState() => _TripSetScheduleBottomSheetItemState();
}

class _TripSetScheduleBottomSheetItemState extends State<TripSetScheduleBottomSheetItem> {
  String selectedOption = 'now'; // 'now' or 'later'

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final List<Map<String, dynamic>> rideOptions = [
      {
        'id': 'now',
        'title': l10n.now,
        'subtitle': l10n.requestNowAndGoAnywhere,
        'icon': Icons.access_time,
      },
      {
        'id': 'later',
        'title': l10n.later,
        'subtitle': l10n.requestLaterAndGoAnywhere,
        'icon': Icons.calendar_today_outlined,
      },
    ];

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: 12.h),
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Text(
              l10n.whenYouNeedARide,
              style: GoogleFontStyles.h3(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // Options List
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: rideOptions.map((option) => _buildRideOption(option)).toList(),
            ),
          ),

          SizedBox(height: 32.h),

          // Done Button
          Padding(
            padding: EdgeInsets.fromLTRB(20.w, 0, 20.w, 32.h),
            child: CustomButton(
              text: l10n.done,
              onTap: () {
                Navigator.pop(context, selectedOption);
              },
              height: 56.h,
              width: double.infinity,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOption(Map<String, dynamic> option) {
    final isSelected = selectedOption == option['id'];

    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedOption = option['id'];
          });
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: isSelected
                  ? Colors.white.withOpacity(0.3)
                  : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              // Icon Container
              Icon(
                option['icon'],
                color: Colors.white,
                size: 20.sp,
              ),

              SizedBox(width: 16.w),

              // Text content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      option['title'],
                      style: GoogleFontStyles.h4(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 2.h),
                    Text(
                      option['subtitle'],
                      style: GoogleFontStyles.h5(
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              // Radio button
              Container(
                width: 20.w,
                height: 20.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: isSelected
                        ? Colors.white
                        : Colors.grey[500]!,
                    width: 2,
                  ),
                ),
                child: isSelected
                    ? Center(
                  child: Container(
                    width: 10.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}