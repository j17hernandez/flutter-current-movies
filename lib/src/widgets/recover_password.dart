import 'dart:async';
import 'package:CurrentMovies/src/models/user_model.domain.dart';
import 'package:CurrentMovies/src/pages/bloc/login_page_bloc.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:CurrentMovies/src/utils/common_functions.dart';
import 'package:CurrentMovies/src/widgets/alert_dialog.dart';
import 'package:CurrentMovies/src/widgets/input_custom.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

enum Steps { firstStep, secondStep }

void recoverPassword(BuildContext context, LoginPageBloc bloc, Size size) {
  final streamController = StreamController<Steps>();
  TextEditingController identificationInput = TextEditingController();
  TextEditingController passwordInput = TextEditingController();
  streamController.sink.add(Steps.firstStep);

  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          backgroundColor: AppColors.$colorSecondary,
          surfaceTintColor: AppColors.$colorSecondary,
          contentPadding: const EdgeInsets.all(15),
          actionsPadding: const EdgeInsets.all(15),
          content: StreamBuilder<Steps>(
              stream: streamController.stream,
              builder: (context, snapshot) {
                Steps? currentStep = snapshot.data;
                return SizedBox(
                  width: size.width,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Recuperar contraseña",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          IconButton(
                              onPressed: () => close(context, streamController),
                              icon: const Icon(
                                Icons.close_rounded,
                                size: 40,
                              ))
                        ],
                      ),
                      Visibility(
                        visible: currentStep == Steps.firstStep,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 5.0),
                          child: inputCustom(
                              hintText: 'N° de Identificación',
                              fontSize: 20.0,
                              maxLength: 10,
                              filled: true,
                              rounded: true,
                              controllerInput: identificationInput),
                        ),
                      ),
                      Visibility(
                        visible: currentStep == Steps.secondStep,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: inputCustom(
                              hintText: 'Su contraseña es:',
                              fontSize: 20.0,
                              filled: true,
                              rounded: true,
                              enabled: false,
                              controllerInput: passwordInput),
                        ),
                      ),
                      SizedBox(
                          width: size.width * 0.95,
                          child: FilledButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          AppColors.$colorTertiary)),
                              onPressed: () {
                                validate(
                                    context: context,
                                    bloc: bloc,
                                    currentStep: currentStep,
                                    streamController: streamController,
                                    identificationInput: identificationInput,
                                    passwordInput: passwordInput);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                    currentStep != Steps.secondStep
                                        ? "Validar"
                                        : "Copiar",
                                    style: const TextStyle(
                                        fontSize: 26,
                                        fontWeight: FontWeight.w600)),
                              )))
                    ],
                  ),
                );
              }),
        );
      });
}

void validate(
    {required BuildContext context,
    required LoginPageBloc bloc,
    Steps? currentStep,
    required StreamController<Steps> streamController,
    required TextEditingController identificationInput,
    required TextEditingController passwordInput}) async {
  switch (currentStep) {
    case Steps.firstStep:
      if (identificationInput.text.isNotEmpty) {
        UserModel? userData =
            await bloc.getUserByIdentification(identificationInput.text);
        if (userData != null) {
          passwordInput.text = userData.password;
          bloc.updateDataUser(userData);
          streamController.sink.add(Steps.secondStep);
        } else {
          // ignore: use_build_context_synchronously
          alertDialog(
              context: context,
              message: "Usuario no encontrado.",
              image: "icon-close.png");
        }
      } else {
        alertDialog(
            context: context,
            message: "Ingrese N° de identificación.",
            image: "icon-close.png");
      }
      break;

    case Steps.secondStep:
      // ignore: use_build_context_synchronously
      CommonFunctions.copyToClipboard(context, passwordInput.text);
      bloc.updateDataUser(null);
      identificationInput.clear();
      passwordInput.clear();
      // ignore: use_build_context_synchronously
      close(context, streamController);
      break;

    default:
      streamController.sink.add(Steps.firstStep);
      break;
  }
}

void close(BuildContext context, StreamController<Steps> streamController) {
  streamController.close();
  Navigator.of(context).pop();
}
