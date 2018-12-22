import 'package:flutter/material.dart';
import 'package:your_shop/models/product.dart';
import 'package:your_shop/screens/product_detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class ProductsBuild extends StatefulWidget {
  @override
  _ProductsBuildState createState() => _ProductsBuildState();
}

class _ProductsBuildState extends State<ProductsBuild> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection("product").snapshots(),
      builder: (context,snapshot){

        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:


         return GridView.builder(
              itemCount: snapshot.data.documents.length,
              gridDelegate:
              new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),

              itemBuilder: (BuildContext context, int index) {
                DocumentSnapshot document=snapshot.data.documents[index];
                print(document["productPrice"]);
                return GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product: snapshot.data.documents[index],)));
                  },
                  child: SingleProduct(
                    productName: document["productName"],
                    productImage: document["productImage"],
                    productDetail: document["productDetail"],
                    productOldPrice: document["productOldPrice"],
                    productPrice: document["productPrice"],
                  ),
                );


              });
        }



      },
     /**/
    );
  }
}

class SingleProduct extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productDetail;
  final String productPrice;
  final String productOldPrice;



  SingleProduct(
      {this.productName,
        this.productImage,
        this.productDetail,
        this.productPrice,
        this.productOldPrice,

      });

  /*void moveTodetail(BuildContext context,int index){
    Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetail(product:snapshot.data.documents[index],)));
  }*/

 Widget buidCard(BuildContext context){
    return Card(
      child: Hero(
        tag: productName,
        child: Material(
          child: InkWell(
            child: GridTile(
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Text(
                      productName,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    title: Text(
                      "\$ $productPrice",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontWeight: FontWeight.w800,
                          fontSize: 20.0
                      ),
                    ),
                    subtitle: Text(
                      "\$ $productOldPrice",
                      style: TextStyle(
                          color: Colors.black54,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  ),
                ),
                child:Image.network(
                  productImage,

                ), ),
          ),
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    return buidCard(context);
  }
}