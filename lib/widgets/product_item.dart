import 'package:flutter/material.dart';

class ProductItemWidget extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  const ProductItemWidget(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(imageUrl, fit: BoxFit.cover,),
      footer: GridTileBar(
        backgroundColor: Colors.black45,
        leading: IconButton(
          onPressed: () {}, 
          icon: Icon(Icons.favorite,
          ),
          ),
          trailing: IconButton(onPressed: () {}, icon: Icon(Icons.shopping_cart)),
          title: Text(title, textAlign: TextAlign.center,),
      ),
    );
  }
}
