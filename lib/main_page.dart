import 'package:flutter/material.dart';
import 'package:your_shop/component/carousel_build.dart';
import 'package:your_shop/component/drawer_build.dart';
import 'package:your_shop/component/horizontal_categorie_list.dart';
import 'package:your_shop/component/product_build.dart';
import 'package:your_shop/screens/my_product_screen.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("your shop"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProductScreen()));
            },
          ),
        ],
      ),
      drawer: DrawerBuild(),
      body: ListView(
        children: <Widget>[

          imageCarousel,

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Toute Cathegories"),
          ),

          HorizontalCathegorieList(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Toute Cathegories"),
          ),

          Container(
            height: 320.0,
            child: ProductsBuild(),),


        ],
      ),
    );
  }
}
