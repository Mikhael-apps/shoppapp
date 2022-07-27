import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shoppapp/provider/orders.dart' as ord;
import 'package:intl/intl.dart';
import 'dart:math';


class OrderItemWidget extends StatefulWidget {
  final ord.OrderItem order;

  OrderItemWidget(this.order);

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  // const OrderItemWidget({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    var _expanded= false;
    return Card(
      margin: const EdgeInsets.all(10),
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle: Text(DateFormat('dd MM yyy hh:mm').format(widget.order.dateTime)),
            trailing: IconButton(onPressed: () {
              setState(() {
                _expanded = !_expanded;
              });
            }, icon: Icon(_expanded ? Icons.expand_less : Icons.expand_more)),
          ),
          if(!_expanded) Container(
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
            height: min(widget.order.products.length * 20.0 + 10, 180),
          child: ListView(children: widget.order.products.map((data) => Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(data.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
              Text('${data.quanitity}x \$${data.price}', style: const TextStyle(fontSize: 18, color: Colors.grey),),
            ],
          )).toList(),),
          ),
        ],
      ),
    );
  }
}