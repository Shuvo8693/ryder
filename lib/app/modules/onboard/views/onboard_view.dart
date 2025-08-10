import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/onboard_controller.dart';

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
              const SizedBox(height: 80),
              const Text(
                'rydr',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),

              // Spacer to push illustration to center
              const Spacer(flex: 2),

              // Illustration placeholder
              Container(
                width: 280.w,
                height: 200.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[800], // Placeholder background
                ),
                child: const Center(
                  child: Text('Illustration will go here\n(Shield + Person + Device)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),

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
