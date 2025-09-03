import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_images/app_svg.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';

import 'mission_statement_woment_bottomsheet.dart';

class RideOptionsBottomSheet extends StatefulWidget {
  const RideOptionsBottomSheet({super.key});

  @override
  State<RideOptionsBottomSheet> createState() => _RideOptionsBottomSheetState();
}

class _RideOptionsBottomSheetState extends State<RideOptionsBottomSheet> {
  int selectedRideIndex = 0;

  final List<RideOption> rideOptions = [
    RideOption(
      title: 'Rydr Basic',
      passengers: 4,
      time: '2 minutes away',
      price: 'CA\$5.14',
      subtitle: 'Safe everyday rides',
      image: AppSvg.car_4Svg,
    ),
    RideOption(
      title: 'Rydr Female',
      passengers: 4,
      time: '2 minutes away',
      price: 'CA\$5.14',
      subtitle: 'Safe rides for women,\ndriven by women.',
      image: AppSvg.car_4Svg,
      hasSpecialIcon: true,
    ),
    RideOption(
      title: 'Rydr Family',
      passengers: 6,
      time: '2 minutes away',
      price: 'CA\$5.14',
      subtitle: 'Convenient group rides, at\na great price.',
      image: AppSvg.car_6Svg,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor, // Dark background color
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

          SizedBox(height: 20.h),

          // Ride options list
          ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: rideOptions.length,
            itemBuilder: (context, index) {
              return _buildRideOptionTile(rideOptions[index], index);
            },
          ),

          SizedBox(height: 20.h),

          // Next button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: CustomButton(
              onTap: () {
                // Handle next button press
                Navigator.pop(context, rideOptions[selectedRideIndex]);
              },
              text: 'Next',
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOptionTile(RideOption option, int index) {
    final bool isSelected = selectedRideIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedRideIndex = index;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.seconderyAppColor.withValues(alpha: 0.5) : Colors.transparent,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected ? AppColors.seconderyAppColor : Colors.transparent,
            width: 1.w,
          ),
        ),
        child: Row(
          children: [
            // Car icon
            SvgPicture.asset(option.image,height: 50.h,width: 70.w),
            SizedBox(width: 16.w),
            // ========= Ride details ==========
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        option.title,
                        style: GoogleFontStyles.h4(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      // Passenger icon and count
                      Icon(
                        Icons.person,
                        size: 16.sp,
                        color: Colors.white.withOpacity(0.7),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        '${option.passengers}',
                        style: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.7),
                        ),
                      ),
                      if (option.hasSpecialIcon) ...[
                        SizedBox(width: 8.w),
                        Container(
                          padding: EdgeInsets.all(2.w),
                          decoration: BoxDecoration(
                            color: Colors.pink.withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            Icons.female,
                            size: 12.sp,
                            color: Colors.pink,
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    option.time,
                    style: GoogleFontStyles.h6(
                      color: Colors.white.withOpacity(0.6),
                    ),
                  ),

                  if (option.subtitle.isNotEmpty) ...[
                    SizedBox(height: 4.h),
                    GestureDetector(
                      onTap: index==1?(){
                       showMissionBottomSheet(context);
                      }:null,
                      child: Text(option.subtitle,
                        style: GoogleFontStyles.h6(
                          color: Colors.white.withOpacity(0.6),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

            // Price and time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  option.price,
                  style: GoogleFontStyles.h4(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 2.h),
                Text(
                  '5:26 PM',
                  style: GoogleFontStyles.h6(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void showMissionBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const MissionStatementWomenBottomSheet(),
  );
}

class RideOption {
  final String title;
  final int passengers;
  final String time;
  final String price;
  final String subtitle;
  final String image;
  final bool hasSpecialIcon;

  RideOption({
    required this.title,
    required this.passengers,
    required this.time,
    required this.price,
    required this.subtitle,
    required this.image,
    this.hasSpecialIcon = false,
  });
}


// Usage example:
void showRideOptionsBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (context) => const RideOptionsBottomSheet(),
  );
}