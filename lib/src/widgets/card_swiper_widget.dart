import 'package:CurrentMovies/src/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:CurrentMovies/src/models/movie_model.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie>? movies;

  CardSwiper({required this.movies});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 10.0),
      child: Swiper(
        layout: SwiperLayout.STACK,
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) =>
            _card(context, movies![index]),
        itemCount: movies!.length,
        // pagination: new SwiperPagination(),
        // control: new SwiperControl(),
      ),
    );
  }

  Widget _card(context, Movie movie) {
    movie.uniqueId = '${movie.id}-card';
    final card = Hero(
      tag: movie.uniqueId,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: FadeInImage(
            image: NetworkImage(movie.getPosterImg()),
            placeholder: AssetImage('assets/img/no-image.jpg'),
            fit: BoxFit.cover,
          )),
    );
    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, MovieDetailPage.route, arguments: movie);
      },
    );
  }
}
