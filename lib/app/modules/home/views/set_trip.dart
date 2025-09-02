import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/app/modules/home/widgets/set_trip_schedule.dart';
import 'package:ryder/app/routes/app_pages.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';
import 'package:ryder/l10n/app_localizations.dart'; // Add this import

class SetTripSheetItem extends StatefulWidget {
  const SetTripSheetItem({super.key});

  @override
  State<SetTripSheetItem> createState() => _SetTripSheetItemState();
}

class _SetTripSheetItemState extends State<SetTripSheetItem> {
  final TextEditingController _pickupController = TextEditingController();
  final TextEditingController _dropOffController = TextEditingController();
  final TextEditingController _stopController = TextEditingController();
  bool isAddStop = false;
  // Sample recent rides data
  final List<Map<String, String>> recentRides = [
    {
      'name': 'Canada Post Westdale',
      'address': '991 King St W, Hamilton, ON L8S 1B0',
    },
    {
      'name': 'Best Buy',
      'address': '1779 Stone Church Rd E, Hamilton, ON L8J 0',
    },
    {
      'name': 'McMaster University',
      'address': '1280 W Main St, Hamilton, ON L8S 4L8',
    },
    {
      'name': 'Shaher INC.',
      'address': 'Hamilton, Ontario L8s 2C2',
    },
    {
      'name': '1085 Harrogate Dr',
      'address': 'Ancaster, Ontario L9K 1R2',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n; // Add this line
    return Container(
      height: 0.9.sh,
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
          Container(
            margin: EdgeInsets.only(top: 8.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: 16.w),
                Text(
                  l10n.where_are_you_headed, // Updated
                  style: GoogleFontStyles.h3(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          // Location inputs
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                // ================ Pickup location ======================
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 3.h),
                  decoration: BoxDecoration(
                      color: AppColors.seconderyAppColor,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: AppColors.butterflyBoshColor)
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.search,
                            color: Colors.grey[400],
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _pickupController,
                              style: GoogleFontStyles.h5(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: l10n.pickup_location, // Updated
                                hintStyle: GoogleFontStyles.h5(
                                  color: Colors.grey[500],
                                ),
                                filled: true,
                                fillColor: AppColors.seconderyAppColor,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      // ============= Add Stop location ================
                      if(isAddStop)
                        Column(
                          children: [
                            Divider(color: AppColors.butterflyBoshColor),
                            Row(
                              children: [
                                Icon(
                                  Icons.add,
                                  color: Colors.grey[400],
                                  size: 20.sp,
                                ),
                                SizedBox(width: 12.w),
                                Expanded(
                                  child: TextField(
                                    controller: _stopController,
                                    style: GoogleFontStyles.h5(color: Colors.white),
                                    decoration: InputDecoration(
                                      hintText: l10n.add_stop_location, // Updated
                                      hintStyle: GoogleFontStyles.h5(
                                        color: Colors.grey[500],
                                      ),
                                      filled: true,
                                      fillColor: AppColors.seconderyAppColor,
                                      border: InputBorder.none,
                                      enabledBorder: InputBorder.none,
                                      focusedBorder: InputBorder.none,
                                      errorBorder: InputBorder.none,
                                      focusedErrorBorder: InputBorder.none,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                      Divider(color: AppColors.butterflyBoshColor),
                      // ================ Drop-off location =============
                      Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: Colors.grey[400],
                            size: 20.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              controller: _dropOffController,
                              style: GoogleFontStyles.h5(color: Colors.white),
                              decoration: InputDecoration(
                                hintText: l10n.drop_off_location, // Updated
                                hintStyle: GoogleFontStyles.h5(
                                  color: Colors.grey[500],
                                ),
                                filled: true,
                                fillColor: AppColors.seconderyAppColor,
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                focusedErrorBorder: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),
          // Schedule for later Action buttons
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.seconderyAppColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: InkWell(
                      onTap: (){
                        //=======================<<<<
                        showTripSetScheduleBottomSheet(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.watch_later,
                            color: Colors.grey[400],
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Expanded(
                            child: Text(
                              l10n.schedule_for_later,
                              maxLines: 2,// Updated
                              style: GoogleFontStyles.h5(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey[400],
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                        ],
                      ),
                    ),
                  ),
                ),
                //  Add Stop Action buttons
                SizedBox(width: 12.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  decoration: BoxDecoration(
                    color: AppColors.seconderyAppColor,
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: GestureDetector(
                    onTap: (){
                      setState(() {
                        isAddStop = !isAddStop;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.grey[400],
                          size: 20.sp,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          l10n.add_stop, // Updated
                          style: GoogleFontStyles.h5(
                            color: Colors.grey[400],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Quick actions
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Get.toNamed(Routes.PickupDropOff);
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.mirageColor,
                        child: Icon(
                          Icons.map_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        l10n.set_location_on_map,
                        style: GoogleFontStyles.h5(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 12.w),
                GestureDetector(
                  onTap: () {
                    // Handle saved places
                  },
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: AppColors.mirageColor,
                        child: Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        l10n.saved_places, // Updated
                        style: GoogleFontStyles.h5(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // ==== Recent Rides section =======
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    l10n.recent_rides, // Updated
                    style: GoogleFontStyles.h4(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                SizedBox(height: 16.h),
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    itemCount: recentRides.length,
                    itemBuilder: (context, index) {
                      final ride = recentRides[index];
                      return GestureDetector(
                        onTap: () {
                          // Handle ride selection
                          Navigator.pop(context, ride);
                        },
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: Row(
                            children: [
                              Container(
                                width: 40.w,
                                height: 40.w,
                                decoration: BoxDecoration(
                                  color: AppColors.balticSeaColor,
                                  borderRadius: BorderRadius.all(Radius.circular(20.sp)),
                                ),
                                child: Icon(
                                  Icons.location_on,
                                  color: Colors.white,
                                  size: 20.sp,
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      ride['name']!,
                                      style: GoogleFontStyles.h5(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(height: 4.h),
                                    Text(
                                      ride['address']!,
                                      style: GoogleFontStyles.h6(
                                        color: Colors.grey[400],
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _pickupController.dispose();
    _dropOffController.dispose();
    super.dispose();
  }

  void showTripSetScheduleBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TripSetScheduleBottomSheetItem(),
    ).then((selectedOption) {
      if (selectedOption != null) {
        print('Selected option: $selectedOption');
        // Handle the selected option (now or later)
        if (selectedOption == 'now') {
          // Handle immediate ride request
        } else if (selectedOption == 'later') {
          // Handle scheduled ride request
          // You might want to show date/time picker here
        }
      }
    });
  }
}