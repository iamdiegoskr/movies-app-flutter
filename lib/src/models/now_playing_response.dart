import 'dart:convert';

import 'package:movies_app/src/models/models.dart';


class NowPlayingResponse {

    Dates dates;
    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    //Constructor con los argumentos que espero recibir.
    NowPlayingResponse({
      required  this.dates,
      required  this.page,
      required  this.results,
      required  this.totalPages,
      required  this.totalResults,
    });


    //Factory constructor
    factory NowPlayingResponse.fromJson(String str) => NowPlayingResponse.fromMap(json.decode(str));


    factory NowPlayingResponse.fromMap(Map<String, dynamic> json) => NowPlayingResponse(
        dates: Dates.fromMap(json["dates"]),
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}

class Dates {

    DateTime maximum;
    DateTime minimum;

    Dates({
        required this.maximum,
        required this.minimum,
    });


    factory Dates.fromJson(String str) => Dates.fromMap(json.decode(str));


    factory Dates.fromMap(Map<String, dynamic> json) => Dates(
        maximum: DateTime.parse(json["maximum"]),
        minimum: DateTime.parse(json["minimum"]),
    );

}

