import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/auth/pages/register_screen.dart';
import 'package:yukla/presentation/auth/widgets/global_button.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/images/app_images.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final PageController pageController = PageController();
  bool isLoginPage = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h),
        child: SafeArea(
          child: ListView(
            children: [
              SizedBox(height: 42.h),
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(right: 4.h),
                    child: Container(
                      height: 16.h,
                      width: 66.w,
                      decoration: BoxDecoration(
                        color: pageController.initialPage == 0
                            ? AppColors.c_999999
                            : AppColors.black,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: Container(
                      height: 16.h,
                      width: 66.w,
                      decoration: BoxDecoration(
                        color: pageController.initialPage == 0
                            ? AppColors.black
                            : AppColors.c_999999,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 580.h,
                child: PageView(
                  controller: pageController,
                  children: [
                    Column(
                      children: [
                        SizedBox(height: 33.h),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(AppImages.imageAuthSignUp))),
                        SizedBox(height: 24.h),
                        Center(
                          child: Text(
                            "Share Knowledge",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: Text(
                            "     Share the knowledge by writing on our platform for everyone to read",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(height: 33.h),
                        SizedBox(
                            height: MediaQuery.of(context).size.height / 2,
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(AppImages.imageAuth))),
                        SizedBox(height: 24.h),
                        Center(
                          child: Text(
                            "Get Knowledge",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        Center(
                          child: Text(
                            "     Get the knowledge by reading articles that are             "
                                "written on our platform",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 14.sp,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                      ],
                    ),
                  ],
                ),
              ),
              GlobalButton(
                title: ("Login account"),
                onTap: () {
                  // onChanged.call();
                  Navigator.pushNamed(context, RouteNames.loginScreen);
                },
                color: AppColors.black,
                borderColor: AppColors.black,
                textColor: Colors.white,
              ),
              SizedBox(height: 16.h),
              GlobalButton(
                title: ("Register account"),
                onTap: () {
                  // Navigator.pushNamed(context, RouteNames.signupScreen);
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
                },
                color: AppColors.white,
                borderColor: AppColors.black,
                textColor: Colors.black,
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
    );
  }
}
