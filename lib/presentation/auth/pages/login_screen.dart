
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/auth/widgets/global_button.dart';
import 'package:yukla/presentation/auth/widgets/global_text_fields.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String gmail = "";
  String password = "";

  @override
  Widget build(BuildContext context) {
    return

      Scaffold(
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }
          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Login Account",
                        style: TextStyle(
                            fontSize: 26.sp,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                            fontFamily: "PlusJakartaSans"),
                      ),
                      GestureDetector(
                          onTap: (){
                            Navigator.pop(context);
                          },
                          child: SvgPicture.asset(AppImages.cancel))
                    ],
                  ),
                  SizedBox(height: 27.h),
                  Text(
                    "You can create the account with input your name, email address, and password",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppColors.c_4D4D4D,
                        fontFamily: "PlusJakartaSans"),
                  ),
                  SizedBox(height: 30.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email Address",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.c_999999,
                            fontFamily: "PlusJakartaSans"),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: GlobalTextField(
                      onChanged: (v){
                        gmail = v;
                        print("AAAAAAAAAAAAAAAAAAAAAAAAA$gmail");
                      },
                      hintText: "Email",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.c_999999,
                            fontFamily: "PlusJakartaSans"),
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: GlobalTextField(
                      onChanged: (v){
                        password = v;
                        print("AAAAAAAAAAAAAAAAAAAAAAAAA$password");

                      },
                      hintText: "Password",
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Forgot Password",
                          style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w500,
                              color: AppColors.c_999999,
                              fontFamily: "PlusJakartaSans"),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  GlobalButton(title: "Log In", onTap: (){
                    print(gmail);
                    print(password);
                    if (gmail.isNotEmpty && password.isNotEmpty) {
                      print(gmail);
                      print(password);
                      context.read<AuthCubit>().loginUser(
                        gmail: gmail,
                        password: password,
                      );
                    }else{
                      showErrorMessage(message: "Malumotlar mavjud emas!", context: context);
                    }
                  }, color: Colors.black, borderColor: Colors.black, textColor: Colors.white),
                  SizedBox(height: 27.h),
                  Center(
                    child: Text(
                      "or With",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c_999999,
                          fontFamily: "PlusJakartaSans"),
                    ),
                  ),
                  Divider(color: AppColors.c_999999,),
                  SizedBox(height: 28.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 50.h,
                            width: 150.w,
                            child: GlobalButton(title: "title", onTap: (){
                              showErrorMessage(message: "Hali mavjus emas!", context: context);
                            }, color: Colors.white, borderColor: AppColors.c_4D4D4D, textColor: Colors.white,isSvg: AppImages.google,)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                            height: 50.h,
                            width: 150.w,
                            child: GlobalButton(title: "title", onTap: (){
                              showErrorMessage(message: "Hali mavjus emas!", context: context);

                            }, color: Colors.white, borderColor: AppColors.c_4D4D4D, textColor: Colors.white,isSvg: AppImages.facebook,)),
                      ),

                    ],
                  ),




                ],
              ),
            ),
          );
        },
        // buildWhen: (previous,current){
        //   return previous!=current;//false
        // },
        buildWhen: (previous,current){
          print("PREVIOUS:$previous AND CURRENT:$current");
          return true;
        },
        listener: (context, state) {
          if (state is AuthLoggedState) {
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}
