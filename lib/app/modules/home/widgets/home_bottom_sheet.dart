import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryder/app/modules/home/views/set_trip.dart';
import 'package:ryder/app/modules/home/widgets/tab_bar_items.dart';
import 'package:ryder/app/modules/home/widgets/trip_set_search_widgets.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';

class HomeBottomSheet extends StatefulWidget {
  final Function(LatLng, String)? onLocationSelected;
  final bool isModal;

  const HomeBottomSheet({
    super.key,
    this.onLocationSelected,
    this.isModal = false,
  });

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();

  // Static method to show as modal bottom sheet
  static Future<void> showModal({
    required BuildContext context,
    Function(LatLng, String)? onLocationSelected,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      enableDrag: true,
      builder: (context) => HomeBottomSheet(
        onLocationSelected: onLocationSelected,
        isModal: true,
      ),
    );
  }
}

class _HomeBottomSheetState extends State<HomeBottomSheet> with SingleTickerProviderStateMixin {
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
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (widget.isModal) {
      // Modal bottom sheet version with DraggableScrollableSheet
      return DraggableScrollableSheet(
        initialChildSize: 0.54,
        expand: true,
        minChildSize: 0.3,
        maxChildSize: 0.9,
        builder: (context, scrollController) {
          return _buildContent(context, l10n);
        },
      );
    } else {
      // Positioned widget version
      return _buildContent(context, l10n);
    }
  }

  Widget _buildContent(BuildContext context, dynamic l10n) {
    return Container(
      height: widget.isModal ? null : 380.h,
      decoration: BoxDecoration(
        color:  Theme.of(context).primaryColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
        boxShadow: widget.isModal ? null : [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
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
            child: TripSetSearchWidget(
              onSearchTap: () {
                // Handle search tap - open location picker modal
                print('Search tapped');
                showSetTripModalSheet(context);
              },
              onScheduleTap: () {
                // Handle schedule tap - open date/time picker
                print('Schedule tapped');
              },
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

  // Helper function to show the modal
  void showSetTripModalSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SetTripSheetItem(),
    ).then((selectedLocation) {
      if (selectedLocation != null) {
        // Handle the selected location
        print('Selected location: $selectedLocation');
      }
    });
  }
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