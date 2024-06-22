import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/pages/movie_page.dart';
import 'package:CurrentMovies/src/pages/login_page.dart';
import 'package:CurrentMovies/src/pages/movie_detail_page.dart';
import 'package:CurrentMovies/src/pages/signup_page.dart';
import 'package:CurrentMovies/src/pages/splash_custom_page.dart';

Map<String, WidgetBuilder> getAplicationRoutes() {
  return <String, WidgetBuilder>{
    LoginPage.route: (BuildContext context) => const LoginPage(),
    MoviePage.route: (BuildContext context) => MoviePage(),
    SignupPage.route: (BuildContext context) => SignupPage(),
    MovieDetailPage.route: (BuildContext context) => MovieDetailPage(),
    SplashCustomPage.route: (BuildContext context) => SplashCustomPage(),
  };
}
