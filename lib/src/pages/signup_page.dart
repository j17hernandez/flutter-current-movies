import 'package:CurrentMovies/src/widgets/background_box.dart';
import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/pages/bloc/login_page_bloc.dart';
import 'package:CurrentMovies/src/pages/login_page.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:CurrentMovies/src/widgets/alert_dialog.dart';
import 'package:CurrentMovies/src/widgets/input_custom.dart';
import 'package:provider/provider.dart';

class SignupPage extends StatelessWidget {
  static String route = "signup";
  SignupPage({super.key});

  final TextEditingController nameController = TextEditingController();
  final TextEditingController identificationController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final LoginPageBloc bloc = Provider.of<LoginPageBloc>(context);

    return Scaffold(
      body: Stack(children: [
        backgroundSignup(size),
        Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: AppColors.$colorSecondary),
                    ),
                  ],
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'REGISTRAR NUEVO USUARIO',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 30.0,
                            color: AppColors.$colorSecondary,
                            fontWeight: FontWeight.w900),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: SizedBox(
                    width: size.width,
                    child: inputCustom(
                      fontSize: 20.0,
                      hintText: 'Nombre',
                      filled: true,
                      rounded: true,
                      controllerInput: nameController,
                      onChanged: (value) {
                        bloc.updateName(value);
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: inputCustom(
                    hintText: 'Correo electrónico',
                    keyboardType: TextInputType.emailAddress,
                    fontSize: 20.0,
                    filled: true,
                    rounded: true,
                    controllerInput: emailController,
                    onChanged: (value) {
                      bloc.updateEmail(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: inputCustom(
                    hintText: 'Identificación',
                    keyboardType: TextInputType.number,
                    fontSize: 20.0,
                    filled: true,
                    rounded: true,
                    controllerInput: identificationController,
                    onChanged: (value) {
                      bloc.updateIdentification(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: inputCustom(
                    filled: true,
                    rounded: true,
                    hintText: 'Usuario',
                    fontSize: 20.0,
                    controllerInput: userController,
                    onChanged: (value) {
                      bloc.updateUsername(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5.0),
                  child: inputCustom(
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: bloc.obscureText,
                    fontSize: 20.0,
                    filled: true,
                    rounded: true,
                    hintText: 'Contraseña',
                    suffixIcon: IconButton(
                      icon: bloc.obscureText
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () {
                        bloc.updateObscureText();
                      },
                    ),
                    controllerInput: passwordController,
                    onChanged: (value) {
                      bloc.updatePassword(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: SizedBox(
                    width: size.width * 0.95,
                    child: FilledButton(
                      onPressed: () {
                        if (bloc.name != '' &&
                            bloc.email != '' &&
                            bloc.identification != '' &&
                            bloc.username != '' &&
                            bloc.password != '') {
                          bloc.signup().then((user) {
                            if (user?.detail != null) {
                              alertDialog(
                                  context: context,
                                  message: user!.detail.toString(),
                                  image: "icon-close.png");
                            } else {
                              nameController.clear();
                              identificationController.clear();
                              emailController.clear();
                              userController.clear();
                              passwordController.clear();
                              alertDialog(
                                  context: context,
                                  message:
                                      "¡Excelente!, ${user?.firstName} ahora es un nuevo usuario",
                                  image: "icon-check.png");
                              Future.delayed(const Duration(seconds: 1))
                                  .then((value) {
                                Navigator.pushNamedAndRemoveUntil(
                                    context, LoginPage.route, (route) => false);
                              });
                            }
                            // ignore: invalid_return_type_for_catch_error
                          }).catchError((onError) => {
                                alertDialog(
                                    context: context,
                                    message: onError.toString(),
                                    image: "icon-close.png")
                              });
                        } else {
                          alertDialog(
                              context: context,
                              message: "INGRESE TODOS LOS CAMPOS",
                              image: "icon-close.png");
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            AppColors.$colorTertiary),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Registrar".toUpperCase(),
                          style: const TextStyle(
                              fontSize: 26, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ),
                ),
              ]),
        )
      ]),
    );
  }
}
