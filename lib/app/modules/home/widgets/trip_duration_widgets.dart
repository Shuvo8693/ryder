import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ryder/common/app_text_style/google_app_style.dart';

class TripDurationWidget extends StatelessWidget {
  final String duration;
  final String destination;
  final VoidCallback? onTap;

  const TripDurationWidget({
    super.key,
    required this.duration,
    required this.destination,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A3E),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Trip duration $duration',
                    style: GoogleFontStyles.h5(
                      color: Colors.grey[400],
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    destination,
                    style: GoogleFontStyles.h4(
                      fontWeight: FontWeight.w600,
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
    );
  }
}

// ===== Usage example: =======
// class TripDurationExample extends StatelessWidget {
//   const TripDurationExample({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF1A1A2E),
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(16.w),
//           child: Column(
//             children: [
//               TripDurationWidget(
//                 duration: '10 minutes',
//                 destination: '128 Ward Ave',
//                 onTap: () {
//                   // Handle tap - navigate to trip details or start trip
//                   print('Trip duration widget tapped');
//                 },
//               ),
//               SizedBox(height: 12.h),
//
//               // Another example
//               TripDurationWidget(
//                 duration: '15 minutes',
//                 destination: '456 Main Street',
//                 onTap: () {
//                   print('Second trip tapped');
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }