import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';

class RideConfirmationBottomSheet extends StatelessWidget {
  const RideConfirmationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.75,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  margin: EdgeInsets.only(bottom: 20.h),
                  width: 40.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              // Success message
              Text(
                'Your reservation is all set!',
                style: GoogleFontStyles.h3(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 24.h),

              // Ride type and car image
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Rydr Basic ',
                              style: GoogleFontStyles.h4(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Icon(
                              Icons.people,
                              color: Colors.white,
                              size: 16.sp,
                            ),
                            Text(
                              ' 4',
                              style: GoogleFontStyles.h5(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Thursday, November 27',
                          style: GoogleFontStyles.h5(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Pickup : 10:30 PM EST',
                          style: GoogleFontStyles.h5(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          'Drop-off : 10:30 PM EST',
                          style: GoogleFontStyles.h5(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Car image
                  Container(
                    width: 100.w,
                    height: 60.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Image.asset(
                      'assets/images/car_white.png', // Add your car image asset
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Icon(
                            Icons.directions_car,
                            color: Colors.white,
                            size: 40.sp,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Trip details
              Text(
                'Trip details',
                style: GoogleFontStyles.h4(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 16.h),

              // Pickup location
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '128 Ward Ave',
                          style: GoogleFontStyles.h5(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Hamilton, ON',
                          style: GoogleFontStyles.h6(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Destination
              Row(
                children: [
                  Container(
                    width: 12.w,
                    height: 12.h,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '128 Ward Ave',
                          style: GoogleFontStyles.h5(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Hamilton, ON',
                          style: GoogleFontStyles.h6(
                            color: Colors.white.withOpacity(0.7),
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),
              // Payment method
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.payment,
                      color: Colors.white,
                      size: 20.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      'Apple Pay',
                      style: GoogleFontStyles.h5(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Notification info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.notifications_outlined,
                      color: Colors.white,
                      size: 12.sp,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'We\'ll notify you as soon as your driver is on the way.',
                      style: GoogleFontStyles.h6(
                        color: Colors.white.withOpacity(0.7),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.h),

              // Cancellation info
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2.h),
                    width: 20.w,
                    height: 20.h,
                    decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(0.3),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.schedule_outlined,
                      color: Colors.white,
                      size: 12.sp,
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
              const Spacer(),
              // Cancel button
              CustomButton(
                text: 'Cancel ride',
                color: Colors.red,
                onTap: () {
                  _showCancelConfirmation(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCancelConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text(
          'Cancel Ride',
          style: GoogleFontStyles.h4(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: Text(
          'Are you sure you want to cancel this ride?',
          style: GoogleFontStyles.h5(
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Keep Ride',
              style: GoogleFontStyles.h5(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close bottom sheet
              // Handle cancellation logic
            },
            child: Text(
              'Cancel',
              style: GoogleFontStyles.h5(
                color: Colors.red,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      builder: (context) => const RideConfirmationBottomSheet(),
    );
  }
}

// Usage:
// RideConfirmationBottomSheet.show(context);