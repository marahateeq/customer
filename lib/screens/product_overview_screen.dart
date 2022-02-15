import 'package:customertest/widgets/badge.dart';
import 'package:customertest/widgets/custom_navbar.dart';
import 'package:customertest/widgets/products_grid.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart';
import '../providers/products.dart';
import 'cart_screen.dart';

enum FilterOption { Favorites, All }

class ProductOverviewScreen extends StatefulWidget {
  const ProductOverviewScreen({Key key}) : super(key: key);
  static const routeName = '/prodview';
  @override
  _ProductOverviewScreen createState() => _ProductOverviewScreen();
}

class _ProductOverviewScreen extends State<ProductOverviewScreen> {
  var _isLoading = false;
  var _showOnlyFavorites = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .then(
          (_) => setState(
            () => _isLoading = false,
          ),
        )
        .catchError((error) => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    var _key = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: const Text("Products"),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            showSearch(context: context, delegate: DataSearch());
          },
        ),
        actions: [
          PopupMenuButton(
            onSelected: (FilterOption selectedVal) {
              setState(() {
                if (selectedVal == FilterOption.Favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            icon: const Icon(Icons.more_vert),
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text("Only Favorites"),
                value: FilterOption.Favorites,
              ),
              const PopupMenuItem(
                child: Text("Show All"),
                value: FilterOption.All,
              ),
            ],
          ),
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
      bottomNavigationBar: const CustomNavBar(),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}

class DataSearch extends SearchDelegate {
  List list = [];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Scaffold(
        // body:
        //Navigator.of(context).pushReplacementNamed("restaurants")

        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    //var searchlist1 = query.isEmpty ? list :list.where((p) => p.startsWith(query)).toList() ;

    List filternames =
        list.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
        itemCount: query == "" ? list.length : filternames.length,
        itemBuilder: (context, i) {
          return InkWell(
              onTap: () {
                query = query == "" ? list[i] : filternames[i];
                //showResults(context);
                Navigator.of(context).pushReplacementNamed("restaurants");
              },
              child: ListTile(
                  leading: const Icon(Icons.restaurant),
                  title: query == ""
                      ? Text(
                          "${list[i]}",
                          style: const TextStyle(fontSize: 25),
                        )
                      : Text(
                          "${filternames[i]}",
                          style: const TextStyle(fontSize: 25),
                        )));
        });
  }
}
