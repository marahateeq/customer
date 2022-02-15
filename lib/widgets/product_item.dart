import 'dart:convert';

import 'package:customertest/providers/auth.dart';
import 'package:customertest/screens/product_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';

class ProductItem extends StatelessWidget {
  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);
    final authData = Provider.of<Auth>(context, listen: false);
    //final rest = Provider.of<Restaurants>(context , listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context).pushNamed(
              ProductDetailScreen.routeName,
              arguments: Product(
                  imageUrl: product.imageUrl,
                  description: product.description,
                  title: product.title,
                  price: product.price,
                  id: product.id)),
          child: Hero(
            tag: product.id,
            child: FadeInImage(
              placeholder: imageFromBase64String(product.imageUrl).image,
              image: imageFromBase64String(product.imageUrl).image,
              fit: BoxFit.fill,
            ),
          ),
        ),
        footer: GridTileBar(
          //key: ,
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (ctx, product, _) => IconButton(
              iconSize: 20,
              icon: Icon(
                  product.isFavorite ? Icons.favorite : Icons.favorite_border),
              color: Colors.deepOrange,
              onPressed: () async {
                await product.toggleFavoriteStatus(
                    authData.token, authData.userID);
              },
            ),
          ),
          title: Text(
            product.title,
            textAlign: TextAlign.center,
          ),
          subtitle: const Text(''), //${rest.findById(product.id)}
          trailing: Text(
            '${product.price}₪',
            style: const TextStyle(color: Colors.deepOrange),
          ),
          /*IconButton(
            iconSize: 20,
            icon : Icon(Icons.shopping_cart),
            color: Theme.of(context).accentColor,
            onPressed: (){
              cart.addItem(product.id, product.price, product.title);
              Scaffold.of(context).hideCurrentSnackBar();
              Scaffold.of(context).showSnackBar(SnackBar(
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
        ),
      ),
    );
  }
}
