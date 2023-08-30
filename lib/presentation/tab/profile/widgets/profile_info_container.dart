import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yukla/utils/colors/app_colors.dart';
class ProfileContainer extends StatelessWidget {
  const ProfileContainer({super.key, required this.text});

  final String text ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 50.h,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.c_0C1A30),
          borderRadius: BorderRadius.circular(10)
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(text,style: TextStyle(
                  color: AppColors.c_0C1A30,
                  fontWeight: FontWeight.w500,
                  fontSize: 14.sp,
                  fontFamily: "Sora"
                ),),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
