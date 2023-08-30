import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:yukla/utils/images/app_images.dart';
import 'package:yukla/utils/ui_utils/custom_circular.dart';


void showLoading({required BuildContext context}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return Dialog(
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          alignment: AlignmentDirectional.center,
          decoration: const BoxDecoration(),
          child:  Center(
            child: SizedBox(
              height: 250.0,
              width: 250.0,
              child: Lottie.asset(AppImages.loading),
            ),
          ),
        ),
      );
    },
  );
}

void hideLoading({required BuildContext? context}) async {
  if (context != null) Navigator.pop(context);
}
