import 'package:flutter/material.dart';

class CastingCards extends StatelessWidget {
  const CastingCards({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 30),
      width: double.infinity,
      height: 180,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 10,
        itemBuilder: (BuildContext context, int index){
          return const ActorCard();
        }),
    );
  }
}

class ActorCard extends StatelessWidget {
  const ActorCard({Key? key}) : super(key: key);

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
              image: 'https://via.placeholder.com/200x300')
          ),
          const SizedBox(height: 4),
          const Text('Leonardo Dicaprio Martinez',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,)
        ],
      ),
    );
  }
}