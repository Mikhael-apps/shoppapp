import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/products.dart';
import 'package:shoppapp/screens/edit_product_screen.dart';
import 'package:shoppapp/widgets/app_drawer.dart';
import 'package:shoppapp/widgets/user_product_widget.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/user-products';
  const UserProductScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false).fetchAndSetProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.pushNamed(context, EditProductScreen.routName);
          }, icon: const Icon(Icons.add)),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(9),
          child: ListView.builder(
            itemCount: productData.items.length,
            itemBuilder: (_, index) => Column(
              children: [
                UserProductWidget(
                  productData.items[index].id,
                  productData.items[index].title,
                  productData.items[index].imageUrl,
                ),
              const Divider(),
              ],
            )),
        ),
      ),
    );
  }
}