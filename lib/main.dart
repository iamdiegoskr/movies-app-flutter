import 'package:flutter/material.dart';

import 'package:movies_app/src/screens/screens.dart';


void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(
        appBarTheme: const AppBarTheme(
          color:  Colors.indigo
        )
      ),
      title: 'Peliculas',
      initialRoute: 'home',
      routes: {
        'home':(context)=> const HomeScreen(),
        'details':(context)=>const DetailsScreen()
      },
    );
  }
}