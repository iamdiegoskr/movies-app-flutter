
import 'dart:convert';

import 'package:movies_app/src/models/models.dart';

class MoviesRecommendResponse {

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    MoviesRecommendResponse({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });

    factory MoviesRecommendResponse.fromJson(String str) => MoviesRecommendResponse.fromMap(json.decode(str));

    factory MoviesRecommendResponse.fromMap(Map<String, dynamic> json) => MoviesRecommendResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}

