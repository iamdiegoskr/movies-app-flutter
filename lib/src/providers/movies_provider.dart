

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/models.dart';

class MoviesProvider extends ChangeNotifier{ //Es como un Observable. Si la data cambia le notifica a todos los widgets que esten
//escuchando o quieran conocer de estos cambios.

  String baseUrl = 'api.themoviedb.org';
  String apiKey = '117ef0a1fa3a0f69a5d7fe63b6de49cf';
  String lenguage = 'es-ES';
  String page = '1';

  List<Movie> listMoviesPlaying = [];
  List<Movie> popularMovies = [];

  MoviesProvider(){
    print('MoviesProvider constructor..');
    getNowPlayingMovies();
    getPopularMovies();
  }

  getNowPlayingMovies() async{
    print('obteniendo peliculas que estan en cartelera..');

    var url = Uri.https(baseUrl, '3/movie/now_playing', {
        'api_key': apiKey,
        'language': lenguage,
        'page': page
      }
    );

    var response = await http.get(url);

    //var jsonResponse = json.decode(response.body) as Map<String, dynamic>;
    //print(jsonResponse['results'][0]['title']); MAS DIFICIL DE TRABAJAR

    final nowPlayingReponse = NowPlayingResponse.fromJson(response.body);

    listMoviesPlaying = nowPlayingReponse.results;
    notifyListeners();
  }


  getPopularMovies() async {
    print('Obteniendo las peliculas mas populares.....');

    var url = Uri.https(baseUrl, '3/movie/popular', {
        'api_key': apiKey,
        'language': lenguage,
        'page': page
      }
    );

    var response = await http.get(url);
    final popularMoviesResponse = PopularMoviesResponse.fromJson(response.body);

    popularMovies = [ ...popularMovies , ...popularMoviesResponse.results];

    notifyListeners();
  }

}