import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ryder/app/modules/home/widgets/set_fare_price_bottom_sheet.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_images/app_svg.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/handle_bar/handle_bar_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';
import 'package:ryder/common/widgets/spacing.dart';

class RideBookingBottomSheet extends StatefulWidget {
  const RideBookingBottomSheet({super.key});

  @override
  State<RideBookingBottomSheet> createState() => _RideBookingBottomSheetState();
}

class _RideBookingBottomSheetState extends State<RideBookingBottomSheet> {
  String selectedPaymentMethod = 'Apple Pay';
  bool isScheduled = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.85.sh,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          HandleBarStyle.defaultHandle(),
          // Content
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Vehicle type and info
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Rydr Basic',
                                style: GoogleFontStyles.h3(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Icon(
                                Icons.person,
                                color: Colors.grey[400],
                                size: 16.sp,
                              ),
                              Text(
                                '4',
                                style: GoogleFontStyles.h6(
                                  color: Colors.grey[400],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            '2 minutes away',
                            style: GoogleFontStyles.h6(
                              color: Colors.grey[400],
                            ),
                          ),
                          Text(
                            'Safe everyday rides',
                            style: GoogleFontStyles.h6(
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      // Car illustration
                      Transform.flip(
                        flipX: true,
                          child: SvgPicture.asset(AppSvg.car_4Svg,height: 110.h,width: 200.w)),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Trip details
                  Text(
                    'Trip details',
                    style: GoogleFontStyles.h5(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Route info
                  Row(
                    children: [
                      /// todo ==== Should be use ListView for this Column
                      Column(
                        children: [
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                          Container(
                            width: 2.w,
                            height: 20.h,
                            color: Colors.grey[600],
                          ),
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        /// todo ==== Should be use ListView for this Column
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
                                color: Colors.grey[400],
                              ),
                            ),
                            SizedBox(height: 16.h),
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
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 20.h),

                  // Fare suggestion
                  Container(
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: AppColors.seconderyAppColor,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Recommended Fare : CA \$8.92',
                              style: GoogleFontStyles.h6(
                                color: Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Suggest your Fare : CA \$8.92',
                              style: GoogleFontStyles.h5(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                showSetFarePriceBottomSheet(context);
                              },
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey[400],
                                size: 18.sp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 20.h),

                  // Payment breakdown
                  Text(
                    'Payment',
                    style: GoogleFontStyles.h4(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 12.h),

                  // Fare breakdown
                  _buildPaymentRow('Fare', 'CA \$1'),
                  _buildPaymentRow('Operational fee', 'CA \$8.92'),
                  Divider(color: Colors.grey[700], thickness: 1),
                  _buildPaymentRow('Total', 'CA \$9.92', isTotal: true),

                  SizedBox(height: 20.h),

                  // Payment method and schedule
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            _showPaymentMethodPicker();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.seconderyAppColor,
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 24.w,
                                  height: 24.w,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(4.r),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Pay',
                                      style: GoogleFontStyles.h6(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  selectedPaymentMethod,
                                  style: GoogleFontStyles.h5(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.keyboard_arrow_down,
                                  color: Colors.grey[400],
                                  size: 20.sp,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12.w),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isScheduled = !isScheduled;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 12.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.seconderyAppColor,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: Colors.grey[400],
                                size: 20.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                'Schedule',
                                style: GoogleFontStyles.h5(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Icon(
                                Icons.keyboard_arrow_down,
                                color: Colors.grey[400],
                                size: 20.sp,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  const Spacer(),

                  // Confirm button
                  CustomButton(onTap: (){
                    _confirmRide();
                  }, text: 'Confirm your ride')
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFontStyles.h5(
              color: isTotal ? Colors.white : Colors.grey[400],
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
          Text(
            amount,
            style: GoogleFontStyles.h5(
              color: Colors.white,
              fontWeight: isTotal ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }

  void _showPaymentMethodPicker() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            HandleBarStyle.defaultHandle(),
            verticalSpacing(8.h),
            Text(
              'Payment Method',
              style: GoogleFontStyles.h3(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.h),
            _buildPaymentOption('Apple Pay'),
            _buildPaymentOption('Credit Card'),
            _buildPaymentOption('PayPal'),
            _buildPaymentOption('Cash'),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(String method) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPaymentMethod = method;
        });
        Navigator.pop(context);
      },
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Text(
          method,
          style: GoogleFontStyles.h4(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }

  void _confirmRide() {
    // Handle ride confirmation logic
    Navigator.pop(context);
    // Show confirmation or navigate to ride tracking
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Ride confirmed! Looking for a driver...'),
        backgroundColor: Colors.green,
      ),
    );
  }
}

// Helper function to show the modal
void showRideBookingModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => const RideBookingBottomSheet(),
  );
}

// set fare price bottom sheet
void showSetFarePriceBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => SetFarePriceBottomSheet(
      onFareSelected: (fare) {
        print('Selected fare: \$${fare.toStringAsFixed(2)}');
      },
    ),
  );
}