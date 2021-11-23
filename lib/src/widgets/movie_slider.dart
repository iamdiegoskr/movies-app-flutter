

import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';

class MoviesSlider extends StatelessWidget {

  List<Movie> popularMovies;
  String? title;

  MoviesSlider({
    Key? key,
    this.title,
    required  this.popularMovies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      //color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(title!=null)
            Padding(
            padding: const EdgeInsets.only(
              top: 6,
              left: 12
            ),
            child: Text(title!, style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
          ),
          Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _MoviePoster(popularMovies[index]);
                  }
              ),
            ),
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.purple,
      width: 120,
      margin: const EdgeInsets.all(12),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details', arguments: 'poster-movie' ),
            child: SizedBox(
              height: 145,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: FadeInImage.assetNetwork(
                  fit: BoxFit.cover,
                  placeholder: 'assets/loading.gif',
                  image: movie.getFullPosterImage()
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: Text(movie.title,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}