import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryder/app/modules/home/widgets/tab_bar_items.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';
import 'package:ryder/common/widgets/custom_text_field.dart';


class BottomSheetWidget extends StatefulWidget {
  final Function(LatLng, String)? onLocationSelected;

  const BottomSheetWidget({
    super.key,
    this.onLocationSelected,
  });

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _editingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Container(
      height: 380.h,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Handle bar
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 10.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),

          // Search Bar
          Padding(
            padding: EdgeInsets.all(16.w),
            child: CustomTextField(
              contentPaddingVertical: 18.h,
              hintText: l10n.where_are_you_headed,
              prefixIcon: Padding(
                padding: EdgeInsets.all(8.0.sp),
                child: Icon(Icons.search),
              ),
              suffixIcon: Padding(
                padding:  EdgeInsets.all(8.0.sp),
                child: Icon(Icons.calendar_today_outlined),
              ),
              controller: _editingController,
            ),
          ),

          // Greeting
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              l10n.good_morning_user('Shuvo'),
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Custom Tab Bar
          Container(
            height: 35.h,
            margin: EdgeInsets.symmetric(horizontal: 16.w),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.white,
              ),
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey[400],
              labelStyle: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
              ),
              labelPadding: EdgeInsets.symmetric(horizontal: 4.w),
              tabs: [
                _buildTabItem(l10n.recent_rides),
                _buildTabItem(l10n.saved),
                _buildTabItem(l10n.airport),
                _buildTabItem(l10n.attraction),
              ],
            ),
          ),

          SizedBox(height: 16.h),

          // Tab Bar View
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Recent Rides Tab
                RecentRidesTab(onLocationTap: widget.onLocationSelected),

                // Saved Tab
                SavedLocationsTab(onLocationTap: widget.onLocationSelected),

                // Airport Tab
                AirportTab(onLocationTap: widget.onLocationSelected),

                // Attraction Tab
                AttractionTab(onLocationTap: widget.onLocationSelected),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: Colors.grey[600]!,
          width: 1,
        ),
      ),
      child: Text(text),
    );
  }
}