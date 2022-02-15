import 'package:customertest/providers/products.dart';
import 'package:customertest/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductsGrid extends StatelessWidget {
  final bool showFavs;

  const ProductsGrid(this.showFavs);

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);

    final products = showFavs ? productData.favoriteitems : productData.items;

    return products.isEmpty
        ? const Center(child: Text("There is no products! "))
        : GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: products.length,
            itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
                  value: products[i],
                  child: ProductItem(),
                ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ));
  }
}
