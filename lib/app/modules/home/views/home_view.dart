import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryder/app/modules/home/widgets/home_bottom_sheet.dart';
import 'package:ryder/app/modules/onboard/widgets/language_selector.dart';
import 'package:ryder/common/custom_map/reusable_map.dart';
import 'package:ryder/common/localization_extension/localization_extension.dart';

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

          /// Language Selector Popup
          Positioned(
            top: 100.h,
            left: 20.w,
            child: LanguageSelectorWidget(),
          ),

          /// Bottom Sheet with TabBarView
          // Positioned(
          //   bottom: 0,
          //   left: 0,
          //   right: 0,
          //   child: HomeBottomSheet(
          //     isModal: true,
          //     onLocationSelected: (LatLng location, String title) {
          //       // Navigate to selected location on map
          //       _mapKey.currentState?.animateToLocation(location, zoom: 17.0);
          //
          //       // Optionally add a marker for the destination
          //       setState(() {
          //         _carMarkers.add(
          //           Marker(
          //             markerId: MarkerId('destination'),
          //             position: location,
          //             infoWindow: InfoWindow(title: title),
          //             icon: BitmapDescriptor.defaultMarkerWithHue(
          //               BitmapDescriptor.hueGreen,
          //             ),
          //           ),
          //         );
          //       });
          //     },
          //   ),
          // ),

          HomeBottomSheet(
            isModal: true,
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