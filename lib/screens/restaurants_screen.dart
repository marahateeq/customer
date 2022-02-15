import 'package:customertest/providers/cart.dart';
import 'package:customertest/providers/restuarant.dart';
import 'package:customertest/providers/restuarants.dart';
import 'package:customertest/widgets/badge.dart';
import 'package:customertest/widgets/custom_navbar.dart';
import 'package:customertest/widgets/restaurants_gridview.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RestaurantsScreen extends StatefulWidget {
  static const routeName = '/RestaurantsScreen';
  const RestaurantsScreen({Key key}) : super(key: key);

  @override
  _RestaurantsScreenState createState() => _RestaurantsScreenState();
}

class _RestaurantsScreenState extends State<RestaurantsScreen> {
  var _isLoading = false;

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    Provider.of<Restaurants>(context, listen: false)
        .fetchAndSetRestaurants()
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
        title: const Text("Restaurants"),
        leading: IconButton(
          icon: const Icon(Icons.search),
          onPressed: () async {
            showSearch(context: context, delegate: DataSearch());
          },
        ),
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () => Navigator.of(context).pushNamed('CartScreen'),
            ),
            builder: (_, cart, ch) => Badge(
                child: ch,
                value: cart.itemCount.toString(),
                color: Colors.black),
          ),
        ],
      ),
      bottomNavigationBar: const CustomNavBar(),
      body: const RestaurantsGridview(),
    );
  }
}

class DataSearch extends SearchDelegate {
  List list = [];
  List filternames = [];
  String result = '';
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
  Widget buildSuggestions(BuildContext context) {
    //var searchlist1 = query.isEmpty ? list :list.where((p) => p.startsWith(query)).toList() ;

    filternames =
        list.where((element) => element.contains(query)).toList(); //startsWith
    return ListView.builder(
        itemCount: query == "" ? list.length : filternames.length,
        itemBuilder: (context, i) {
          return InkWell(
              onTap: () {
                query = query == "" ? list[i] : filternames[i];
                //showResults(context);
                result = filternames[i];

                //Navigator.of(context).pushNamed("RestaurantItem");
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

  @override
  Widget buildResults(BuildContext context) {
    final restaurant =
        Provider.of<Restaurants>(context, listen: false).findByName(result);

    return Container(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: GridTile(
          child: GestureDetector(
            onTap: () =>
                Navigator.of(context).pushNamed('RestuarantDetailScreen',
                    arguments: Restaurant(
                      name: result,
                      id: restaurant.id,
                      imageUrl: restaurant.imageUrl,
                      address: restaurant.address,
                    )),
            child: Hero(
              tag: restaurant.id,
              child: FadeInImage(
                placeholder: NetworkImage(restaurant
                    .imageUrl), // AssetImage('assets/images/laoding.png'),
                image: NetworkImage(restaurant.imageUrl),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          footer: const GridTileBar(
            backgroundColor: Colors.black87,
          ),
        ),
      ),
    );
  }
}
