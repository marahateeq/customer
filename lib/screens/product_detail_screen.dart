import 'package:customertest/providers/cart.dart';
import 'package:customertest/providers/product.dart';
import 'package:customertest/widgets/badge.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'cart_screen.dart';

class ProductDetailScreen extends StatefulWidget {
  static const routeName = '/ProductDetailScreen';

  const ProductDetailScreen({Key key}) : super(key: key);

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _qty = 0;
  String q = '0';

  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<ScaffoldState>();

    final dS = MediaQuery.of(context).size;

    final prod = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    final product = ModalRoute.of(context).settings.arguments as Product;
    //_qty = cart.getCountByItem(product.);
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text(product.title),
        centerTitle: true,
        automaticallyImplyLeading: false,
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
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              //title: Text(args.title),
              background: Hero(
                tag: product.id,
                child: Image.network(
                  product.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverList(
              delegate: SliverChildListDelegate(
            [
              const SizedBox(
                height: 10,
              ),
              Row(children: [
                Text(
                  product.title,
                  style: const TextStyle(fontSize: 25, color: Colors.black),
                ),
                SizedBox(
                  width: (dS.width) * 0.30,
                ),
                Text(
                  "${product.price}₪",
                  textAlign: TextAlign.right,
                  style:
                      const TextStyle(fontSize: 25, color: Colors.deepOrange),
                ),
                /*IconButton(
                iconSize: 30,
                icon : Icon(Icons.shopping_cart_outlined),
                color:Colors.deepOrange,
                onPressed: (){
                  cart.addItem(product.id, product.price, product.title);
                  _key.currentState.hideCurrentSnackBar();
                  _key.currentState.showSnackBar(SnackBar(
                    content: Text("Added to cart!"),
                    duration: Duration(seconds: 5),
                    action: SnackBarAction(
                      label: "Undo",
                      onPressed: (){
                        cart.removeSingleItem(product.id);
                      },
                    ),
                  ),
                  );
                },
              ) ,*/
              ]),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[100],
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1))
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.minus,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              if (_qty != 0) {
                                _qty = _qty - 1;
                                q = _qty.toString();

                                cart.removeSingleItem(product.id);
                              }
                            });
                          })),
                  Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        q.toString(), //'${cart.itemCount}',
                        style: const TextStyle(
                            color: Colors.black, fontSize: 25.0),
                      )),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.red,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey[100],
                                spreadRadius: 1,
                                blurRadius: 1,
                                offset: const Offset(0, 1))
                          ],
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          icon: const FaIcon(
                            FontAwesomeIcons.plus,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              _qty = _qty + 1;
                              q = _qty.toString();
                              cart.addItem(
                                product.id,
                                product.price,
                                product.title,
                              );
                            });
                          })),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Card(
                //color: Colors.grey,
                //width: double.infinity,
                child: Column(
                  children: [
                    const Text(
                      'Description  ',
                      textAlign: TextAlign.left,
                      style: TextStyle(color: Colors.black, fontSize: 30),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      product.description,
                      textAlign: TextAlign.left,
                      softWrap: true,
                      style: const TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
