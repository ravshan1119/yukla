import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/cubits/profile/profile_cubit.dart';
import 'package:yukla/presentation/auth/widgets/global_button.dart';
import 'package:yukla/presentation/tab/profile/widgets/profile_info_container.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/constants/constants.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/custom_circular.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
 bool isSwitched = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile",style: TextStyle(
          color: Colors.black
        ),),
        actions: [
          Center(
            child: Switch(
              value: isSwitched,
              onChanged: (value){
                setState(() {
                  FirebaseMessaging.instance;


                  isSwitched = value;
                  print(isSwitched);
                });
              },
              activeTrackColor: Colors.lightGreenAccent,
              activeColor: Colors.green,
            ),
          )
        ],
      ),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is ProfileLoadingState) {
            return SizedBox(
              height: 100.0,
              width: 100.0,
              child: Lottie.asset(AppImages.loading),
            );
          }
          if (state is ProfileSuccessState) {
            return Column(
              children: [
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        baseUrlImage + state.userModel.avatar,
                        width: 200,
                      ),
                      SizedBox(width: 10.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            state.userModel.username,
                            style: TextStyle(color: Colors.black,fontSize: 32.sp,fontWeight: FontWeight.w600),
                          ),
                          Text(
                            state.userModel.contact,
                            style: TextStyle(color: Colors.black,fontSize: 32.sp,fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ProfileContainer(text: state.userModel.email),
                ProfileContainer(text: state.userModel.contact),
                ProfileContainer(text: state.userModel.profession),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: GlobalButton(title: "Log Out", onTap: (){
                    showDialog<void>(
                      context: context,
                      barrierDismissible: false, // user must tap button!
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Warning',style: TextStyle(color: Colors.black),),
                          content: const SingleChildScrollView(
                            child: ListBody(
                              children: <Widget>[
                                Text('Profildan chiqasizmi?',style: TextStyle(color: Colors.black),),
                              ],
                            ),
                          ),
                          actions: <Widget>[
                            TextButton(
                              child: const Text('yes'),
                              onPressed: () {

                                Navigator.of(context).pop();
                                BlocProvider.of<AuthCubit>(context).logOut();
                              },
                            ),
                            TextButton(
                              child: const Text('no'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }, color: AppColors.c_C93545, borderColor: AppColors.c_C93545, textColor: AppColors.white),
                )
              ],
            );
          }

          return const Text("ERROR");
        },
        listener: (context, state) {
          if (state is ProfileErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}