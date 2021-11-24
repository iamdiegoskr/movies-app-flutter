

import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';

class MoviesSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;


  const MoviesSlider({
    Key? key,
    this.title,
    required  this.movies,
    required this.onNextPage
  }) : super(key: key);

  @override
  State<MoviesSlider> createState() => _MoviesSliderState();
}

class _MoviesSliderState extends State<MoviesSlider> {

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(() {

      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent - 500){
        widget.onNextPage();
      }


    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(widget.title!=null)
            Padding(
            padding: const EdgeInsets.only(
              top: 6,
              left: 12
            ),
            child: Text(widget.title!, style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black
            ),),
          ),
          Expanded(
              child: ListView.builder(
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.movies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _MoviePoster(widget.movies[index], '${widget.title}-${index}-${widget.movies[index].id}');
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
  final String heroeId;

  const _MoviePoster(this.movie, this.heroeId);


  @override
  Widget build(BuildContext context) {

    movie.heroId = heroeId;

    return Container(
      //color: Colors.purple,
      width: 120,
      margin: const EdgeInsets.all(12),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: ()=>Navigator.pushNamed(context, 'details', arguments: movie ),
            child: Hero(
              tag: movie.heroId!,
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