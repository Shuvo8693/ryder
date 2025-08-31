import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/widgets/custom_button.dart';
import 'package:ryder/common/widgets/custom_text_field.dart';
import 'package:ryder/common/widgets/spacing.dart';

class AddPlaceView extends StatefulWidget {
  const AddPlaceView({super.key});

  @override
  State<AddPlaceView> createState() => _AddPlaceViewState();
}

class _AddPlaceViewState extends State<AddPlaceView> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  String selectedAddress = "Hamilton, ON";

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            size: 24.sp,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Place',
          style: GoogleFontStyles.h3(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 32.h),

            // Name Section
            Text(
              'Name',
              style: GoogleFontStyles.h4(
                color: Colors.white,
              ),
            ),
            SizedBox(height: 12.h),

            CustomTextField(
              controller: nameController,
              hintText: 'Place name',
              suffixIcon: nameController.text.isNotEmpty ? IconButton(
                icon: Icon(
                  Icons.clear,
                  color: Colors.grey[400],
                  size: 20.sp,
                ),
                onPressed: () {
                  setState(() {
                    nameController.clear();
                  });
                },
              ) : null,
            ),

            SizedBox(height: 32.h),

            // Address Section
            Text(
              'Address',
              style: GoogleFontStyles.h4(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12.h),

            // Address Selection Container
            GestureDetector(
              onTap: () {
                _showAddressSelection();
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 16.h,
                ),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: Colors.grey[700]!,
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Address',
                            style: GoogleFontStyles.h6(
                              color: Colors.grey[400],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            selectedAddress,
                            style: GoogleFontStyles.h4(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                      size: 24.sp,
                    ),
                  ],
                ),
              ),
            ),

            Spacer(),

            // Save Button
            Padding(
              padding: EdgeInsets.only(bottom: 32.h),
              child: CustomButton(
                text: 'Save',
                onTap: () {
                  _savePlace();
                },
                height: 56.h,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddressSelection() {
    // Navigate to address selection screen or show address picker
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 40.w,
                  height: 4.h,
                  margin: EdgeInsets.symmetric(vertical: 12.h),
                  decoration: BoxDecoration(
                    color: Colors.grey[600],
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),

              Text(
                'Select Address',
                style: GoogleFontStyles.h3(
                  fontWeight: FontWeight.w600,
                ),
              ),
              verticalSpacing(8.h),
              // Search field for address
              CustomTextField(
                controller: addressController,
                hintText: 'Search for an address...',
                prefixIcon: Icon(
                  Icons.search,
                  color: Colors.grey[400],
                  size: 20.sp,
                ),
              ),

              SizedBox(height: 10.h),
              Text('Recent Rides',style: GoogleFontStyles.h2(),),
              SizedBox(height: 10.h),

              // Address suggestions list
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    _buildAddressOption('Hamilton, ON', 'Current Location'),
                    _buildAddressOption('Toronto, ON', 'Ontario, Canada'),
                    _buildAddressOption('Vancouver, BC', 'British Columbia, Canada'),
                    _buildAddressOption('Montreal, QC', 'Quebec, Canada'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddressOption(String address, String subtitle) {
    return ListTile(
      leading: Icon(
        Icons.location_on_outlined,
        color: Colors.grey[400],
        size: 24.sp,
      ),
      title: Text(
        address,
        style: GoogleFontStyles.h4(
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: GoogleFontStyles.h5(
          color: Colors.grey[400],
        ),
      ),
      onTap: () {
        setState(() {
          selectedAddress = address;
        });
        Navigator.pop(context);
      },
      contentPadding: EdgeInsets.symmetric(vertical: 4.h),
    );
  }

  void _savePlace() {
    if (nameController.text.trim().isEmpty) {
      // Show error - name is required
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a name for this place'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Save the place logic here
    final placeName = nameController.text.trim();
    final placeAddress = selectedAddress;

    print('Saving place: $placeName at $placeAddress');

    // Navigate back with result or show success message
    Navigator.pop(context, {
      'name': placeName,
      'address': placeAddress,
    });
  }
}