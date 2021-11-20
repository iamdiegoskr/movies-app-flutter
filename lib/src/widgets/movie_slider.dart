import 'dart:math';

import 'package:flutter/material.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      color: Colors.green,
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
            padding: const EdgeInsets.all(12),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Container(
                width: 130,
                height: 190,
                color: Colors.primaries[Random().nextInt(Colors.primaries.length)],
                  child:  FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    placeholder: 'assets/no-image.jpg',
                    image: 'https://picsum.photos/200/200'),
              ),
            ),
          );
      }
}