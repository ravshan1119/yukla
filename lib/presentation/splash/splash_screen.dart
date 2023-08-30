import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yukla/cubits/auth/auth_cubit.dart';
import 'package:yukla/cubits/profile/profile_cubit.dart';
import 'package:yukla/data/local/storage_repository.dart';
import 'package:yukla/presentation/app_routes.dart';
import 'package:yukla/presentation/auth/auth_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  _init() async {
    if (StorageRepository.getString("token").isEmpty) {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    } else {
      Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
    }
  }

  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).checkLoggedState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: BlocConsumer<AuthCubit, AuthState>(
        builder: (context, state) {
          return Center(
              child: Text(
            "Splash",
            style: TextStyle(
              color: Colors.white,
              fontSize: 24.sp,
            ),
          ));
        },
        listener: (context, state) {
          if (state is AuthUnAuthenticatedState) {
            // Navigator.pushReplacementNamed(context, RouteNames.loginScreen);
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => AuthScreen()));
          }
          if (state is AuthLoggedState) {
            BlocProvider.of<ProfileCubit>(context).getUserData();
            Navigator.pushReplacementNamed(context, RouteNames.tabBox);
          }
        },
      ),
    );
  }
}
