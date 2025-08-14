import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_images/app_svg.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/custom_image_provider/custom_image_provider.dart';
import 'package:ryder/common/widgets/custom_button.dart';

class UpdateConfirmationScreen extends StatelessWidget {
  const UpdateConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(showLogo: true),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          children: [
            // Main content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    'Never miss an update',
                    style: GoogleFontStyles.h2(
                      fontWeight: FontWeight.w600,
                    ),

                  ),

                  SizedBox(height: 12.h),

                  // Description
                  Text(
                    'Receive real-time driver updates, along with exclusive deals and tailored discounts, all designed to make your journey smoother and more rewarding. Stay informed and enjoy the benefits every time you ride!',
                    style: GoogleFontStyles.h5(
                      height: 1.5,
                      fontWeight: FontWeight.w500
                    ),
                    textAlign: TextAlign.start,
                  ),

                  SizedBox(height: 60.h),

                  // App update image
                  ImageAsset.svg(AppSvg.appUpdateSvg).toImage(width: 350.w,height: 296.h),

                  SizedBox(height: 40.h),

                  // Allow button
                  CustomButton(
                    onTap: () {
                      // Handle allow permission
                      print("Allow notifications pressed");
                    },
                    text: 'Allow',
                  ),

                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
