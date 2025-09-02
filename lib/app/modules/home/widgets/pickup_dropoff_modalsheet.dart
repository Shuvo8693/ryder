import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';


class PickupDropOffBottomSheet extends StatefulWidget {
  final String? pickupAddress;
  final String? dropoffAddress;
  final VoidCallback? onPickupTap;
  final VoidCallback? onDropoffTap;
  final VoidCallback? onConfirmRide;

  const PickupDropOffBottomSheet({
    super.key,
    this.pickupAddress,
    this.dropoffAddress,
    this.onPickupTap,
    this.onDropoffTap,
    this.onConfirmRide,
  });

  @override
  State<PickupDropOffBottomSheet> createState() => _PickupDropOffBottomSheetState();
}

class _PickupDropOffBottomSheetState extends State<PickupDropOffBottomSheet> {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Drag handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: Colors.grey[600],
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Pickup Location Field
                GestureDetector(
                  onTap: widget.onPickupTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Pickup icon
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // Address text
                        Expanded(
                          child: Text(
                            widget.pickupAddress ?? 'Enter pickup location',
                            style: GoogleFontStyles.h5(
                              color: widget.pickupAddress != null
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        // Arrow icon
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[500],
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Dropoff Location Field
                GestureDetector(
                  onTap: widget.onDropoffTap,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: Colors.grey[700]!,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        // Dropoff icon
                        Container(
                          width: 8.w,
                          height: 8.h,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),

                        SizedBox(width: 12.w),

                        // Address text
                        Expanded(
                          child: Text(
                            widget.dropoffAddress ?? 'Enter drop-off location',
                            style: GoogleFontStyles.h5(
                              color: widget.dropoffAddress != null
                                  ? Colors.white
                                  : Colors.grey[500],
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        // Arrow icon
                        Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.grey[500],
                          size: 16.sp,
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Confirm Ride Button (only show if both addresses are selected)
                if (widget.pickupAddress != null && widget.dropoffAddress != null)
                  CustomButton(
                    text: 'Confirm Ride',
                    onTap: widget.onConfirmRide??(){},
                    width: double.infinity,
                    height: 52.h,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}