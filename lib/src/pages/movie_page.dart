import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:CurrentMovies/src/models/movie_model.dart';
import 'package:CurrentMovies/src/pages/bloc/login_page_bloc.dart';
import 'package:CurrentMovies/src/pages/login_page.dart';
import 'package:CurrentMovies/src/providers/movies_providers.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';
import 'package:CurrentMovies/src/widgets/card_swiper_widget.dart';
import 'package:CurrentMovies/src/widgets/movie_horizontal.dart';
import 'package:CurrentMovies/src/search/search_delegate.dart';
import 'package:provider/provider.dart';

class MoviePage extends StatelessWidget {
  static String route = "movie_page";
  final moviesProvider = new MoviesProvider();

  @override
  Widget build(BuildContext context) {
    moviesProvider.getPopulares();
    final LoginPageBloc bloc = Provider.of<LoginPageBloc>(context);
    HawkFabMenuController hawkFabMenuController = HawkFabMenuController();

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text('Current Movies'),
        backgroundColor: AppColors.$colorBackgroundApp,
        foregroundColor: AppColors.$colorSecondary,
        actions: [
          IconButton(
              icon: Icon(
                Icons.search,
                color: AppColors.colorMainIcons,
              ),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: DataSearch(),
                );
              })
        ],
      ),
      body: Container(
        child: Stack(children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [_swiperCards(), _footer(context)],
          ),
        ]),
      ),
      floatingActionButton: GestureDetector(
        onTap: () {
          hawkFabMenuController.toggleMenu();
        },
        child: HawkFabMenu(
          icon: AnimatedIcons.menu_arrow,
          fabColor: AppColors.$colorPrimary,
          iconColor: AppColors.$colorSecondary,
          hawkFabMenuController: hawkFabMenuController,
          items: [
            HawkFabMenuItem(
              label: 'Cerrar Sesión',
              color: AppColors.$colorPrimary,
              labelColor: AppColors.$colorPrimary,
              ontap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
                bloc.logout();
                Navigator.pushNamedAndRemoveUntil(
                    context, LoginPage.route, (route) => false);
              },
              icon: const Icon(Icons.arrow_forward_rounded,
                  color: AppColors.$colorOnTertiaryText, size: 30),
            ),
          ],
          body: const Center(
            child: SizedBox.shrink(),
          ),
        ),
      ),
    );
  }

  Widget _swiperCards() {
    return FutureBuilder(
      future: moviesProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          List<Movie>? movieList =
              snapshot.data?.map((item) => item as Movie).toList();
          return CardSwiper(movies: movieList);
        } else {
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              padding: EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Text('Populares',
                  style: Theme.of(context).textTheme.titleMedium)),
          StreamBuilder(
            stream: moviesProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                List<Movie>? movieList =
                    snapshot.data?.map((item) => item as Movie).toList();
                return MovieHorizontal(
                  movies: movieList,
                  siguientePagina: moviesProvider.getPopulares,
                );
              } else {
                return Container(
                    child: Center(child: CircularProgressIndicator()));
              }
            },
          ),
        ],
      ),
    );
  }
}
