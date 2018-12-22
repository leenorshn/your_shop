import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyProductScreen extends StatefulWidget {
  @override
  _MyProductScreenState createState() => _MyProductScreenState();
}

class _MyProductScreenState extends State<MyProductScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My product"),
      ),
      body: StreamBuilder(
          stream: Firestore.instance.collection("MyProduct").snapshots(),
          builder: (_, snapshot) {
            if (snapshot.hasError) return new Text('Error: ${snapshot.error}');
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return Center(child: CircularProgressIndicator());
              default:

                if(snapshot.data.documents.length<=0){
                  return Center(child: Card(
                    child: Container(
                      height: 190.0,
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: <Widget>[
                        Image.asset("images/empty.jpg",width: 120.0,height: 120.0,),
                          new Text("Aucun donnee choisi",style: TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold),),
                          new Text("veillez choisir des product dans la liste",style: TextStyle(color: Colors.grey),)
                        ],
                      ),
                    ),
                  ),);
                }else{
                return ListView.builder(
                    padding: EdgeInsets.only(left: 13.0, right: 13.0),
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (_, index) {
                      DocumentSnapshot docs = snapshot.data.documents[index];

                      return CardItemProduct(
                        product: docs,
                      );
                    });
            }}
          }),
    );
  }
}

class CardItemProduct extends StatefulWidget {
  final DocumentSnapshot product;
  CardItemProduct({this.product});

  @override
  _CardItemProductState createState() => _CardItemProductState();
}

class _CardItemProductState extends State<CardItemProduct> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 120.0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 130.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.product["productImage"]),
                ),
              ),
            ),
            Expanded(
                child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        widget.product["productName"],
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "\$ ${widget.product["price"]}",
                        style: TextStyle(
                            color: Colors.orange,
                            fontSize: 20.0,
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Material(
                          color: Colors.cyan,
                          child: InkWell(
                            onTap: () {
                              print("quantite dimunie");
                            },
                            child: Container(
                              width: 30.0,
                              height: 30.0,
                              child: Center(
                                  child: Text(
                                "-",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Container(
                            child: Center(
                                child: Text(
                          "0",
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.bold),
                        ))),
                        SizedBox(
                          width: 10.0,
                        ),
                        Material(
                          child: InkWell(
                            onTap: () {
                              print("quantite augment");
                            },
                            child: Container(
                              color: Colors.cyan,
                              width: 30.0,
                              height: 30.0,
                              child: Center(
                                child: Text(
                                  "+",
                                  style: TextStyle(
                                      fontSize: 25.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        IconButton(icon: Icon(Icons.delete), onPressed: (){
                          Firestore.instance
                              .collection('MyProduct')
                              .document(widget.product.documentID)
                              .delete().then((value){
                                print("document effacer ");
                              })
                              .catchError((e) {
                            print(e);
                          });

                        })
                      ],
                    ),
                  ),
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
