import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/cart.dart';
import 'package:shoppapp/provider/orders.dart';
import 'package:shoppapp/provider/product.dart';
import 'package:shoppapp/provider/products.dart';
import 'package:shoppapp/screens/cart_screen.dart';
import 'package:shoppapp/screens/orders_screen.dart';
import 'package:shoppapp/screens/product_detail_screen.dart';
import 'package:shoppapp/screens/product_overview_screen.dart';


void main() => runApp(const MyApp());


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
      create: (context) => Products(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
          ),
          ChangeNotifierProvider(
            create: (context) => Orders(),
            ),
      ],
      child: MaterialApp(
        title: 'MyShop',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          accentColor: Colors.deepOrange,
          fontFamily: 'Lato',
        ),
        home: ProductOverViewScreen(),
        routes: {
          ProductDetailScreen.routeName: (context) => ProductDetailScreen(),
          CartScreen.routeName: (context) => const CartScreen(),
          OrdersScreen.routeName: (context) => const OrdersScreen(),
        },
      ),
    );
  }
}


// class MyHomePage extends StatelessWidget {
//   const MyHomePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('MyShop'),
//       ),
//       body: Center(
//         child: Text('Hello World'),
//       ),
//     );
//   }
// }