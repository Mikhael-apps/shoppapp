import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/products.dart';

import '../screens/edit_product_screen.dart';

class UserProductWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  

  UserProductWidget(this.id, this.title, this.imageUrl);
  // const UserProductWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: <Widget>[
            IconButton(onPressed: () {
              Navigator.pushNamed(context, EditProductScreen.routName, arguments: id);
            }, icon: Icon(Icons.edit, color: Theme.of(context).primaryColor,)),
            IconButton(onPressed: () async {
              try {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              } catch(error) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Deleting failed!', textAlign: TextAlign.center,),));
              }
              
            }, icon: Icon(Icons.delete, color: Theme.of(context).errorColor,)),
          ],
        ),
      ),
    );
  }
}