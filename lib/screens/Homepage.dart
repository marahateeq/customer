import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:customertest/const/colors.dart';
import 'package:customertest/providers/auth.dart';
import 'package:customertest/providers/cart.dart';
import 'package:customertest/providers/products.dart';
import 'package:customertest/providers/restuarants.dart';
import 'package:customertest/screens/orders_screen.dart';
import 'package:customertest/screens/product_overview_screen.dart';
import 'package:customertest/screens/profile.dart';
import 'package:customertest/screens/restaurants_screen.dart';
import 'package:customertest/utils/helper.dart';
import 'package:customertest/widgets/badge.dart';
import 'package:customertest/widgets/custom_navbar.dart';
import 'package:customertest/widgets/searchbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_info.dart';
import 'cart_screen.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key key}) : super(key: key);
  static const routeName = '/homepage';

  @override
  _HomepageState createState() => _HomepageState();
  //callback when layout build done

}

class _HomepageState extends State<Homepage> {
  get kPrimaryColor => Colors.deepOrange;
  String uemail = 'Just Eat';

  bool _isLoading = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _isLoading = true;
    super.initState();

    // WidgetsFlutterBinding.ensureInitialized(_go());
    emver().then((value) async => await _go()).whenComplete(() {
      setState(() {
        _isLoading = false;
        print(i++);
      });
    });
    // emver();
    // _go();
  }

//new
  Future<void> emver() async {
    await Provider.of<UserInfo>(context, listen: false).getUinfo();

    await Provider.of<Auth>(context, listen: false).userData();
    bool v = Provider.of<Auth>(context, listen: false).emailverified;
    try {
      if (v == false) {
        AppLifecycleState.paused;
        AwesomeDialog(
          dismissOnBackKeyPress: false,
          dismissOnTouchOutside: false,
          context: context,
          animType: AnimType.SCALE,
          dialogType: DialogType.INFO,
          body: const Center(
            child: Text(
              'your email address not verified , Please check your email! ',
              style: TextStyle(fontStyle: FontStyle.italic),
            ),
          ),
          title: 'Verify',

          btnCancelOnPress: () async {
            Provider.of<Auth>(context, listen: false).logout();
          },
          btnOkColor: Colors.teal,
          btnCancelColor: Colors.red,
          btnCancelText: "Exit",
          //desc: 'This is also Ignored',
          btnOkText: "ReSend",
          btnOkOnPress: () async {
            await Provider.of<Auth>(context, listen: false).sendE().then(
                (value) async =>
                    await Provider.of<Auth>(context, listen: false).logout());
          },
        ).show();
      } else if (v == true) {
        AppLifecycleState.resumed;
      }
    } catch (e) {
      print("erorr while vervication");
      rethrow;
    }
  }

  Future<void> _go() async {
    await Provider.of<Restaurants>(context, listen: false)
        .fetchAndSetRestaurants();
    await Provider.of<Products>(context, listen: false)
        .fetchAndSetProducts()
        .whenComplete(() {
      _isLoading = false;
      return;
    }).catchError((error) {
      print("erroe while loading");
      _isLoading = false;
    });
  }

  Image imageFromBase64String(String base64String) {
    return Image.memory(base64Decode(base64String));
  }

  int i = 1;
  @override
  Widget build(BuildContext context) {
    // WidgetsFlutterBinding.ensureInitialized();

    // Future.delayed(Duration.zero, (() async => await _go()));

    // final emaild = Provider.of<Auth>(context, listen: false);
    // final uemail = emaild.emaildata;
    final productdata = Provider.of<Products>(context, listen: false);
    final listprod = productdata.items;

    final restdata = Provider.of<Restaurants>(context, listen: false);
    final listrest = restdata.items;
    Map m = Provider.of<UserInfo>(context, listen: false).data;
    String mn, ml, me;
    if (m == null) {
      mn = 'justeat';
      ml = "";
      me = "";
    } else {
      mn = m['fname'];
      ml = m['lname'];
      me = m['email'];
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        title: RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headline6,
            children: const [
              TextSpan(
                text: "JUST ",
                style: TextStyle(color: Colors.black, fontFamily: 'Quikhand'),
              ),
              TextSpan(
                text: "EAT",
                style: TextStyle(color: Colors.black, fontFamily: 'Quikhand'),
              ),
            ],
          ),
        ),
        backgroundColor: Colors.deepOrange,
        centerTitle:
            true, /* actions: [
    IconButton(icon: Icon(Icons.search),
    onPressed: () async {

    },

    ),


    ],*/
      ),
      bottomNavigationBar: const CustomNavBar(),
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                  foregroundImage:
                      Image.network("https://api.multiavatar.com/$mn.png")
                          .image,
                  backgroundColor: Colors.deepOrange),
              accountName: Text(" $mn $ml"),
              accountEmail: me == null ? const Text('') : Text(me),
            ),
            ListTile(
              title: const Text("Profile"),
              leading: const Icon(Icons.home),
              onTap: () {
                Navigator.of(context).pushNamed(Profile.routeName);
              },
            ),
            ListTile(
              title: const Text("Order history"),
              leading: const Icon(Icons.person),
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => OrdersScreen()));
              },
            ),
            ListTile(
              title: const Text("Logout"),
              leading: const Icon(Icons.exit_to_app),
              onTap: () {
                Provider.of<Auth>(context, listen: false).logout();
              },
            ),
          ],
        ),
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // ElevatedButton(
                      //     onPressed: () async {
                      //       // fun
                      //     },
                      //     child: const Text('change')),
                      const SizedBox(
                        height: 20,
                      ),
                      const SearchBar(
                        title: "Search",
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              CategoryCard(
                                image: Image.asset(
                                    "images/burger.png"), //hamburger2

                                name: "Burger",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CategoryCard(
                                image: Image.asset("images/pizza1.png"), //rice2

                                name: "Pizza",
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              CategoryCard(
                                image: Image.asset("images/salad.png"), //fruit

                                name: "Salad",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              CategoryCard(
                                image: Image.asset("images/drinks.png"), //rice

                                name: "Drinks",
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.only(
                          left: 20,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Restaurants",
                              style: Helper.getTheme(context).headline5,
                            ),
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context)
                                      .pushNamed(RestaurantsScreen.routeName);
                                },
                                child: const Text("View all")),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 200,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Card(
                                child: Image(
                                    image: imageFromBase64String(
                                            listrest[4].imageUrl)
                                        .image),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Card(
                                child: Image(
                                    image: imageFromBase64String(
                                            listrest[1].imageUrl)
                                        .image),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Card(
                                child: Image(
                                    image: imageFromBase64String(
                                            listrest[2].imageUrl)
                                        .image),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Popular Products",
                              style: Helper.getTheme(context).headline5,
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context)
                                    .pushNamed(ProductOverviewScreen.routeName);
                              },
                              child: const Text("View all"),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 400,
                        width: double.infinity,
                        padding: const EdgeInsets.only(left: 20),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              MostPopularCard(
                                image: Image(
                                  image: imageFromBase64String(
                                          listprod[1].imageUrl)
                                      .image,
                                ),
                                name: listprod[1].title,
                              ),
                              const SizedBox(
                                width: 30,
                              ),
                              MostPopularCard(
                                  name: listprod[2].title,
                                  image: Image(
                                      image: imageFromBase64String(
                                    listprod[2].imageUrl,
                                  ).image)),
                              const SizedBox(
                                width: 30,
                              ),
                              MostPopularCard(
                                  name: listprod[3].title,
                                  image: Image(
                                      image: imageFromBase64String(
                                    listprod[3].imageUrl,
                                  ).image)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      /*Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent Items",
                        style: Helper.getTheme(context).headline5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacementNamed(
                              RestaurantsScreen.routeName);
                        },
                        child: Text("View all"),
                      ),
                    ],
                  ),
                ),*/
                      /*Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          //  Navigator.of(context).pushNamed(IndividualItem.routeName);
                        },
                        child: RecentItemCard(
                          image: Image.asset(
                            "images/vector3.png",
                            fit: BoxFit.cover,
                          ),
                          name: "Mulberry Pizza by Josh",
                        ),
                      ),
                      RecentItemCard(
                          image: Image.asset(
                            "images/vector3.png",
                            fit: BoxFit.cover,
                          ),
                          name: "Barita"),
                      RecentItemCard(
                          image: Image.asset(
                            "images/vector3.png",
                            fit: BoxFit.cover,
                          ),
                          name: "Pizza Rush Hour"),
                    ],
                  ),
                ), */
                    ],
                  ),
                ),

                /*Positioned(
              bottom: 0,
              left: 0,
              child: CustomNavBar(
                home: true,
              )),*/
              ],
            ),
    );
  }
}

/*class RecentItemCard extends StatelessWidget {
  const RecentItemCard({
    Key key,
    @required String name,
    @required Image image,
  })  : _name = name,
        _image = image,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 80,
            height: 80,
            child: _image,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child: Container(
            // height: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _name,
                  style: Helper.getTheme(context)
                      .headline4
                      .copyWith(color: AppColor.primary),
                ),
                Row(
                  children: const [
                    Text("Cafe"),
                    SizedBox(
                      width: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Western Food"),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset("images/star_filled.png"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "4.9",
                      style: TextStyle(
                        color: AppColor.orange,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Text('(124) Ratings')
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}*/

class MostPopularCard extends StatelessWidget {
  const MostPopularCard({
    Key key,
    @required String name,
    @required Image image,
  })  : _name = name,
        _image = image,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 200,
            height: 150,
            child: _image,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _name,
          style: Helper.getTheme(context)
              .headline6
              .copyWith(color: AppColor.primary),
        ),
      ],
    );
  }
}

class RestaurantCard extends StatelessWidget {
  const RestaurantCard({
    Key key,
    @required String name,
    @required Image image,
  })  : _image = image,
        _name = name,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //height: 250,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 200, width: double.infinity, child: _image),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      _name,
                      style: Helper.getTheme(context).headline3,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    Image.asset("images/star_filled.png"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text(
                      "4.9",
                      style: TextStyle(
                        color: AppColor.orange,
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("(124 ratings)"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Cafe"),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        ".",
                        style: TextStyle(
                          color: AppColor.orange,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Text("Western Food"),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key key,
    @required Image image,
    @required String name,
  })  : _image = image,
        _name = name,
        super(key: key);

  final String _name;
  final Image _image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: SizedBox(
            width: 100,
            height: 100,
            child: _image,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          _name,
          style: Helper.getTheme(context)
              .headline4
              .copyWith(color: AppColor.primary, fontSize: 16),
        ),
      ],
    );
  }
}
