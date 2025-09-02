import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';
import 'package:ryder/common/widgets/custom_text_field.dart';

enum LocationType { pickup, dropoff }

class LocationPickerModalSheetItem extends StatefulWidget {
  final LocationType locationType;
  final List<String>? initialAddress;
  final Function(String)? onAddressConfirmed;
  final int index;

  const LocationPickerModalSheetItem({
    super.key,
    required this.locationType,
    this.initialAddress,
    this.onAddressConfirmed, required this.index,
  });

  @override
  State<LocationPickerModalSheetItem> createState() => _LocationPickerModalSheetItemState();
}

class _LocationPickerModalSheetItemState extends State<LocationPickerModalSheetItem> {
   final List<TextEditingController> _addressController = [TextEditingController(),TextEditingController()];

  @override
  void initState() {
    super.initState();
    // _addressController[widget.index] =  TextEditingController(
    //     text: widget.initialAddress?[widget.index] ?? ''
    // );
  }

  @override
  void dispose() {
    _addressController[widget.index].dispose();
    super.dispose();
  }

  void _handleConfirmLocation() {
    if (_addressController[widget.index].text.trim().isNotEmpty) {
      widget.onAddressConfirmed?.call(_addressController[widget.index].text.trim());
     // Navigator.of(context).pop();
    }
  }

  String get _title {
    switch (widget.locationType) {
      case LocationType.pickup:
        return 'Pickup location';
      case LocationType.dropoff:
        return 'Drop-off location';
    }
  }

  String get _buttonText {
    switch (widget.locationType) {
      case LocationType.pickup:
        return 'Confirm Pickup';
      case LocationType.dropoff:
        return 'Confirm Drop-off';
    }
  }

  String get _hintText {
    switch (widget.locationType) {
      case LocationType.pickup:
        return 'Enter pickup address';
      case LocationType.dropoff:
        return 'Enter drop-off address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          // Drag handle
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Content
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  _title,
                  style: GoogleFontStyles.h3(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 8.h),

                // Subtitle
                Text(
                  'Drag to move pin',
                  style: GoogleFontStyles.h6(
                    color: Colors.grey[400],
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: 20.h),

                // Address input field
                CustomTextField(
                  controller: _addressController[widget.index],
                  contentPaddingVertical: 16.h,
                  hintText: _hintText,
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                    size: 20.sp,
                  ),
                ),

                SizedBox(height: 24.h),

                // Confirm button
                CustomButton(
                  text: _buttonText,
                  onTap: _handleConfirmLocation,
                  width: double.infinity,
                  height: 52.h,
                ),

                // Bottom padding for safe area
                SizedBox(height: MediaQuery.of(context).padding.bottom + 10.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============== Pickup ============
void showPickupLocationModal(
    BuildContext context, {
      String? initialAddress,
      Function(String)? onAddressConfirmed,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => LocationPickerModalSheetItem(
      locationType: LocationType.pickup,
      initialAddress: [initialAddress!],
      onAddressConfirmed: onAddressConfirmed, index: 0,
    ),
  );
}
 // ============== dropOff ============
void showDropOffLocationModal(
    BuildContext context, {
      String? initialAddress,
      Function(String)? onAddressConfirmed,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => LocationPickerModalSheetItem(
      locationType: LocationType.dropoff,
      initialAddress: [initialAddress!],
      onAddressConfirmed: onAddressConfirmed, index: 1,
    ),
  );
}

// Generic function if you want more control
void showLocationModal(
    BuildContext context, {
      required LocationType locationType,
      String? initialAddress,
      Function(String)? onAddressConfirmed,
    }) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => LocationPickerModalSheetItem(
      locationType: locationType,
      initialAddress: [initialAddress!],
      onAddressConfirmed: onAddressConfirmed, index: 0,
    ),
  );
}

// Usage examples:
// For pickup:
// showPickupLocationModal(
//   context,
//   initialAddress: '128 Ward Ave',
//   onAddressConfirmed: (address) {
//     print('Pickup address: $address');
//   },
// );

// For dropoff:
// showDropoffLocationModal(
//   context,
//   initialAddress: 'Downtown Mall',
//   onAddressConfirmed: (address) {
//     print('Dropoff address: $address');
//   },
// );

// Generic usage:
// showLocationModal(
//   context,
//   locationType: LocationType.pickup,
//   initialAddress: '128 Ward Ave',
//   onAddressConfirmed: (address) {
//     print('Selected address: $address');
//   },
// );