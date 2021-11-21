import 'package:flutter/material.dart';
import 'package:movies_app/src/widgets/widgets.dart';


class DetailsScreen extends StatelessWidget {
  const DetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final String movie = ModalRoute.of(context)?.settings.arguments.toString() ?? 'no movie';

    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics()),
        slivers: [
          _CustomAppBar(),
          SliverList(delegate: SliverChildListDelegate([
            const _PosterAndTitle(),
            const _Overview(),
            const _Overview(),
            const _Overview(),
            const _Overview(),
            const _Overview(),
            const _Overview(),
            const _Overview(),
            const CastingCards()
          ]))
        ],
      )
    );
  }
}


class _CustomAppBar extends StatelessWidget {

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
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('Movie.title',
            style: TextStyle(
              fontSize: 18
            ),
            ),
          )
        ),
        background: const FadeInImage(
          fit: BoxFit.cover,
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://www.xtrafondos.com/wallpapers/paisaje-digital-en-atardecer-5846.jpg')),
      ),
    );
  }
}

class _PosterAndTitle extends StatelessWidget {
  const _PosterAndTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 22, bottom: 22),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage.assetNetwork(
              fit: BoxFit.cover,
              height: 150,
              placeholder: 'assets/no-image.jpg',
              image: 'https://via.placeholder.com/200x300'),
          ),
          const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Movie title',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.headline5
                ),
                const Text(
                  'Movie original title'),
                Padding(
                  padding: const EdgeInsets.only(top: 16),
                  child: Row(
                    children: const [
                      Icon(Icons.star_border_outlined, color: Colors.amber, size: 26,),
                      SizedBox(width: 12,),
                      Text('4.6')
                    ],
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

class _Overview extends StatelessWidget {
  const _Overview({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      child: Text('Labore minim nulla veniam deserunt voluptate cillum mollit. Voluptate ut non qui ex aute sunt magna veniam eu dolore ipsum. Labore laboris enim anim enim commodo eiusmod. In nisi Lorem adipisicing excepteur ex magna sunt ad.',
      textAlign: TextAlign.justify,
      style: Theme.of(context).textTheme.subtitle1,
      ),
    );
  }
}