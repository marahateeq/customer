import 'package:customertest/providers/products.dart';
import 'package:customertest/widgets/product_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int i = 1;

class RestProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(i++);
    final productData = Provider.of<Products>(context, listen: false);

    final products = productData.items;

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
