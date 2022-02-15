import 'package:customertest/providers/cart.dart';
import 'package:customertest/providers/products.dart';
import 'package:customertest/providers/restuarant.dart';
import 'package:customertest/widgets/badge.dart';
import 'package:customertest/widgets/rest_products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'cart_screen.dart';

class RestuarantDetailScreen extends StatefulWidget {
  static const routeName = '/RestuarantDetailScreen';
  const RestuarantDetailScreen({Key key}) : super(key: key);

  @override
  _RestuarantDetailScreen createState() => _RestuarantDetailScreen();
}

class _RestuarantDetailScreen extends State<RestuarantDetailScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Restaurant;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetResProducts(args.id)
        .then(
          (_) => setState(
            () => _isLoading = false,
          ),
        )
        .catchError((error) => _isLoading = false);

    var _key = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _key,
      appBar: AppBar(
        centerTitle: true,
        title: Text(args.name),
        /*automaticallyImplyLeading: false,
        leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => Navigator.of(context).popAndPushNamed(RestaurantsScreen.routeName),),*/
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () =>
                  Navigator.of(context).pushNamed(CartScreen.routeName),
            ),
            builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
                color: Colors.black),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          :
          //Text(args.id ),
          RestProductsGrid(),
      /*Container(
        width: double.infinity,
        height: 300,
        child: SingleChildScrollView(
         child: Column(
          children : [
           //Image.network(
             //args.imageUrl ,fit: BoxFit.fitWidth, ),
            ProductsGrid(false),
            //Text(args.name),

          ],
        ),
        ),
*/
    );
  }
}
