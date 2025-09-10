


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:bottom_picker/bottom_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:ryder/app/modules/home/widgets/ride_confirmation_bottom_sheet.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/handle_bar/handle_bar_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';

class ScheduleRideBottomSheet extends StatefulWidget {
  const ScheduleRideBottomSheet({super.key});

  @override
  State<ScheduleRideBottomSheet> createState() =>
      _ScheduleRideBottomSheetState();

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const ScheduleRideBottomSheet(),
    );
  }
}

class _ScheduleRideBottomSheetState extends State<ScheduleRideBottomSheet> {
  DateTime selectedDate = DateTime(2024, 11, 4);
  TimeOfDay selectedTime = const TimeOfDay(hour: 10, minute: 0);
  bool isAM = true;
  int selectedIndex = 3; // Fourth item selected as shown in image

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.85,
        decoration: BoxDecoration(
          color: AppColors.primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          children: [
            // Handle bar
            HandleBarStyle.defaultHandle(),
            // Header
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 24.sp,
                    ),
                  ),
                  Text(
                    'Schedule a Ride',
                    style: GoogleFontStyles.h4(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(width: 48.w), // Balance the back button
                ],
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    // Date and Time Selection List
                    _showDateTimePicker(context),
                    SizedBox(height: 20.h),

                    // Ride Information
                    Container(
                      padding: EdgeInsets.all(16.w),
                      decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated ride time : 5 minutes',
                            style: GoogleFontStyles.h5(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'Estimated drop-off time : 12:25 AM',
                            style: GoogleFontStyles.h5(
                              color: Colors.white.withOpacity(0.8),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Container(
                                width: 24.w,
                                height: 24.h,
                                decoration: BoxDecoration(
                                  color: Colors.grey.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(4.r),
                                ),
                                child: Icon(
                                  Icons.info_outline,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                              ),
                              SizedBox(width: 12.w),
                              Expanded(
                                child: Text(
                                  'Make changes or cancel without fees up to 1 hour before your ride.',
                                  style: GoogleFontStyles.h6(
                                    color: Colors.white.withOpacity(0.7),
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // SizedBox(height: 30.h),
                  ],
                ),
              ),
            ),

            // Bottom Button
            Padding(
              padding: EdgeInsets.all(8.sp),
              child: CustomButton(
                text: 'Confirm your ride',
                onTap: () {
                  RideConfirmationBottomSheet.show(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _showDateTimePicker(BuildContext context) {
    return BottomPicker.dateTime(
      minuteInterval: 5,
      displaySubmitButton: true,
      closeOnSubmit: false,
      backgroundColor: AppColors.primaryColor,
      // headerBuilder: (context) {
      //   return Row(
      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //     children: [
      //       Text(
      //         'Set ride date and time',
      //         style: GoogleFontStyles.h4(
      //           fontWeight: FontWeight.w600,
      //         ),
      //       ),
      //     ],
      //   );
      // },
      onSubmit: (date) {
        setState(() {
          selectedDate = date;
          selectedTime = TimeOfDay.fromDateTime(date);
          isAM = date.hour < 12;
        });
        Get.snackbar.call('Done','Submitted');
      },
      //  minDateTime: DateTime.now(),
      // maxDateTime: DateTime.now().add(const Duration(days: 30)),
      initialDateTime: selectedDate,
      buttonWidth: 200.w,
      pickerThemeData: CupertinoTextThemeData(
        pickerTextStyle: GoogleFontStyles.h4(
          color: Colors.white, // Set picker text color to white
          fontWeight: FontWeight.w400,
        ),
        dateTimePickerTextStyle: GoogleFontStyles.h4(
          color: Colors.white, // Set picker text color to white
          fontWeight: FontWeight.w400,
        ),
      ),
      gradientColors: [
        AppColors.seconderyAppColor,
        AppColors.seconderyAppColor,
      ],
    );
  }
}

// Usage example:
// To show the bottom sheet, call:
// ScheduleRideBottomSheet.show(context);
