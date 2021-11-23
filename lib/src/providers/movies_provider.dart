

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:movies_app/src/models/models.dart';

class MoviesProvider extends ChangeNotifier{ //Es como un Observable. Si la data cambia le notifica a todos los widgets que esten
//escuchando o quieran conocer de estos cambios.

  String baseUrl = 'api.themoviedb.org';
  String apiKey = '117ef0a1fa3a0f69a5d7fe63b6de49cf';
  String lenguage = 'es-ES';

  int _numberPage = 0;

  List<Movie> listMoviesPlaying = [];
  List<Movie> popularMovies = [];

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

}