import 'package:customertest/providers/restuarants.dart';
import 'package:customertest/widgets/restaurant_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsGridview extends StatelessWidget {
  const RestaurantsGridview({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    final restData = Provider.of<Restaurants>(context);

    final restuarants = restData.items;

    return GridView.builder(
      
        padding: const EdgeInsets.all(10.0),
        itemCount: restuarants.length,
        itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
              value: restuarants[i],
              child: RestaurantItem(),
            ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ));
  }
}
