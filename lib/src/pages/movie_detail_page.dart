import 'package:CurrentMovies/src/widgets/viewYoutubeVideo.dart';
import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/models/actores_model.dart';
import 'package:CurrentMovies/src/models/movie_model.dart';
import 'package:CurrentMovies/src/models/movies_videos.dart';
import 'package:CurrentMovies/src/providers/movies_providers.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';

class MovieDetailPage extends StatelessWidget {
  final moviesProvider = new MoviesProvider();
  static String route = "detail";

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
        body: CustomScrollView(
          slivers: [
            _createAppBar(movie),
            SliverList(
                delegate: SliverChildListDelegate([
              SizedBox(height: 10.0),
              _posterTitle(context, movie),
              _createTextTitle("Descripción"),
              _description(movie),
              _createTextTitle("Actores"),
              _crearCasting(movie),
            ]))
          ],
        ),
        floatingActionButton: _buttonFloating(movie.id.toString()));
  }

  Widget _createTextTitle(String title) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Text('$title',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            )));
  }

  Widget _createAppBar(Movie movie) {
    return SliverAppBar(
      elevation: 2.0,
      foregroundColor: Colors.white,
      backgroundColor: AppColors.$colorPrimary,
      expandedHeight: 260.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.maxFinite,
              height: movie.title.length > 15 ? movie.title.length * 0.9 : 20.0,
              child: Container(
                decoration: BoxDecoration(color: Colors.black26),
              ),
            ),
            Text(
              movie.title,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            ),
          ],
        ),
        background: FadeInImage(
          image: NetworkImage(movie.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _posterTitle(BuildContext context, Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Row(
        children: [
          Hero(
            tag: movie.uniqueId,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: Image(
                  image: NetworkImage(movie.getPosterImg()),
                  height: 150.0,
                )),
          ),
          SizedBox(width: 20.0),
          Flexible(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(movie.title,
                  style: Theme.of(context).textTheme.bodyLarge,
                  overflow: TextOverflow.ellipsis),
              Text(movie.originalTitle,
                  style: Theme.of(context).textTheme.titleMedium,
                  overflow: TextOverflow.ellipsis),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.orange,
                  ),
                  Text(movie.voteAverage.toString(),
                      style: Theme.of(context).textTheme.titleMedium)
                ],
              )
            ],
          ))
        ],
      ),
    );
  }

  Widget _description(Movie movie) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child: Text(
        movie.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _crearCasting(Movie movie) {
    final peliProvider = MoviesProvider();
    return FutureBuilder(
      future: peliProvider.getCast(movie.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) {
          List<Actor> actorsList =
              snapshot.data!.map((item) => item as Actor).toList();
          return _createActorsPageView(actorsList);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _buttonFloating(String movie) {
    final peliProvider = MoviesProvider();
    return FutureBuilder(
      future: peliProvider.getVideos(movie),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data.length != 0) {
          return _floatingButton(context, snapshot.data[0]);
        } else {
          return Visibility(visible: false, child: Text(''));
        }
      },
    );
  }

  Widget _floatingButton(BuildContext context, MovieVideo peli) {
    return FloatingActionButton(
      child: Icon(
        Icons.movie,
        color: Colors.white,
      ),
      backgroundColor: AppColors.$colorPrimary,
      onPressed: () {
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context) {
              return AlertDialog(
                backgroundColor: AppColors.$colorSecondary,
                surfaceTintColor: AppColors.$colorSecondary,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0)),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ViewYoutubeVideo(
                      movie: peli,
                    )
                  ],
                ),
              );
            });
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actores) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(viewportFraction: 0.3, initialPage: 1),
        itemCount: actores.length,
        itemBuilder: (context, i) => _actorCard(actores[i]),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getFoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}
