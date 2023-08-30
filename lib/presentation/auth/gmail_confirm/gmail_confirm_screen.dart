import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/cubits/profile/profile_cubit.dart';
import 'package:yukla/cubits/user_data/user_data_cubit.dart';
import 'package:yukla/data/models/user/user_model.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/auth/gmail_confirm/widgets/pinput_example.dart';
import 'package:yukla/presentation/auth/widgets/global_button.dart';
import 'package:yukla/presentation/auth/widgets/global_text_fields.dart';
import 'package:yukla/utils/colors/app_colors.dart';
import 'package:yukla/utils/ui_utils/error_message_dialog.dart';

class GmailConfirmScreen extends StatefulWidget {
  GmailConfirmScreen({super.key, required this.userModel});

  UserModel userModel;

  @override
  State<GmailConfirmScreen> createState() => _GmailConfirmScreenState();
}

class _GmailConfirmScreenState extends State<GmailConfirmScreen> {
  String code = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text("Gmail Confirm Screen"),
      ),
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const FractionallySizedBox(
              //   widthFactor: 1,
              //   child: PinputExample(),
              // ),
              GlobalTextField(
                hintText: "Code",
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.next,
                textAlign: TextAlign.start,
                onChanged: (v) {
                  code = v;
                },
              ),
              GlobalButton(
                color: Colors.black,
                textColor: Colors.white,
                borderColor: Colors.black,
                title: "Confirm",
                onTap: () {
                  context.read<AuthCubit>().confirmGmail(code);
                },
              ),
              const SizedBox(height: 50),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "I don’t recevie a code! ",
                    style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.c_4D4D4D,
                        fontFamily: "PlusJakartaSans"),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, RouteNames.loginScreen);
                    },
                    child: Text(
                      "Please resend",
                      style: TextStyle(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: AppColors.black,
                          fontFamily: "PlusJakartaSans"),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        listener: (context, state) {
          if (state is AuthConfirmCodeSuccessState) {
            context.read<AuthCubit>().registerUser(widget.userModel);
          }

          if (state is AuthLoggedState) {
            context.read<UserDataCubit>().clearData();
            BlocProvider.of<ProfileCubit>(context).getUserData();
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.tabBox, (c) => false);
          }

          if (state is AuthErrorState) {
            showErrorMessage(message: state.errorText, context: context);
          }
        },
      ),
    );
  }
}
