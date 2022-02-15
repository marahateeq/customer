import 'dart:convert';

import 'package:customertest/providers/restuarant.dart';
import 'package:customertest/screens/restaurant_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantItem extends StatelessWidget {
  //const RestaurantItem({Key? key}) : super(key: key);
  final _key = GlobalKey<ScaffoldState>();

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  @override
  Widget build(BuildContext context) {
    final restaurant = Provider.of<Restaurant>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        key: _key,
        child: GestureDetector(
          onTap: () =>
              Navigator.of(context).pushNamed(RestuarantDetailScreen.routeName,
                  arguments: Restaurant(
                    name: restaurant.name,
                    id: restaurant.id,
                    imageUrl: restaurant.imageUrl,
                    address: restaurant.address,
                  )),
          child: Hero(
            tag: restaurant.id,
            child: FadeInImage(
              placeholder: imageFromBase64String(restaurant.imageUrl)
                  .image, // AssetImage('assets/images/laoding.png'),
              image: imageFromBase64String(restaurant.imageUrl).image,
              fit: BoxFit.cover,
            ),
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          /*leading:  Consumer<Restaurant>(builder:
              (ctx , restuarant , _ ) =>
              IconButton(
                icon : Icon(Icons.favorite_border ),
                color: Theme.of(context).accentColor,
                onPressed: (){
                  //product.toggleFavoriteStatus(authData.token, authData.userId);

                },
              ) ,
          ),*/

          title: Text(
            restaurant.name,
            textAlign: TextAlign.center,
          ),
          /*trailing: IconButton(
            icon : Icon(Icons.restaurant),
            color: Theme.of(context).accentColor,
            onPressed: (){},
                ),*/
        ),
      ),
    );
  }
}
