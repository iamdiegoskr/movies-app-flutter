import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final deviceSize = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: deviceSize.height * 0.6,
      color: Colors.pink,
      child: Swiper(
        itemCount: 10,
        layout: SwiperLayout.STACK, //La forma en que vamos a mover los cards
        itemWidth: deviceSize.width * 0.6,
        itemHeight: deviceSize.height * 0.5,
        itemBuilder: (BuildContext context, int index){
            //Debemos regresar un Widget, el que sera utilizado para renderizar la tarjeta
            return  GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, 'details');
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: FadeInImage.assetNetwork(
                  placeholder: 'assets/no-image.jpg',
                  image: 'https://via.placeholder.com/300x400',
                  fit: BoxFit.cover,
                ),
              ),
            );
        },
      ),
    );
  }
}