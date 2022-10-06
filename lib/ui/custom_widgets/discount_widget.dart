// import 'package:fedya_shashlik/ui/theme/color.dart';
// import 'package:fedya_shashlik/ui/theme/style.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class DiscountWidget extends StatelessWidget {
//   const DiscountWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 300.h,
//       width: 150.w,
//       padding: const EdgeInsets.all(8.0),
//       child: Card(
//         clipBehavior: Clip.hardEdge,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
//         child: Stack(
//           alignment: Alignment.topLeft,
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Image.asset(
//                   'assets/splash.jpg',
//                   height: 140.h,
//                   width: 150.w,
//                   fit: BoxFit.cover,
//                 ),
//                 const SizedBox(height: 12),
//                 Padding(
//                   padding: EdgeInsets.only(left: 12.w),
//                   child: Text(
//                     "Breakfast",
//                     style: AppTextStyles.title,
//                   ),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(
//                         children: [
//                           const Icon(
//                             Icons.star,
//                             color: AppColors.yellow,
//                             size: 16.0,
//                           ),
//                           Text(
//                             "4.4",
//                             style: AppTextStyles.label,
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "\$35.00",
//                         style: AppTextStyles.label.copyWith(
//                           color: AppColors.brownishOrange,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             Positioned(
//               left: 0.0,
//               top: 0.0,
//               child: ClipRRect(
//                 clipBehavior: Clip.antiAlias,
//                 clipper: DiscountShape(),
//                 child: Container(
//                   height: 20.h,
//                   width: 40.w,
//                   color: AppColors.orange,
//                   child: Text(
//                     "10%",
//                     textAlign: TextAlign.center,
//                     style: AppTextStyles.label.copyWith(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DiscountShape extends CustomClipper<RRect> {
//   @override
//   RRect getClip(Size size) {
//     return RRect.fromLTRBAndCorners(
//       0.0,
//       0.0,
//       size.width,
//       size.height,
//       topLeft: const Radius.circular(5.0),
//       topRight: Radius.zero,
//       bottomLeft: Radius.zero,
//       bottomRight: const Radius.circular(15.0),
//     );
//   }
//
//   @override
//   bool shouldReclip(covariant CustomClipper<dynamic> oldClipper) {
//     return false;
//   }
// }
