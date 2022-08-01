import 'package:flutter/material.dart';
import 'package:shoppapp/provider/cart.dart';
import 'package:shoppapp/provider/products.dart';
import 'package:shoppapp/widgets/app_drawer.dart';
import 'package:shoppapp/widgets/badge.dart';
import 'package:shoppapp/widgets/product_item.dart';
import '../provider/product.dart';
import '../widgets/products_grid_widget.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';


enum FilterOptions {
    Favorites,
    All,
  }

  

class ProductOverViewScreen extends StatefulWidget {
 
  @override
  State<ProductOverViewScreen> createState() => _ProductOverViewScreenState();
}

class _ProductOverViewScreenState extends State<ProductOverViewScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }
  var _showFavorites = false;
  var _isInit = true;
  // const ProductOverViewScreen({Key? key}) : super(key: key);

  // loadData from http
  @override
  void initState() {
    // Provider.of<Products>(context).fetchAndSetProducts(); // This not working
    // Future.delayed(Duration.zero).then((data) {
    //   Provider.of<Products>(context, listen: false).fetchAndSetProducts();
    // });
    // TODO: implement initState

    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    if(_isInit) {
      Provider.of<Products>(context).fetchAndSetProducts();
    }
    _isInit = false;
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    // final productsContainer= Provider.of<Products>(context, listen: false);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('MyShop'),
        actions: <Widget>[
          IconButton(onPressed: () {
            Navigator.pushNamed(context, CartScreen.routeName);
          }, icon: Icon(Icons.shopping_cart),),
          PopupMenuButton(
            onSelected: (FilterOptions selectValue) {
              setState(() {
                if(selectValue == FilterOptions.Favorites){
                _showFavorites = true;
                print('show favorites');
              } else {
                _showFavorites = false;
                print('ShowAll');
              }
              });
              
               },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(child: Text('Onlu Favorites'), value: FilterOptions.Favorites,),
              PopupMenuItem(child: Text('Show All'), value: FilterOptions.All,),
            ],
          ),  
          // Consumer<Cart>(builder: (context, cart, ch) => Badge(

          //   color: Colors.red,
          //   child: ch,
          //   value: cart.itemCount.toString(),
            
          // ),
          // child: IconButton(
          //     onPressed: () {},
          //     icon: Icon(Icons.shopping_cart),
          //   ),
          //   ),
          
        ],
      ),
      drawer: const AppDrawerWidget(),
      body: ProductsGrid(_showFavorites),
    );
  }
}

