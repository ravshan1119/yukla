import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/cubits/user_data/user_data_cubit.dart';
import 'package:yukla/data/models/user/user_field_keys.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/auth/widgets/gender_selector.dart';
import 'package:yukla/presentation/auth/widgets/global_button.dart';
import 'package:yukla/presentation/auth/widgets/global_text_fields.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  ImagePicker picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text("SignUp"),
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: BlocConsumer<AuthCubit, AuthState>(builder: (context, state) {
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
                      "Register Account",
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                          fontFamily: "PlusJakartaSans"),
                    ),
                    GestureDetector(
                        onTap: () {
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
                      "Username",
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
                    onChanged: (v) {
                      context.read<UserDataCubit>().updateCurrentUserField(
                          fieldKey: UserFieldKeys.username, value: v);
                    },
                    hintText: "Username",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Contact",
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
                    onChanged: (v) {
                      context.read<UserDataCubit>().updateCurrentUserField(
                          fieldKey: UserFieldKeys.contact, value: v);
                    },
                    hintText: "Contact",
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
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
                    onChanged: (v) {
                      context.read<UserDataCubit>().updateCurrentUserField(
                          fieldKey: UserFieldKeys.email, value: v);
                    },
                    hintText: "Email",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                  ),
                ),
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
                    onChanged: (v) {
                      context.read<UserDataCubit>().updateCurrentUserField(
                          fieldKey: UserFieldKeys.password, value: v);
                    },
                    hintText: "Password",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Profession",
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
                    onChanged: (v) {
                      context.read<UserDataCubit>().updateCurrentUserField(
                          fieldKey: UserFieldKeys.profession, value: v);
                    },
                    hintText: "Profession",
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    textAlign: TextAlign.start,
                  ),
                ),
                SizedBox(height: 30.h),
                // const SizedBox(height: 20),
                const GenderSelector(),
                TextButton(
                    onPressed: () {
                      showBottomSheetDialog();
                    },
                    child: const Text("Select image")),
                SizedBox(height: 20.h),
                GlobalButton(
                    title: "Register",
                    onTap: () {
                      if (context.read<UserDataCubit>().canRegister()) {
                        context.read<AuthCubit>().sendCodeToGmail(
                          context
                              .read<UserDataCubit>()
                              .state
                              .userModel
                              .email,
                          context
                              .read<UserDataCubit>()
                              .state
                              .userModel
                              .password,
                        );
                      } else {
                        showErrorMessage(
                            message: "Maydonlar to'liq emas", context: context);
                      }
                    },
                    color: Colors.black,
                    borderColor: Colors.black,
                    textColor: Colors.white),
                SizedBox(height: 11.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "You don't have an account?",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.c_4D4D4D,
                          fontFamily: "PlusJakartaSans"),
                    ),
                    const SizedBox(width: 4),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, RouteNames.loginScreen);
                      },
                      child: Text(
                        "Log in",
                        style: TextStyle(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.black,
                            fontFamily: "PlusJakartaSans"),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      }, listener: (context, state) {
        if (state is AuthSendCodeSuccessState) {
          Navigator.pushNamed(
            context,
            RouteNames.confirmGmail,
            arguments: context.read<UserDataCubit>().state.userModel,
          );
        }

        if (state is AuthErrorState) {
          showErrorMessage(message: state.errorText, context: context);
        }
      }),
    );
  }



  void showBottomSheetDialog() {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(24),
          height: 200,
          decoration: BoxDecoration(
            color: AppColors.c_162023,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Column(
            children: [
              ListTile(
                onTap: () {
                  _getFromCamera();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Select from Camera"),
              ),
              ListTile(
                onTap: () {
                  _getFromGallery();
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.photo),
                title: const Text("Select from Gallery"),
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> _getFromCamera() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.camera,
      maxHeight: 512,
      maxWidth: 512,
    );

    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
            fieldKey: UserFieldKeys.avatar,
            value: xFile.path,
          );
    }
  }

  Future<void> _getFromGallery() async {
    XFile? xFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxHeight: 512,
      maxWidth: 512,
    );
    if (xFile != null && context.mounted) {
      context.read<UserDataCubit>().updateCurrentUserField(
            fieldKey: UserFieldKeys.avatar,
            value: xFile.path,
          );
    }
  }
}
