import 'package:flutter/material.dart';

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
          _CustomAppBar()
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