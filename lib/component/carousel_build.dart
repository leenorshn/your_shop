import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

Widget imageCarousel=Container(
  height: 200.0,
  child:Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage("images/c1.jpg"),
      AssetImage("images/m1.jpeg"),
      AssetImage("images/w3.jpeg"),
      AssetImage("images/w4.jpeg"),

    ],
    autoplay: true,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(microseconds: 1000),
    dotSize: 4.0,
    indicatorBgPadding: 8.0,

  ) ,
);