import 'dart:math';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:flutter/material.dart';

Widget boxCard() {
  final box = Transform.rotate(
    angle: -pi / 4.5,
    child: Container(
      height: 360.0,
      width: 360.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80.0),
          gradient: LinearGradient(colors: [
            AppColors.$colorPrimary,
            AppColors.$colorPrimary.withOpacity(0.3),
          ])),
    ),
  );

  return box;
}

Widget backgroundLogin() {
  return Stack(
    children: [
      Positioned(top: -120.0, left: 30.0, child: boxCard()),
      Positioned(top: -100.0, left: -100.0, child: boxCard()),
    ],
  );
}

Widget backgroundSignup(Size size) {
  return Stack(
    children: [
      Positioned(top: size.width * -0.25, left: 80.0, child: boxCard()),
      Positioned(
          top: size.width * -0.3, left: size.width * -0.2, child: boxCard()),
      Positioned(
          bottom: size.height * 0.2,
          right: size.width * -0.2,
          child: boxCard()),
      Positioned(
          bottom: size.height * 0.3,
          right: size.width * -0.2,
          child: boxCard()),
    ],
  );
}
