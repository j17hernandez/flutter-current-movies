import 'package:CurrentMovies/src/widgets/background_box.dart';
import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/pages/bloc/login_page_bloc.dart';
import 'package:CurrentMovies/src/pages/movie_page.dart';
import 'package:CurrentMovies/src/pages/login_page.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SplashCustomPage extends StatefulWidget {
  static String route = "splash";

  const SplashCustomPage({super.key});

  @override
  State<SplashCustomPage> createState() => _SplashCustomPageState();
}

class _SplashCustomPageState extends State<SplashCustomPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    initialization(context);
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0, end: -80).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticInOut,
      ),
    );
  }

  void initialization(BuildContext context) async {
    final LoginPageBloc bloc =
        Provider.of<LoginPageBloc>(context, listen: false)..init();
    await Future.delayed(const Duration(seconds: 3));
    if (bloc.dataUser != null) {
      if (bloc.dataUser?.lastLogin != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, MoviePage.route, (route) => false);
      }
    } else {
      Navigator.pushNamedAndRemoveUntil(
          context, LoginPage.route, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.$colorSecondary,
                AppColors.$colorBackgroundApp.withOpacity(0.4),
              ],
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(0.5, _animation.value),
              child: child,
            );
          },
          child: backgroundSignup(size),
        ),
        SizedBox(
          width: size.width,
          height: size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Current Movies',
                style: TextStyle(
                    fontSize: 40,
                    color: AppColors.$colorOnPrimaryText,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
