import 'package:CurrentMovies/src/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/models/movie_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Movie>? movies;
  final Function siguientePagina;

  MovieHorizontal({required this.movies, required this.siguientePagina});

  final _pageController =
      new PageController(initialPage: 1, viewportFraction: 0.3);

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        siguientePagina();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: movies?.length,
        itemBuilder: (context, i) => _card(context, movies![i]),
      ),
    );
  }

  Widget _card(BuildContext context, Movie movie) {
    movie.uniqueId = '${movie.id}-poster';
    final card = Container(
      margin: EdgeInsets.only(right: 15.0),
      padding: EdgeInsets.only(top: 5.0),
      child: Column(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.cover,
                height: 130.0,
              ),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodySmall,
          )
        ],
      ),
    );
    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed(context, MovieDetailPage.route, arguments: movie);
      },
    );
  }
}
