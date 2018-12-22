import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyFavoriteScreen extends StatefulWidget {
  @override
  _MyFavoriteScreenState createState() => _MyFavoriteScreenState();
}

class _MyFavoriteScreenState extends State<MyFavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My favorite"),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.shopping_cart), onPressed: () {})
        ],
      ),
      body: Container(
        child: StreamBuilder(
            stream: Firestore.instance.collection("productLike").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Card(
                    child: Container(
                      height: 120.0,
                      child: Center(
                        child: Column(
                          children: <Widget>[
                            Text(
                              "Erreur est survenu",
                              style: TextStyle(
                                  fontSize: 25.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
                            ),
                            Text(
                              "veillez verifier votre connexion",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );

              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.data.documents.length <= 0) {
                    return Center(
                      child: Card(
                        child: Container(
                          height: 190.0,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Image.asset(
                                "images/empty.jpg",
                                width: 120.0,
                                height: 120.0,
                              ),
                              new Text(
                                "Aucun donnee choisi",
                                style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.bold),
                              ),
                              new Text(
                                "veillez choisir des product dans la liste",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                        padding: EdgeInsets.only(left: 13.0, right: 13.0),
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (_, index) {
                          DocumentSnapshot docs =
                              snapshot.data.documents[index];

                          return CardItemProduct(docs);
                        });
                  }
              }
            }),
      ),
    );
  }

  Widget CardItemProduct(DocumentSnapshot docs) {
    return Card(
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              height: 120.0,
              width: 100.0,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(docs["productImage"]))),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      docs["productName"],
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "\$ ${docs["productPrice"]}",
                      style: TextStyle(color: Colors.lightBlue),
                    ),
                  )
                ],
              ),
            ),
            Spacer(),
            Container(
                child: Column(
              children: <Widget>[
                IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      Firestore.instance
                          .collection("productLike")
                          .document(docs.documentID)
                          .delete()
                          .then((v) {
                        print(
                            "produt ${docs.documentID} vien d'etre efface dans la liste de preference");
                      });
                    }),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: OutlineButton(
                    onPressed: () {

                      Map<String,String> productChart={
                        "productName":docs["productName"],
                        "productImage":docs["productImage"],
                        "userName":"un utilisateur quelconque",
                        "price":docs["productPrice"],
                      };
                      Firestore.instance.collection("MyProduct").add(productChart).then((value){
                        print("produit ajouter dans mon panier");
                        Firestore.instance
                            .collection("productLike")
                            .document(docs.documentID)
                            .delete()
                            .then((v) {
                          print(
                              "produt ${docs.documentID} vien d'etre efface dans la liste de preference");
                        });
                      });

                    },
                    shape: StadiumBorder(side: BorderSide(color: Colors.lightBlue,width: 1.0)),
                    child: Text("Ajouter au panniez",style: TextStyle(color: Colors.lightBlue,),),
                    padding: EdgeInsets.all( 8.0),
                  ),
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
