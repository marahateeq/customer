import 'package:customertest/screens/Homepage.dart';
import 'package:customertest/screens/more_screen.dart';
import 'package:customertest/screens/product_overview_screen.dart';
import 'package:customertest/screens/restaurants_screen.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

int _selectedIndex = 0;

class _BottomNavBarState extends State<BottomNavBar> {
  _x(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (_selectedIndex == 0) {
      Navigator.of(context).pushReplacementNamed(Homepage.routeName);
    }
    if (_selectedIndex == 1) {
      Navigator.of(context)
          .pushReplacementNamed(ProductOverviewScreen.routeName);
    }
    if (_selectedIndex == 2) {
      Navigator.of(context).pushReplacementNamed(RestaurantsScreen.routeName);
    }
    if (_selectedIndex == 3) {
      Navigator.of(context).pushReplacementNamed(MoreScreen.routeName);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.deepOrange,
      unselectedItemColor: Colors.black,
      selectedFontSize: 15,
      unselectedFontSize: 15,
      type: BottomNavigationBarType.shifting,
      onTap: _x,
      items: const [
        BottomNavigationBarItem(label: "Home", icon: Icon(Icons.home)),
        BottomNavigationBarItem(label: "Products", icon: Icon(Icons.fastfood)),
        BottomNavigationBarItem(
            label: "Restaurants", icon: Icon(Icons.restaurant)),
        BottomNavigationBarItem(label: "More", icon: Icon(Icons.more_vert)),
      ],
    );
  }
}
