import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryder/app/modules/home/views/home_view.dart';


// Saved Locations Tab with location data
class SavedLocationsTab extends StatelessWidget {
  final Function(LatLng, String)? onLocationTap;

  const SavedLocationsTab({super.key, this.onLocationTap});

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

// Other Tab implementations (simplified for brevity)
class RecentRidesTab extends StatelessWidget {
  final Function(LatLng, String)? onLocationTap;

  const RecentRidesTab({super.key, this.onLocationTap});

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

  const AirportTab({super.key, this.onLocationTap});

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

  const AttractionTab({super.key, this.onLocationTap});

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