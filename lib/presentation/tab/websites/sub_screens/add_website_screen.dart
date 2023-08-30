import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yukla/cubits/user_data/user_data_cubit.dart';
import 'package:yukla/cubits/website/website_cubit.dart';
import 'package:yukla/data/models/status/form_status.dart';
import 'package:yukla/data/models/user/user_field_keys.dart';
import 'package:yukla/data/models/websites/website_field_keys.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/auth/widgets/gender_selector.dart';
import 'package:yukla/presentation/auth/widgets/global_button.dart';
import 'package:yukla/presentation/auth/widgets/global_text_fields.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/constants/constants.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class AddWebsiteScreen extends StatefulWidget {
  const AddWebsiteScreen({super.key});

  @override
  State<AddWebsiteScreen> createState() => _AddWebsiteScreenState();
}

class _AddWebsiteScreenState extends State<AddWebsiteScreen> {

  ImagePicker picker = ImagePicker();

  // late WebsiteCubit bloc ;

  @override
  void initState() {
   // bloc = BlocProvider.of<WebsiteCubit>(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<WebsiteCubit,WebsiteState>(builder: (context,state){
        return ListView(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Add Website",
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
                          "Website Link",
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
                          context.read<WebsiteCubit>().updateWebsiteField(
                            fieldKey: WebsiteFieldKeys.link,
                            value: v,
                          );
                        },
                        hintText: "Link",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Web Site Name",
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
                          context.read<WebsiteCubit>().updateWebsiteField(
                            fieldKey: WebsiteFieldKeys.name,
                            value: v,
                          );
                        },
                        hintText: "WebSite Name",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Author",
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
                          context.read<WebsiteCubit>().updateWebsiteField(
                            fieldKey: WebsiteFieldKeys.author,
                            value: v,
                          );
                        },
                        hintText: "Author",
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
                          context.read<WebsiteCubit>().updateWebsiteField(
                            fieldKey: WebsiteFieldKeys.contact,
                            value: v,
                          );
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
                          "Hashtag",
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
                          context.read<WebsiteCubit>().updateWebsiteField(
                            fieldKey: WebsiteFieldKeys.hashtag,
                            value: v,
                          );
                        },
                        hintText: "Hashtag",
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        textAlign: TextAlign.start,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    TextButton(
                        onPressed: () {
                          showBottomSheetDialog();
                        },
                        child: const Text("Select image")),
                    SizedBox(height: 20.h),
                    GlobalButton(
                        title: "Add WebSite",
                        onTap: () {
                          // if (context.read<UserDataCubit>().canRegister()) {
                          //   context.read<AuthCubit>().sendCodeToGmail(
                          //     context
                          //         .read<UserDataCubit>()
                          //         .state
                          //         .userModel
                          //         .email,
                          //     context
                          //         .read<UserDataCubit>()
                          //         .state
                          //         .userModel
                          //         .password,
                          //   );
                          // } else {
                          //   showErrorMessage(
                          //       message: "Maydonlar to'liq emas", context: context);
                          // }
                          if (context.read<WebsiteCubit>().state.canAddWebsite()) {
                            //showErrorMessage(message: "Yaroqli!!!", context: context);
                            context.read<WebsiteCubit>().createWebsite();
                            Navigator.pop(context);
                          } else {
                            showErrorMessage(
                                message: "Ma'lumotlar to'liq emas!!!", context: context);
                          }
                        },
                        color: Colors.black,
                        borderColor: Colors.black,
                        textColor: Colors.white),
                    SizedBox(height: 11.h),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Text(
                    //       "You don't have an account?",
                    //       style: TextStyle(
                    //           fontSize: 10.sp,
                    //           fontWeight: FontWeight.w500,
                    //           color: AppColors.c_4D4D4D,
                    //           fontFamily: "PlusJakartaSans"),
                    //     ),
                    //     const SizedBox(width: 4),
                    //     GestureDetector(
                    //       onTap: () {
                    //         Navigator.pushNamed(context, RouteNames.loginScreen);
                    //       },
                    //       child: Text(
                    //         "Log in",
                    //         style: TextStyle(
                    //             fontSize: 10.sp,
                    //             fontWeight: FontWeight.w500,
                    //             color: AppColors.black,
                    //             fontFamily: "PlusJakartaSans"),
                    //       ),
                    //     ),
                    //   ],
                    // )
                  ],
                ),
              ),
            ),

            // IconButton(
            // onPressed: () {
            //   showBottomSheetDialog();
            // },
            // icon:const  Icon(Icons.image),
            // ),
            // IconButton(
            //   onPressed: () {
            //     bloc.updateWebsiteField(
            //       fieldKey: WebsiteFieldKeys.link,
            //       value: "https://daryo.uz",
            //     );
            //     bloc.updateWebsiteField(
            //       fieldKey: WebsiteFieldKeys.name,
            //       value: "Daryo website",
            //     );
            //     bloc.updateWebsiteField(
            //       fieldKey: WebsiteFieldKeys.author,
            //       value: "Daryochilar",
            //     );
            //     bloc.updateWebsiteField(
            //       fieldKey: WebsiteFieldKeys.contact,
            //       value: "999090900",
            //     );
            //     bloc.updateWebsiteField(
            //       fieldKey: WebsiteFieldKeys.hashtag,
            //       value: "daryo, yangilik",
            //     );
            //
            //
            //
            //     if (bloc.state.canAddWebsite()) {
            //       //showErrorMessage(message: "Yaroqli!!!", context: context);
            //       bloc.createWebsite();
            //     } else {
            //       showErrorMessage(
            //           message: "Ma'lumotlar to'liq emas!!!", context: context);
            //     }
            //   },
            //   icon: const Icon(Icons.add),
            // )
          ],
        );
      }, listener: (context,state){
        if (state.status == FormStatus.failure) {
          showErrorMessage(
            message: state.statusText,
            context: context,
          );
        }

        if (state.status == FormStatus.success &&
            state.statusText == StatusTextConstants.websiteAdd) {
          BlocProvider.of<WebsiteCubit>(context).getWebsites(context);
          Navigator.pop(context);
        }
      })
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
      context.read<WebsiteCubit>().updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
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
      context.read<WebsiteCubit>().updateWebsiteField(
        fieldKey: WebsiteFieldKeys.image,
        value: xFile.path,
      );
    }
  }
}
