import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppapp/provider/cart.dart';

class CartItemWidget extends StatelessWidget {
  final String id;
  final String productId;
  final String title;
  final int quanitity;
  final double price;
  // const CartItemWidget({Key? key}) : super(key: key);

  CartItemWidget(
      this.id, this.productId, this.title, this.quanitity, this.price);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Are you sure?'),
                  content: Text('Do you want to remove the item from cart?'),
                actions: [
                  FlatButton(child: Text('No'), onPressed: () {Navigator.pop(context, false);},),
                  FlatButton(child: Text('Yes'), onPressed: () {Navigator.pop(context, true);},),
                ],),
                );
      },
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: Icon(Icons.delete, color: Colors.white, size: 40),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<Cart>(context, listen: false).removeItem(productId);
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: FittedBox(
                  child: Text('\$${price}'),
                ),
              ),
            ),
            title: Text(title),
            subtitle: Text('Tital: ${(price * quanitity)}'),
            trailing: Text('$quanitity x'),
          ),
        ),
      ),
    );
  }
}
