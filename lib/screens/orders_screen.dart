import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/orders.dart' show Orders;
import 'package:shoppapp/widgets/app_drawer.dart';
import 'package:shoppapp/widgets/order_item_widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/orders';
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orderData = Provider.of<Orders>(context);
    return Scaffold(
      drawer: const AppDrawerWidget(),
      appBar: AppBar(
        title: const Text('Your Orders'),
      ),
      body: 
          Container(
            height: double.infinity,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderData.orders.length,
              itemBuilder: (context, index) =>
                  OrderItemWidget(orderData.orders[index]),
            ),
          ),
    );
  }
}
