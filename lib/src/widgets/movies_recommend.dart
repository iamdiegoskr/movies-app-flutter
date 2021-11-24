import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/movie.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class MoviesRecommend extends StatelessWidget {

  final String title;
  final int movieIdToRecommend;

  const MoviesRecommend(
    {Key? key,
    required this.movieIdToRecommend,
    required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final providerMovies = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: providerMovies.getMoviesRecommend(movieIdToRecommend),
      builder: ( _, AsyncSnapshot<List<Movie>> snapchot){

        if(!snapchot.hasData){
          return const SizedBox(
            height: 260,
            child: CupertinoActivityIndicator(),
          );
        }

        final List<Movie> listMoviesRecommend = snapchot.data!;

        return Container(
          width: double.infinity,
          height: 260,
          margin: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(title, style: Theme.of(context).textTheme.headline6),
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: listMoviesRecommend.length,
                  itemBuilder: (BuildContext context, int index){
                    return CardRecommend(listMoviesRecommend[index], title);
                  }),
              ),
            ],
          )
        );
      }
    );
  }
}


class CardRecommend extends StatelessWidget {

  final Movie movieRecommend;
  final String title;

  const CardRecommend(this.movieRecommend, this.title);

  @override
  Widget build(BuildContext context) {

    movieRecommend.heroId = 'recommend-${movieRecommend.id}';

    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, 'details', arguments: movieRecommend),
      child: Container(
        width: 110,
        margin: const EdgeInsets.all(8),
        child: Column(
          children: [
            Hero(
              tag: movieRecommend.heroId!,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: FadeInImage(
                  width: 100,
                  fit: BoxFit.cover,
                  placeholder: const AssetImage('assets/no-image.jpg'),
                  image: NetworkImage(movieRecommend.getFullPosterImage()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Text(movieRecommend.title,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
            )
          ],
        ),
      ),
    );
  }
}