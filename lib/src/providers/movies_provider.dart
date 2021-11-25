

import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/helpers/debouncer.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/models/movies_recommend_response.dart';
import 'package:movies_app/src/models/search_response.dart';

class MoviesProvider extends ChangeNotifier{ //Es como un Observable. Si la data cambia le notifica a todos los widgets que esten
//escuchando o quieran conocer de estos cambios.

  String baseUrl = 'api.themoviedb.org';
  String apiKey = '117ef0a1fa3a0f69a5d7fe63b6de49cf';
  String lenguage = 'es-ES';

  int _numberPage = 0;

  List<Movie> listMoviesPlaying = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> moviesCast = {};
  Map<int, List<Movie>> moviesRecommend = {};


  //Cuanto tiempo tengo que esperar para emitir un valor.
  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500));

  //Veamolo como un future
  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => _suggestionStreamController.stream;

  MoviesProvider(){
    print('MoviesProvider constructor..');
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<String> _getJsonData(String endpoint, [int page=1]) async {

    var url = Uri.https(baseUrl, endpoint, {
        'api_key': apiKey,
        'language': lenguage,
        'page': '$page'
      }
    );

    var response = await http.get(url);

    return response.body;
  }

  getNowPlayingMovies() async{

    //var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    //print(jsonResponse['results'][0]['title']); MAS DIFICIL DE TRABAJAR

    final responseData = await _getJsonData('3/movie/now_playing');
    final nowPlayingReponse = NowPlayingResponse.fromJson(responseData);

    listMoviesPlaying = nowPlayingReponse.results;
    notifyListeners();
  }


  getPopularMovies() async {

    _numberPage++;

    final responseData = await _getJsonData('3/movie/popular', _numberPage);

    final popularMoviesResponse = PopularMoviesResponse.fromJson(responseData);
    popularMovies = [ ...popularMovies , ...popularMoviesResponse.results];
    notifyListeners();
  }


  Future<List<Movie>> getMoviesRecommend(int movieId) async{

    final responseData = await _getJsonData('3/movie/$movieId/recommendations');
    final moviesRecommendResponse = MoviesRecommendResponse.fromJson(responseData);

    moviesRecommend[movieId] = moviesRecommendResponse.results;

    return moviesRecommendResponse.results;

  }

  Future<List<Cast>> getCastByMovie(int movieId) async{
    print('pedir info al servidor de los actores');

    //Validar si el ya existe un id con una lista de actores asociada.
    if(moviesCast.containsKey(movieId)) return moviesCast[movieId]!;

    final responseData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(responseData);

    moviesCast[movieId] = creditsResponse.cast;
    return  creditsResponse.cast;

  }

  //Search movies
  Future<List<Movie>> getMoviesByQuery(String query) async {

    final URL = Uri.https(baseUrl, '3/search/movie', {
        'api_key': apiKey,
        'language': lenguage,
        'query': query
      }
    );

    var response = await http.get(URL);

    var responseSearch = SearchResponse.fromJson(response.body);

    return responseSearch.results;

  }


  /*
    Quiero usar mi debouncer personalizado para que emita el valor hasta que la persona deje de escribir.
  */
  void getSuggestionsByQuery(String sechtTerm){

    debouncer.value = '';

    //Metodo que llamo cuando pasen las 500 milesimas de segunos.
    debouncer.onValue = (value) async {
      print('tenemos valor a buscar y hacemos la peticion http');
      final result = await getMoviesByQuery(value);
      _suggestionStreamController.add(result); //añado un evento que el streambuilder estara escuchando cuando se lanze
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (timer) {
      debouncer.value = sechtTerm;
    });


    Future.delayed(const Duration(milliseconds: 301)).then((value) => timer.cancel());

  }



}