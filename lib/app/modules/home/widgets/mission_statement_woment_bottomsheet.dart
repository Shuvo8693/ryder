import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';

class MissionStatementWomenBottomSheet extends StatelessWidget {
  final String? missionText;
  final VoidCallback? onDonePressed;

  const MissionStatementWomenBottomSheet({
    super.key,
    this.missionText,
    this.onDonePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.seconderyAppColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          SizedBox(height: 24.h),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                // Info icon
                Row(
                  children: [
                    Container(
                      width: 24.w,
                      height: 24.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.6),
                          width: 1.5.w,
                        ),
                      ),
                      child: Icon(
                        Icons.info_outline,
                        size: 16.sp,
                        color: Colors.white.withOpacity(0.6),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 16.h),

                // Mission text
                Text(missionText ?? _defaultText,
                  style: GoogleFontStyles.h5(
                    height: 1.5,
                    fontSize: 15.sp,
                  ),
                ),

                SizedBox(height: 32.h),

                // Done button
                CustomButton(
                  onTap: onDonePressed ?? () => Navigator.pop(context),
                  text: 'Done',
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
        ],
      ),
    );
  }

  static const String _defaultText =
      "Our mission is to set a new standard for women's safety in ride-hailing. By offering a service exclusively for women drivers, we are proud to be among the first to prioritize a safer, more comfortable travel option for women. We understand the need for a secure environment where women can feel confident and respected on every ride. Our commitment goes beyond transportation—we're creating a community of empowerment and trust. With our skilled, caring women drivers, we offer a reliable and thoughtful alternative that supports and protects our riders, every day.";
}

// Usage
void showMissionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const MissionStatementWomenBottomSheet(),
  );
}