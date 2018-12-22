import 'package:flutter/material.dart';

class HorizontalCathegorieList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.0),
      height: 95.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Cathegorie(
            imageCathegorie: "images/cats/tshirt.png",
            captionCathegorie: "Tshirt",
          ),
          Cathegorie(
            imageCathegorie: "images/cats/formal.png",
            captionCathegorie: "Formal",
          ),
          Cathegorie(
            imageCathegorie: "images/cats/informal.png",
            captionCathegorie: "Informal",
          ),
          Cathegorie(
            imageCathegorie: "images/cats/jeans.png",
            captionCathegorie: "Jeans",
          ),
          Cathegorie(
            imageCathegorie: "images/cats/shoe.png",
            captionCathegorie: "Shoe",
          ),
          Cathegorie(
            imageCathegorie: "images/cats/dress.png",
            captionCathegorie: "Dress",
          ),
          Cathegorie(
            imageCathegorie: "images/cats/accessories.png",
            captionCathegorie: "Accessories",
          ),
        ],
      ),
    );
  }
}

class Cathegorie extends StatelessWidget {
  final String imageCathegorie;
  final String captionCathegorie;

  Cathegorie({this.imageCathegorie, this.captionCathegorie});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 80.0,
          child: ListTile(
            title: Image.asset(
              imageCathegorie,
              width: 80.0,
              height: 70.0,
            ),
            subtitle: Container(
                alignment: Alignment.topCenter,
                child: Text(captionCathegorie,style: TextStyle(fontSize: 12.0),)),
          ),
        ),
      ),
    );
  }
}
