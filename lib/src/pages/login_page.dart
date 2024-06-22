import 'package:CurrentMovies/src/widgets/background_box.dart';
import 'package:CurrentMovies/src/widgets/recover_password.dart';
import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/pages/bloc/login_page_bloc.dart';
import 'package:CurrentMovies/src/pages/movie_page.dart';
import 'package:CurrentMovies/src/pages/signup_page.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:CurrentMovies/src/widgets/alert_dialog.dart';
import 'package:CurrentMovies/src/widgets/input_custom.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static String route = "login";
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final LoginPageBloc bloc = Provider.of<LoginPageBloc>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(children: [
        backgroundLogin(),
        SizedBox(
          width: size.width,
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Text(
                  'Current Movies',
                  style: TextStyle(
                      fontSize: 35.0,
                      color: AppColors.$colorSecondary,
                      fontWeight: FontWeight.w900),
                ),
                SizedBox(
                  height: size.height * 0.4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: size.width * 0.95,
                        child: inputCustom(
                          filled: true,
                          rounded: true,
                          suffixIcon: const Icon(Icons.account_circle),
                          hintText: 'Usuario',
                          fontSize: 20.0,
                          onChanged: (value) {
                            bloc.updateUsername(value);
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      SizedBox(
                        width: size.width * 0.95,
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
                          onChanged: (value) {
                            bloc.updatePassword(value);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: size.height * 0.2,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        width: size.width * 0.95,
                        child: FilledButton(
                          onPressed: () {
                            login(context, bloc);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.$colorPrimaryBackground),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              "Ingresar".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.95,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 15.0, bottom: 15.0),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: TextButton(
                              child: const Text(
                                "Recuperar Contraseña",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: AppColors.$colorTertiary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              onPressed: () {
                                recoverPassword(context, bloc, size);
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: size.width * 0.95,
                        child: FilledButton(
                          onPressed: () {
                            Navigator.pushNamed(context, SignupPage.route);
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                AppColors.$colorTertiary),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "Registrarse".toUpperCase(),
                              style: const TextStyle(
                                  fontSize: 26, fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ]),
        ),
      ]),
    );
  }

  void login(BuildContext context, LoginPageBloc bloc) {
    if (bloc.username != '' && bloc.password != '') {
      bloc.login(bloc.username, bloc.password).then((user) {
        if (user == null) {
          alertDialog(
              context: context,
              message: "LOS DATOS INGRESADOS SON INCORRECTOS",
              image: "icon-close.png");
        } else {
          bloc.clearLoginFields();
          Navigator.pushNamedAndRemoveUntil(
              context, MoviePage.route, (route) => false);
        }
      });
    } else {
      alertDialog(
          context: context,
          message: "INGRESE USUARIO Y CONTRASEÑA",
          image: "icon-close.png");
    }
  }
}
