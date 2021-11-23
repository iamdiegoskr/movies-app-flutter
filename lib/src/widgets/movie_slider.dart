

import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';

class MoviesSlider extends StatefulWidget {

  final List<Movie> popularMovies;
  final String? title;
  final Function onNextPage;


  MoviesSlider({
    Key? key,
    this.title,
    required  this.popularMovies,
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

      //print(scrollController.position.pixels);
      //print(scrollController.position.maxScrollExtent); //hasta donde se puede extender

      if(scrollController.position.pixels>=scrollController.position.maxScrollExtent - 500){
        print('Obtener siguiente pagina');
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
      //color: Colors.green,
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
                  itemCount: widget.popularMovies.length,
                  itemBuilder: (BuildContext context, int index) {
                    return _MoviePoster(widget.popularMovies[index]);
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
            onTap: ()=>Navigator.pushNamed(context, 'details', arguments: movie ),
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