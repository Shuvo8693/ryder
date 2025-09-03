import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ryder/app/modules/home/widgets/home_bottom_sheet.dart';
import 'package:ryder/app/modules/home/widgets/location_picker_bottomSheet.dart';
import 'package:ryder/app/modules/home/widgets/pickup_dropoff_modalsheet.dart';
import 'package:ryder/app/modules/home/widgets/ride_option_bottom_sheet.dart';
import 'package:ryder/app/modules/onboard/widgets/language_selector.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/custom_map/reusable_map.dart';

class PickupDropOffView extends StatefulWidget {
  const PickupDropOffView({super.key});

  @override
  State<PickupDropOffView> createState() => _PickupDropOffViewState();
}

class _PickupDropOffViewState extends State<PickupDropOffView> {
  final GlobalKey<ReusableMapState> _mapKey = GlobalKey();
  String selectedLanguage = 'English';

  // Address state management
  String? pickupAddress;
  String? dropoffAddress;

  bool isPicked = false;
  bool isDropOff = false;

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
      extendBodyBehindAppBar: true,
      appBar: CustomAppBar(transparent: true,),
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

          /// Bottom Sheet
          // Persistent Bottom Sheet
          // PickupDropOffBottomSheet(
          //   pickupAddress: pickupAddress,
          //   dropoffAddress: dropoffAddress,
          //   onPickupTap: () {
          //     showPickupLocationModal(
          //       context,
          //       initialAddress: pickupAddress,
          //       onAddressConfirmed: (address) {
          //         setState(() {
          //           pickupAddress = address;
          //         });
          //       },
          //     );
          //   },
          //   onDropoffTap: () {
          //     showDropOffLocationModal(
          //       context,
          //       initialAddress: dropoffAddress,
          //       onAddressConfirmed: (address) {
          //         setState(() {
          //           dropoffAddress = address;
          //         });
          //       },
          //     );
          //   },
          //   onConfirmRide: () {
          //     // Handle ride confirmation
          //     print('Pickup: $pickupAddress');
          //     print('Dropoff: $dropoffAddress');
          //     // Navigate to next screen or show ride options
          //   },
          // ),
          if(!isPicked)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LocationPickerModalSheetItem(
              locationType: LocationType.pickup,
              initialAddress: ["Borobagh"],
              onAddressConfirmed: (value){
                if(value.isNotEmpty){
                  setState(() {
                    isPicked = !isPicked;
                  });
                }
              }, index: 0,
            ),
          ),
          if(isPicked)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: LocationPickerModalSheetItem(
              locationType: LocationType.dropoff,
              initialAddress: ["Uttarkhan"],
              onAddressConfirmed: (value){
                   if(value.isNotEmpty){
                     setState(() {
                       isDropOff = !isDropOff;
                     });
                   }
              }, index: 1,
            ),
          ),
          if(isPicked && isDropOff)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const RideOptionsBottomSheet(),
          ),
        ],
      ),
    );
  }

}
