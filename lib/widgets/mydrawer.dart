import 'package:customertest/providers/auth.dart';
import 'package:customertest/screens/profile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key key}) : super(key: key);

  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Drawer(
        child: Column(
          children: [
            const UserAccountsDrawerHeader(
              currentAccountPicture:
                  CircleAvatar(backgroundColor: Colors.deepOrange),
              accountName: Text("Welcome"),
              accountEmail: Text(''),
            ),
            ListTile(
              title: const Text("Profile"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushReplacementNamed(Profile.routeName);
              },
            ),
            ListTile(
              title: const Text("Order history"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("profile");
              },
            ),
            /*ListTile(
              title: const Text("Delivery address"),
              leading: const Icon(Icons.shopping_cart),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("cart");
              },
            ),*/
            ListTile(
              title: const Text("Notifications"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushReplacementNamed("homepage");
              },
            ),
            /* ListTile(
              title: const Text("MoreScreen"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushNamed(MoreScreen.routeName);
              },
            ),*/
            /* ListTile(
              title: const Text("Address"),
              leading: const Icon(Icons.location_city),
              onTap: () {
                Navigator.of(context).pushNamed(Address.routeName);
              },
            ),*/
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
    );
  }
}
