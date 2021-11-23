
import 'dart:convert';

import 'package:movies_app/src/models/models.dart';

class PopularMoviesResponse {

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    PopularMoviesResponse({
      required this.page,
      required this.results,
      required this.totalPages,
      required this.totalResults,
    });

    factory PopularMoviesResponse.fromJson(String str) => PopularMoviesResponse.fromMap(json.decode(str));

    factory PopularMoviesResponse.fromMap(Map<String, dynamic> json) => PopularMoviesResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}

