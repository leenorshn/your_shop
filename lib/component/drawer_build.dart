import 'package:flutter/material.dart';
import 'package:your_shop/screens/help_screen.dart';
import 'package:your_shop/screens/my_account_screen.dart';
import 'package:your_shop/screens/my_favo_screen.dart';
import 'package:your_shop/screens/my_product_screen.dart';
import 'package:your_shop/screens/new_product_screen.dart';
import 'package:your_shop/screens/profile_user_screen.dart';
import 'package:your_shop/screens/settings_screen.dart';

class DrawerBuild extends StatefulWidget {
  @override
  _DrawerBuildState createState() => _DrawerBuildState();
}

class _DrawerBuildState extends State<DrawerBuild> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ProfileUserScreen()));
            },
            child: UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 30.0,
              ),
              accountName: Text("victor shukuru"),
              accountEmail: Text("sh@roonit.io"),
              onDetailsPressed: (){

              },
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Acceuil"),
            onTap: (){
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Mon Compte"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyAccountScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.dashboard),
            title: Text("Mes Commandes"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyProductScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.add_box,),
            title: Text("nouveau produit"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>NewProductScreen()));
            },
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text("Favorites"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>MyFavoriteScreen()));
            },
          ),
          Divider(),
          ListTile(
            trailing: Icon(Icons.settings),
            title: Text("Paramettre"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>SettingScreen()));
            },
          ),
          ListTile(
            trailing: Icon(Icons.help_outline),
            title: Text("A propos"),
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HelpScreen()));
            },
          ),


        ],
      ),
    );
  }
}
