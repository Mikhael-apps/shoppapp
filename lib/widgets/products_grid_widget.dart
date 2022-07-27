import 'package:flutter/material.dart';
import 'package:shoppapp/provider/products.dart';
import 'package:shoppapp/widgets/product_item.dart';
import 'package:provider/provider.dart';
import '../provider/product.dart';


class ProductsGrid extends StatelessWidget {

  final bool showFavorites;

  ProductsGrid(this.showFavorites);
  // const ProductsGrid({
  //   Key? key,
  //   required this.products,
  // }) : super(key: key);

  // final List<Product> products;



  @override
  Widget build(BuildContext context) {
    final products = Provider.of<Products>(context);
    final productsData = showFavorites ? products.showFavorites : products.items;
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider(
        create: (context) => productsData[index],
        child: ProductItemWidget(
        // productsData[index].id,
        // productsData[index].title,
        // productsData[index].imageUrl,
      ),), 
      itemCount: productsData.length,
    );
  }
}
