import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryder/common/custom_map/reusable_map.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ReusableMapState> _mapKey = GlobalKey();
  String selectedLanguage = 'English';

  // Sample map position (Hamilton, ON area)
  static const LatLng _center = LatLng(43.2557, -79.8711);

  // Sample car positions
  final Set<Marker> _carMarkers = {
    const Marker(
      markerId: MarkerId('car1'),
      position: LatLng(43.2567, -79.8721),
      icon: BitmapDescriptor.defaultMarker,
    ),
    const Marker(
      markerId: MarkerId('car2'),
      position: LatLng(43.2547, -79.8701),
      icon: BitmapDescriptor.defaultMarker,
    ),
    const Marker(
      markerId: MarkerId('car3'),
      position: LatLng(43.2537, -79.8691),
      icon: BitmapDescriptor.defaultMarker,
    ),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Reusable Map Layer
          ReusableMap(
            key: _mapKey,
            initialPosition: _center,
            initialZoom: 15.0,
            markers: _carMarkers,
            darkMode: true,
            showMyLocation: true,
            onTap: (LatLng location) {
              // Handle map tap
              print('Map tapped at: ${location.latitude}, ${location.longitude}');
            },
            customFloatingButton: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.white,
              onPressed: () {
                // Center to current location
                _mapKey.currentState?.animateToLocation(_center, zoom: 16.0);
              },
              child: Icon(
                Icons.my_location,
                color: Colors.black87,
                size: 20.sp,
              ),
            ),
          ),

          // Top Status Bar
          StatusBarWidget(),

          // Language Selector Popup
          Positioned(
            top: 100.h,
            left: 20.w,
            child: LanguageSelectorWidget(
              selectedLanguage: selectedLanguage,
              onLanguageChanged: (String language) {
                setState(() {
                  selectedLanguage = language;
                });
              },
            ),
          ),

          // Bottom Sheet with TabBarView
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomSheetWidget(
              onLocationSelected: (LatLng location, String title) {
                // Navigate to selected location on map
                _mapKey.currentState?.animateToLocation(location, zoom: 17.0);

                // Optionally add a marker for the destination
                setState(() {
                  _carMarkers.add(
                    Marker(
                      markerId: MarkerId('destination'),
                      position: location,
                      infoWindow: InfoWindow(title: title),
                      icon: BitmapDescriptor.defaultMarkerWithHue(
                        BitmapDescriptor.hueGreen,
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Status Bar Widget (Reusable)
class StatusBarWidget extends StatelessWidget {
  const StatusBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Container(
          height: 30.h,
          color: Colors.black.withOpacity(0.3),
          child: Row(
            children: [
              SizedBox(width: 10.w),
              Text(
                '9:41',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Spacer(),
              Icon(Icons.signal_cellular_4_bar,
                  color: Colors.white, size: 16.sp),
              SizedBox(width: 5.w),
              Icon(Icons.wifi, color: Colors.white, size: 16.sp),
              SizedBox(width: 5.w),
              Icon(Icons.battery_full, color: Colors.white, size: 16.sp),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}

// Language Selector Widget
class LanguageSelectorWidget extends StatelessWidget {
  final String selectedLanguage;
  final Function(String) onLanguageChanged;

  const LanguageSelectorWidget({
    super.key,
    required this.selectedLanguage,
    required this.onLanguageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF5D3FD3),
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: EdgeInsets.all(12.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildLanguageOption('English', selectedLanguage == 'English'),
          SizedBox(height: 8.h),
          _buildLanguageOption('Français', selectedLanguage == 'Français'),
          SizedBox(height: 8.h),
          _buildLanguageOption('Español', selectedLanguage == 'Español'),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return GestureDetector(
      onTap: () => onLanguageChanged(language),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
        child: Text(
          language,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14.sp,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

// Bottom Sheet Widget with TabBarView
class BottomSheetWidget extends StatefulWidget {
  final Function(LatLng, String)? onLocationSelected;

  const BottomSheetWidget({
    Key? key,
    this.onLocationSelected,
  }) : super(key: key);

  @override
  State<BottomSheetWidget> createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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
              hintText: 'Where are you headed?',
              prefixIcon: Icons.search,
              suffixIcon: Icons.schedule,
            ),
          ),

          // Greeting
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              'Good Morning, Emad',
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
                _buildTabItem('Recent Rides'),
                _buildTabItem('Saved'),
                _buildTabItem('Airport'),
                _buildTabItem('Attraction'),
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

// Saved Locations Tab with location data
class SavedLocationsTab extends StatelessWidget {
  final Function(LatLng, String)? onLocationTap;

  const SavedLocationsTab({Key? key, this.onLocationTap}) : super(key: key);

  final List<LocationItem> savedLocations = const [
    LocationItem(
      icon: Icons.local_florist,
      title: 'Royal Botanical Garden',
      subtitle: 'Hamilton, ON',
      position: LatLng(43.2896, -79.8784),
    ),
    LocationItem(
      icon: Icons.directions_bus,
      title: 'McMaster University Bus Terminal',
      subtitle: 'Hamilton, ON',
      position: LatLng(43.2609, -79.9192),
    ),
    LocationItem(
      icon: Icons.work,
      title: 'Work',
      subtitle: 'Hamilton, ON',
      position: LatLng(43.2557, -79.8711),
    ),
    LocationItem(
      icon: Icons.home,
      title: 'Home',
      subtitle: 'Hamilton, ON',
      position: LatLng(43.2500, -79.8660),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      itemCount: savedLocations.length,
      itemBuilder: (context, index) {
        final location = savedLocations[index];
        return GestureDetector(
          onTap: () {
            onLocationTap?.call(location.position, location.title);
          },
          child: _buildLocationItem(
            icon: location.icon,
            title: location.title,
            subtitle: location.subtitle,
          ),
        );
      },
    );
  }

  Widget _buildLocationItem({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Location Item Model
class LocationItem {
  final IconData icon;
  final String title;
  final String subtitle;
  final LatLng position;

  const LocationItem({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.position,
  });
}

// Other Tab implementations (simplified for brevity)
class RecentRidesTab extends StatelessWidget {
  final Function(LatLng, String)? onLocationTap;

  const RecentRidesTab({Key? key, this.onLocationTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _buildRideItem(
          icon: Icons.home,
          title: 'Home',
          subtitle: '123 Main St, Hamilton',
          time: '10 min ago',
        ),
        _buildRideItem(
          icon: Icons.work,
          title: 'Work',
          subtitle: 'Downtown Hamilton',
          time: 'Yesterday',
        ),
      ],
    );
  }

  Widget _buildRideItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String time,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
              ],
            ),
          ),
          Text(time, style: TextStyle(color: Colors.grey[500], fontSize: 11.sp)),
        ],
      ),
    );
  }
}

class AirportTab extends StatelessWidget {
  final Function(LatLng, String)? onLocationTap;

  const AirportTab({Key? key, this.onLocationTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _buildAirportItem(
          icon: Icons.flight_takeoff,
          title: 'Toronto Pearson Airport (YYZ)',
          subtitle: 'Terminal 1',
          distance: '45 km',
        ),
      ],
    );
  }

  Widget _buildAirportItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String distance,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
              ],
            ),
          ),
          Text(distance, style: TextStyle(color: Colors.grey[500], fontSize: 12.sp)),
        ],
      ),
    );
  }
}

class AttractionTab extends StatelessWidget {
  final Function(LatLng, String)? onLocationTap;

  const AttractionTab({Key? key, this.onLocationTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      children: [
        _buildAttractionItem(
          icon: Icons.castle,
          title: 'Dundurn Castle',
          subtitle: 'Historic Site',
          rating: '4.5',
        ),
      ],
    );
  }

  Widget _buildAttractionItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required String rating,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: Colors.grey[800],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20.sp),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: TextStyle(color: Colors.white, fontSize: 14.sp)),
                Text(subtitle, style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
              ],
            ),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 14.sp),
              SizedBox(width: 2.w),
              Text(rating, style: TextStyle(color: Colors.grey[400], fontSize: 12.sp)),
            ],
          ),
        ],
      ),
    );
  }
}

// Custom TextField Widget
class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextEditingController? controller;
  final Function(String)? onChanged;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48.h,
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: TextStyle(
          color: Colors.white,
          fontSize: 14.sp,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey[500],
            fontSize: 14.sp,
          ),
          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: Colors.grey[400], size: 20.sp)
              : null,
          suffixIcon: suffixIcon != null
              ? Container(
            margin: EdgeInsets.only(right: 8.w),
            child: Icon(suffixIcon, color: Colors.grey[400], size: 20.sp),
          )
              : null,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: prefixIcon == null ? 20.w : 0,
            vertical: 14.h,
          ),
        ),
      ),
    );
  }
}