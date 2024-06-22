import 'package:CurrentMovies/src/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:CurrentMovies/src/models/movie_model.dart';
import 'package:CurrentMovies/src/providers/movies_providers.dart';
import 'package:CurrentMovies/src/utils/app_colors.dart';

class DataSearch extends SearchDelegate {
  String seleccion = '';
  final moviesProvider = new MoviesProvider();

  @override
  List<Widget> buildActions(BuildContext context) {
    // acciones de nuestro appbar
    return [
      IconButton(
          icon: Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // icono a la izquierda del Appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Crea los resultados que vamos a mostrar
    return Center(
        child: Container(
      height: 100.0,
      width: 100.0,
      color: AppColors.$colorPrimary,
      child: Text(seleccion),
    ));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparecen al escribir
    if (query.isEmpty) {
      return Container();
    }

    return FutureBuilder(
      future: moviesProvider.buscarMovie(query),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {
        if (snapshot.hasData) {
          final movies = snapshot.data;
          return ListView(
              children: movies!.map((movie) {
            return ListTile(
              leading: FadeInImage(
                image: NetworkImage(movie.getPosterImg()),
                placeholder: AssetImage('assets/img/no-image.jpg'),
                fit: BoxFit.contain,
                width: 40.0,
              ),
              title: Text(movie.title),
              subtitle: Text(movie.originalTitle),
              onTap: () {
                close(context, null);
                movie.uniqueId = '${movie.id}-buscar';
                Navigator.pushNamed(context, MovieDetailPage.route,
                    arguments: movie);
              },
            );
          }).toList());
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
