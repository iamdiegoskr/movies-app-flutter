import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/src/models/models.dart';

class CardSwiper extends StatelessWidget {

  List<Movie> movies;

  CardSwiper({
    Key? key,
    required this.movies
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;

    if(movies.isEmpty){
      return SizedBox(
        width: double.infinity,
        height: deviceSize.height * 0.6,
        child: const Center(
          child: CircularProgressIndicator(
            color: Colors.indigo,
          ),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: deviceSize.height * 0.6,
      child: Swiper(
        itemCount: movies.length,
        layout: SwiperLayout.STACK, //La forma en que vamos a mover los cards
        itemWidth: deviceSize.width * 0.6,
        itemHeight: deviceSize.height * 0.5,
        itemBuilder: (BuildContext context, int index){
            //Debemos regresar un Widget, el que sera utilizado para renderizar la tarjeta

            print(movies[index].backdropPath);

            return  GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'details', arguments: 'card-movie');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/no-image.jpg',
                  image: movies[index].getFullPosterImage(),
                  fit: BoxFit.cover,
                ),
                // child: Image(
                //   fit: BoxFit.cover,
                //   image: NetworkImage(movies[index].getFullPosterImage())
                // ),
              ),
            );
        },
      ),
    );
  }
}