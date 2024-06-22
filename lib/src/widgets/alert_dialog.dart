import 'dart:async';

import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';

void alertDialog(
    {required BuildContext context,
    required String message,
    Icon? icon,
    String? image,
    Widget? title,
    bool barrierDismissible = true,
    List<Widget>? actions,
    Function? onClose}) {
  showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.$colorSecondary,
          surfaceTintColor: AppColors.$colorSecondary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          icon: icon,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              image != null
                  ? Image.asset('assets/img/icons/$image')
                  : const Text(''),
              title ?? const Text(''),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 24.0,
                    color: AppColors.$colorTitleLogin,
                    fontWeight: FontWeight.w300),
              ),
            ],
          ),
          actions: actions,
        );
      }).then((value) => {if (onClose != null) onClose()});
}

Future<bool> alertConfirm({
  required BuildContext context,
  required String message,
  Icon? icon,
  String? image,
  Widget? title,
}) {
  Completer<bool> completer = Completer<bool>();
  bool resultComplete = false;
  alertDialog(
      context: context,
      message: message,
      icon: icon,
      image: image,
      title: title,
      barrierDismissible: false,
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FilledButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.$colorPrimary),
              ),
              onPressed: () {
                resultComplete = true;
                completer.complete(resultComplete);
                Navigator.of(context).pop();
              },
              child: const Text(
                'SI',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
            const SizedBox(width: 16.0),
            FilledButton(
              style: ButtonStyle(
                backgroundColor:
                    MaterialStateProperty.all(AppColors.$colorPrimary),
              ),
              onPressed: () {
                resultComplete = false;
                completer.complete(resultComplete);
                Navigator.of(context).pop();
              },
              child: const Text(
                'NO',
                style: TextStyle(fontSize: 22.0),
              ),
            ),
          ],
        ),
      ],
      onClose: () {
        completer.complete(resultComplete);
      });
  return completer.future;
}
