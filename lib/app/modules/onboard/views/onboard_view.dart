import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_icons/app_icons.dart';

import 'package:ryder/common/app_images/app_svg.dart';
import 'package:ryder/common/custom_image_provider/custom_image_provider.dart';
import 'package:ryder/common/svg_base64/ExtractionBase64Image.dart';


class OnboardView extends StatelessWidget {
  const OnboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              // Logo section
               SizedBox(height: 80.h),
               ExtractBase64ImageWidget(svgAssetPath: AppIcons.appIcons),
               const Spacer(flex: 2),
               ImageAsset.svg(AppSvg.onboardCarSvg).toImage(height: 217,width: 344),
               const Spacer(flex: 2),
              // Get started button
              Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF6C5CE7), Color(0xFF8B7ED8)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                ),
                child: ElevatedButton(
                  onPressed: () {
                    // Handle get started action
                    print('Get started pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'Get started',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Description text
              const Text(
                'Start Driving and Keep 80% of Each Fare!',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                'Launch the driver app to begin\nyour journey!',
                style: TextStyle(
                  fontSize: 14,
                  color: Color(0xFF8B7ED8),
                  height: 1.4,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }
}
