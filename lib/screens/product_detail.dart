import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:your_shop/screens/my_product_screen.dart';

class ProductDetail extends StatefulWidget {
  final DocumentSnapshot product;
  ProductDetail({this.product});
  @override
  _ProductDetailState createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  List _couleur = ["couleur", "blanc", "noir", "orange", "violet", "vert"];
  List _taille = ["size", "30x50", "120x160", "normal", "small", "bigest"];
  List _quantite = ["quantite", "1", "2", "3", "4", "5", "6", "7", "8", "9"];

  List<DropdownMenuItem<String>> _dropDownMenuItemCouleur;
  List<DropdownMenuItem<String>> _dropDownMenuItemTaille;

  String _currentCouleur;
  String _currentTaille;

  @override
  void initState() {
    _dropDownMenuItemCouleur = getDropDownMenuItemCouleur();
    _dropDownMenuItemTaille = getDropDownMenuItemTaille();


    _currentCouleur = _dropDownMenuItemCouleur[0].value;
    _currentTaille = _dropDownMenuItemTaille[0].value;

    super.initState();
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemCouleur() {
    List<DropdownMenuItem<String>> items = new List();
    for (String couleur in _couleur) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: couleur, child: new Text(couleur,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold))));
    }
    return items;
  }

  List<DropdownMenuItem<String>> getDropDownMenuItemTaille() {
    List<DropdownMenuItem<String>> items = new List();
    for (String taille in _taille) {
      // here we are creating the drop down menu items, you can customize the item right here
      // but I'll just use a simple text for this
      items.add(new DropdownMenuItem(value: taille, child: new Text(taille,style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold))));
    }
    return items;
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail product"),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
          IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {


                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MyProductScreen()));

              })
        ],
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.bottomCenter,
            children: <Widget>[
              Hero(
                tag: widget.product["productName"],
                child: Image.network(widget.product["productImage"],
                  height: 250.0,
                  fit: BoxFit.cover,),
              ),

              new Container(
                padding: EdgeInsets.all(16.0),
                color: Colors.grey.withAlpha(100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Text(
                      widget.product["productName"],
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                    ),
                    new Text(
                      "${widget.product["productOldPrice"]} \$",
                      style: TextStyle(
                          fontSize: 14.0,
                          color: Colors.orange,
                          decoration: TextDecoration.lineThrough),
                    ),
                    new Text(
                      "${widget.product["productPrice"]} \$",
                      style: TextStyle(
                          fontSize: 18.0,
                          color: Colors.cyan,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new DropdownButton(
                value: _currentCouleur,
                items: _dropDownMenuItemCouleur,
                onChanged: changedDropDownItemCouleur,
              ),
              new DropdownButton(
                value: _currentTaille,
                items: _dropDownMenuItemTaille,
                onChanged: changedDropDownItemTaille,
              ),

            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                width: 230.0,
                child: new RaisedButton(
                  onPressed: () {
                    // une methode de communication avec les achats sera mis ici
                  },
                  color: Theme.of(context).primaryColor,
                  splashColor: Colors.orangeAccent,
                  child: Center(
                      child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      "Acheter maintenant",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w700),
                    ),
                  )),
                ),
              ),
              IconButton(
                  icon: Icon(Icons.add_shopping_cart,color: Colors.deepOrange,),
                  splashColor: Colors.orangeAccent,
                  onPressed: () {
                    // une methode pour ajouter les produits dans la liste de produits en attente d'achat.
                    Map<String,String> productChart={
                      "productName":widget.product["productName"],
                      "productImage":widget.product["productImage"],
                      "userName":"un utilisateur quelconque",
                      "price":widget.product["productPrice"],
                    };
                    Firestore.instance.collection("MyProduct").add(productChart).then((value){
                      print("produit ajouter dans mon panier");
                    });
                  }),
              IconButton(
                  icon: Icon(Icons.favorite_border,color: Colors.deepOrange,),
                  splashColor: Colors.orangeAccent,
                  onPressed: () {
                    // une methode pour ajouter les produits dans la liste de produits en attente d'achat.

                    Map<String,String> productChart={
                      "productName":widget.product["productName"],
                      "productImage":widget.product["productImage"],
                      "userName":"un utilisateur quelconque",
                      "productPrice":widget.product["productPrice"],
                    };
                    Firestore.instance.collection("productLike").add(productChart).then((value){
                      print("produit ajouter dans mes Likes");
                    });
                  })
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text("Product description",style: TextStyle(fontWeight: FontWeight.bold),),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0,right: 10.0,bottom: 10.0),
            child: Text(widget.product["productDetail"],style: TextStyle(color: Colors.black54),textAlign: TextAlign.justify,),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Row(
              children: <Widget>[
                Text("Nom du Produit: ",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                Text("${widget.product["productName"]}",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18.0),)
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Row(
              children: <Widget>[
                Text("Etat du Produit: ",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                Text("nouveau",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18.0),),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left:8.0,right: 8.0),
            child: Row(
              children: <Widget>[
                Text("Produit En Stock: ",style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold),),
                Text("oui",style: TextStyle(color: Colors.black54,fontWeight: FontWeight.bold,fontSize: 18.0),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  void changedDropDownItemCouleur(String selectedCouleur) {
    print("Selected city $selectedCouleur, we are going to refresh the UI");
    setState(() {
      _currentCouleur = selectedCouleur;
    });
  }

  void changedDropDownItemTaille(String selectedTaille) {
    print("Selected city $selectedTaille, we are going to refresh the UI");
    setState(() {
      _currentTaille = selectedTaille;
    });
  }


}
