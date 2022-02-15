import 'package:flutter/material.dart';
import '../providers/cart.dart';
import '../providers/orders.dart' show Orders;
import 'package:provider/provider.dart';
import 'Homepage.dart';

class CheckOut extends StatelessWidget {
  //Cart cart ;

  static const routeName = '/CheckOut';

  const CheckOut({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    final cart = Provider.of<Cart>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Check Out your order'),
        ),
        body: Container(
          margin: const EdgeInsets.all(50),
          child: Card(
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'DateTime :          ',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 20),
                    ),
                    //Spacer(),
                    Text(
                      '${args['date'].year}/${args['date'].month}/${args['date'].day}',
                      style: const TextStyle(fontSize: 20),
                    )
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    const Text(
                      'TimeOfDay :         ',
                      style: TextStyle(color: Colors.deepOrange, fontSize: 20),
                    ),
                    // Spacer(),
                    args['time'].hour > 12
                        ? Text(
                            '${args['time'].hour + 12}:${args['time'].minute} (pm)',
                            style: const TextStyle(fontSize: 20))
                        : Text(
                            '${args['time'].hour}:${args['time'].minute} (am)',
                            style: const TextStyle(fontSize: 20)),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    args['delivery'] == true
                        ? const Text(
                            'Delivery_Address : ',
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 20),
                          )
                        : const Text(
                            'NumberOfPeople :          ',
                            style: TextStyle(
                                color: Colors.deepOrange, fontSize: 20),
                          ),
                    //Spacer(),
                    args['delivery'] == true
                        ? const Text(
                            'Jenin',
                            style: TextStyle(fontSize: 20),
                          )
                        : Text(
                            '${args['numberPeople']}',
                            style: const TextStyle(fontSize: 20),
                          )
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () async {
                    await Provider.of<Orders>(context, listen: false).addOrders(
                        cart.items.values.toList(),
                        cart.totalAmount,
                        args['delivery'],
                        args['time'],
                        args['date'],
                        args['numberPeople'].toString());

                    Navigator.of(context)
                        .pushReplacementNamed(Homepage.routeName);
                  },
                )
              ],
            ),
          ),
        ));
  }
}
