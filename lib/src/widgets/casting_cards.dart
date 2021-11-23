
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/providers/movies_provider.dart';
import 'package:provider/provider.dart';

class CastingCards extends StatelessWidget {

  final int movieId;

  const CastingCards(this.movieId);


  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return FutureBuilder(
      future: moviesProvider.getCastByMovie(movieId),
      builder: ( _, AsyncSnapshot<List<Cast>> snapchot){

        if(!snapchot.hasData){
          return const SizedBox(
            height: 180,
            child: CupertinoActivityIndicator(),
          );
        }

        final cast = snapchot.data!;

        return Container(
          margin: const EdgeInsets.only(top: 30),
          width: double.infinity,
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: cast.length,
            itemBuilder: (BuildContext context, int index){
              return ActorCard(cast[index]);
            }),
        );

      }
    );
  }
}

class ActorCard extends StatelessWidget {

  final Cast actor;

  const ActorCard(this.actor);


  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      height: 100,
      margin: const EdgeInsets.all(12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              width: 110,
              height: 120,
              placeholder: 'assets/no-image.jpg',
              image: actor.getFullPosterActor())
          ),
          const SizedBox(height: 4),
          Text(actor.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}