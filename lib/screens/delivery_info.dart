import 'package:customertest/screens/add_address.dart';
import 'package:flutter/material.dart';

class DeliveryInfo extends StatefulWidget {
  const DeliveryInfo({Key key}) : super(key: key);
  static const routeName = '/DeliveryInfo';

  @override
  _DeliveryInfoState createState() => _DeliveryInfoState();
}

class _DeliveryInfoState extends State<DeliveryInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delivery Information'),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(15.0),
        height: 95,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Shipping Address',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                InkWell(
                    onTap: () =>
                        Navigator.of(context).pushNamed(AddAddress.routeName),
                    child: const Text('Change',
                        style:
                            TextStyle(color: Colors.deepOrange, fontSize: 17)))
              ],
            ),
            const Divider(),
            const SizedBox(height: 5.0),
          ],
        ),
      ),
    );
  }
}
