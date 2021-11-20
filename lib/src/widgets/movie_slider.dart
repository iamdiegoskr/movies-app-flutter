

import 'package:flutter/material.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230,
      //color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(
              top: 6,
              left: 12
            ),
            child: Text('Peliculas populares', style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),),
          ),
            Expanded(
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) => const _MoviePoster()
              ),
            ),
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {
  const _MoviePoster({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.purple,
      width: 120,
      margin: const EdgeInsets.all(12),
      child: Column(
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 145,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: FadeInImage.assetNetwork(
                fit: BoxFit.cover,
                placeholder: 'assets/loading.gif',
                image: 'https://via.placeholder.com/300x400'
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 6),
            child: Text('Name movie',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}