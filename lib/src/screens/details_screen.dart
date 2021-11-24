import 'package:flutter/material.dart';
import 'package:movies_app/src/models/models.dart';
import 'package:movies_app/src/widgets/widgets.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no movie';
    final Movie movie = ModalRoute.of(context)!.settings.arguments as Movie;

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          _CustomAppBar(movie),
          SliverList(delegate: SliverChildListDelegate([
            _PosterAndTitle(movie),
            _Overview(movie),
            _Overview(movie),
            _Overview(movie),
            _Overview(movie),
            CastingCards(movie.id),
            MoviesRecommend(movieIdToRecommend: movie.id, title: 'Peliculas recomendadas')
          ]))
        ],
      )
    );
  }
}


class _CustomAppBar extends StatelessWidget {

  final Movie movie;

  const _CustomAppBar(this.movie);

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
      backgroundColor:  Colors.indigo,
      expandedHeight: 200,
      floating: false,
      pinned: true, //para que llegue a un punto y no desaparezca.
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: EdgeInsets.zero,
        centerTitle: true,
        title: Container(
          width: double.infinity,
          alignment: Alignment.bottomCenter,
          color: Colors.black45,
          child:  Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
            child: Text(movie.title,
            style: const TextStyle(
              fontSize: 16
            ),
            ),
          )
        ),
        background: FadeInImage(
          fit: BoxFit.cover,
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(movie.getFullBackdropPath()),
      ),
    ));
  }
}

class _PosterAndTitle extends StatelessWidget {

  final Movie movie;

  const _PosterAndTitle(this.movie);

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;

    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          Hero(
            tag: movie.heroId!,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                height: 150,
                width: 110,
                placeholder: 'assets/no-image.jpg',
                image: movie.getFullPosterImage()),
            ),
          ),
          const SizedBox(width: 12),
          ConstrainedBox(
            constraints: BoxConstraints(maxWidth: size.width - 180),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.headline6
                  ),
                  const SizedBox(height: 8,),
                  Text(
                    movie.originalTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 16),
                    child: Row(
                      children: [
                        const Icon(Icons.star_border_outlined, color: Colors.amber, size: 26,),
                        const SizedBox(width: 12,),
                        Text(movie.voteAverage.toString())
                      ],
                    ),
                  )
                ],
              ),
          ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {

  final Movie movie;

  const _Overview(this.movie);


  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text(movie.overview,
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}