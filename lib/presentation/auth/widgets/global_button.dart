import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
class GlobalButton extends StatelessWidget {
  GlobalButton({Key? key, required this.title, required this.onTap, required this.color, required this.borderColor, required this.textColor,this.isSvg=""})
      : super(key: key);

  final String title;
  final VoidCallback onTap;
  final Color color;
  final Color borderColor;
  final Color textColor;
  String isSvg;

  @override
  Widget build(BuildContext context) {
    return ZoomTapAnimation(
      onTap: onTap,
      child: Container(
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.sp),
          color: color,
          border: Border.all(color: borderColor,width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: isSvg.isNotEmpty?SvgPicture.asset(isSvg):Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: textColor,
                fontSize: 18.sp,
                fontFamily: "LeagueSpartan",
              ),
            ),
          ),
        ),
      ),
    );
  }
}