import 'package:flutter/material.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = '/OrdersScreen';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Orders'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Provider.of<Orders>(context, listen: false).fetchAndSetOrders(),
        builder: (ctx, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.error != null) {
              return const Center(child: Text('An error occured!'));
            }
            if (snapshot.data == null) {
              return const Center(
                  child: Text(
                "There is no orders yet!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    fontFamily: 'Quikhand'),
              ));
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) => ListView.builder(
                    itemCount: orderData.orders.length,
                    itemBuilder: (BuildContext context, int index) =>
                        OrderItem(orderData.orders[index])),
              );
              //
            }
          }
        },
      ),
    );
  }
}
