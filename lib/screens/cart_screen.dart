import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/cart.dart';
import 'package:shoppapp/provider/orders.dart';
import 'package:shoppapp/screens/orders_screen.dart';
import 'package:shoppapp/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cart';
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Cart'),
        ),
        body: Column(
          children: <Widget>[
            Card(
              margin: EdgeInsets.all(15),
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'Total',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Spacer(),
                    Chip(
                      label: Text(
                        '\$${cart.totalAmount}',
                        style: TextStyle(
                            color: Theme.of(context)
                                .primaryTextTheme
                                .titleMedium!
                                .color),
                      ),
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    OrderButton(cart: cart),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: cart.items.length,
              itemBuilder: (context, index) => CartItemWidget(
                  cart.items.values.toList()[index].id,
                  cart.items.keys.toList()[index],
                  cart.items.values.toList()[index].title,
                  cart.items.values.toList()[index].quanitity,
                  cart.items.values.toList()[index].price),
            ))
          ],
        ));
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading) ? null : () async {
        setState(() {
          _isLoading = true;
        });
         Provider.of<Orders>(context, listen: false).addOrders(
            widget.cart.items.values.toList(), 
            widget.cart.totalAmount
            );
            setState(() {
              _isLoading = false;
            });
        widget.cart.clearItem();
      },
      child: _isLoading ? CircularProgressIndicator() : Text(
        'Order now',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 20),
      ),
    );
  }
}
