import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/common/app_color/app_colors.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';

class SetFarePriceBottomSheet extends StatefulWidget {
  final double? initialFare;
  final double? recommendedFare;
  final double? minimumFare;
  final Function(double)? onFareSelected;

  const SetFarePriceBottomSheet({
    super.key,
    this.initialFare,
    this.recommendedFare = 9.92,
    this.minimumFare = 6.00,
    this.onFareSelected,
  });

  @override
  State<SetFarePriceBottomSheet> createState() => _SetFarePriceBottomSheetState();
}

class _SetFarePriceBottomSheetState extends State<SetFarePriceBottomSheet> {
  late TextEditingController _fareController;
  late double currentFare;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    currentFare = widget.initialFare ?? 7.92;
    _fareController = TextEditingController(text: currentFare.toStringAsFixed(2));
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _fareController.dispose();
    super.dispose();
  }

  void _updateFare(String value) {
    final fare = double.tryParse(value);
    if (fare != null) {
      setState(() {
        currentFare = fare;
      });
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

          SizedBox(height: 24.h),

          // Title
          Text(
            'Set Your Fare',
            style: GoogleFontStyles.h3(
              color: Colors.white,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 24.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Row(
              children: [
                Text(
                  'CA',
                  style: GoogleFontStyles.customSize(
                    fontWeight: FontWeight.w600,
                    size: 40.sp,
                  ),
                ),
                Expanded(
                  child: TextField(
                    controller: _fareController,
                    focusNode: _focusNode,
                    style: GoogleFontStyles.customSize(
                      fontWeight: FontWeight.w600,
                      size: 40.sp,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                      signed: false,
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
                    ],
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      isDense: true,
                      fillColor: Theme.of(context).primaryColor,
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 8.h, // Increase this value
                        horizontal: 8.w,
                      ),
                    ),
                    onChanged: _updateFare,
                    onTap: () {
                      setState(() {});
                    },
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Divider line
          Container(
            margin: EdgeInsets.symmetric(horizontal: 24.w),
            height: 1.h,
            color: Colors.white.withOpacity(0.3),
          ),

          SizedBox(height: 24.h),

          // Fare information
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                _buildFareRow(
                  'Recommended Fare :',
                  'CA \$${widget.recommendedFare!.toStringAsFixed(2)}',
                ),
                SizedBox(height: 12.h),
                _buildFareRow(
                  'Minimum Fare :',
                  'CA \$${widget.minimumFare!.toStringAsFixed(2)}',
                ),
              ],
            ),
          ),

          SizedBox(height: 32.h),

          // Done button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: CustomButton(
              onTap: () {
                widget.onFareSelected?.call(currentFare);
                Navigator.pop(context, currentFare);
              },
              text: 'Done',
            ),
          ),

          SizedBox(height: MediaQuery.of(context).viewInsets.bottom + 15.h ),
        ],
      ),
    );
  }

  Widget _buildFareRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFontStyles.h5(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16.sp,
          ),
        ),
        Text(
          value,
          style: GoogleFontStyles.h5(
            color: Colors.white.withOpacity(0.7),
            fontSize: 16.sp,
          ),
        ),
      ],
    );
  }
}

// Usage
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