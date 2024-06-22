import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:CurrentMovies/src/models/movie_model.dart';
import 'package:CurrentMovies/src/models/movies_videos.dart';
import 'package:CurrentMovies/src/models/actores_model.dart';

class MoviesProvider {
  String _apikey = '28b0d11478697294a63f71ce2c4b5381';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage = 0;
  bool _cargando = false;

  List<Movie> _populares = [];

  final _popularesStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Movie>> get popularesStream => _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Movie>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new Movies.fromJsonList(decodedData['results']);

    return movies.items;
  }

  Future<List<Movie>> getEnCines() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }

  Future<List<Movie>> getPopulares() async {
    if (_cargando) return [];
    _cargando = true;

    _popularesPage++;

    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString()
    });

    final resp = await _procesarRespuesta(url);
    _populares.addAll(resp);
    popularesSink(_populares);

    _cargando = false;
    return resp;
  }

  Future<List<MovieVideo>> getVideos(String movieId) async {
    final url = Uri.https(_url, '3/movie/$movieId/videos',
        {'api_key': _apikey, 'language': 'es-MX'});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final movies = new MoviesVideo.fromJsonList(decodedData['results']);
    return movies.items;
  }

  Future<List<Actor>> getCast(String peliId) async {
    final url = Uri.https(_url, '3/movie/$peliId/credits',
        {'api_key': _apikey, 'language': _language});
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final cast = new Cast.fromJsonList(decodedData['cast']);

    return cast.actores;
  }

  Future<List<Movie>> buscarMovie(String query) async {
    final url = Uri.https(_url, '3/search/movie',
        {'api_key': _apikey, 'language': _language, 'query': query});

    return await _procesarRespuesta(url);
  }
}
