import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ryder/app/routes/app_pages.dart';
import 'package:ryder/common/app_color/app_colors.dart';

import 'package:ryder/common/app_images/app_svg.dart';
import 'package:ryder/common/custom_appbar/custom_appbar.dart';
import 'package:ryder/common/custom_image_provider/custom_image_provider.dart';
import 'package:ryder/common/widgets/custom_button.dart';


class OnboardView extends StatelessWidget {
  const OnboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ReusableAppBar(showLogo: true),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
               const Spacer(flex: 2),
               ImageAsset.svg(AppSvg.onboardCarSvg).toImage(height: 217,width: 344),
               const Spacer(flex: 2),
              // Get started button
              CustomButton(
                height: 60.h,
                  onTap: (){
                    Get.toNamed(Routes.INPUTPHONENUMBER);
                  }, text: 'Get started'),

               SizedBox(height: 24.h),

              // Description text
               Text(
                'Start Riding with Fare Price!',
                style: GoogleFonts.inter(fontSize: 14,color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 8.h),
              Text('Launch the rider app to begin\nyour journey!',
                style: GoogleFonts.inter(fontSize: 14,color: AppColors.butterflyBoshColor),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 60.h),
            ],
          ),
        ),
      ),
    );
  }
}
