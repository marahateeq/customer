// ignore_for_file: unnecessary_string_escapes

import 'package:customertest/providers/auth.dart';
import 'package:customertest/providers/cart.dart';
import 'package:customertest/providers/orders.dart';
import 'package:customertest/providers/product.dart';
import 'package:customertest/providers/products.dart';
import 'package:customertest/providers/restuarants.dart';
import 'package:customertest/providers/user_info.dart';
import 'package:customertest/screens/Homepage.dart';
import 'package:customertest/screens/add_address.dart';
import 'package:customertest/screens/address.dart';
import 'package:customertest/screens/auth_sc.dart';
import 'package:customertest/screens/cart_screen.dart';
import 'package:customertest/screens/checkOut.dart';
import 'package:customertest/screens/delivery_info.dart';
import 'package:customertest/screens/more_screen.dart';
import 'package:customertest/screens/orders_screen.dart';
import 'package:customertest/screens/pages/get_start.dart';
import 'package:customertest/screens/product_detail_screen.dart';
import 'package:customertest/screens/product_overview_screen.dart';
import 'package:customertest/screens/profile.dart';
import 'package:customertest/screens/reserve_info.dart';
import 'package:customertest/screens/restaurant_detail_screen.dart';
import 'package:customertest/screens/restaurants_screen.dart';
import 'package:customertest/screens/splash_sc.dart';
import 'package:customertest/screens/user_information.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  //await init();

  runApp(Phoenix(child: const MyApp()));
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
        ChangeNotifierProvider.value(value: Cart()),
        ChangeNotifierProvider.value(
            value: Product(
                price: 0, id: '', imageUrl: '', description: '', title: '')),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(),
          update: (ctx, authValue, previousProducts) => previousProducts
            ..getData(
              authValue.token,
              authValue.userID,
              previousProducts?.items,
            ),
        ),
        ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders(),
            update: (ctx, authValue, previousOrders) => previousOrders
              ..getData(
                authValue.token,
                authValue.userID,
                previousOrders
                    ?.orders, // previousOrders==null? null : previousOrders.orders
              )),
        ChangeNotifierProxyProvider<Auth, Restaurants>(
            create: (_) => Restaurants(),
            update: (ctx, authValue, previousRestaurants) => previousRestaurants
              ..getData(
                authValue.token,
                authValue.userID,
                previousRestaurants?.items,
              )),
        ChangeNotifierProxyProvider<Auth, UserInfo>(
          create: (_) => UserInfo(),
          update: (ctx, authValue, previoususerinfos) => previoususerinfos
            ..getData(
              authValue.token,
              authValue.userID,
              previoususerinfos?.users,
            ),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: '',
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,

          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          home: auth.isAuth
              ? const Homepage()
              : FutureBuilder(
                  future: auth.tryAutoLogIn(),
                  builder: (BuildContext ctx, AsyncSnapshot snapshot) =>
                      snapshot.connectionState == ConnectionState.waiting
                          ? const SplashSC()
                          : const AuthSC()),
          //OrdersScreen(),
          routes: {
            AuthSC.routeName: (_) => const AuthSC(),
            Homepage.routeName: (_) => const Homepage(),
            ProductOverviewScreen.routeName: (_) =>
                const ProductOverviewScreen(),
            ProductDetailScreen.routeName: (_) => const ProductDetailScreen(),
            CartScreen.routeName: (context) => const CartScreen(),
            OrdersScreen.routeName: (context) => OrdersScreen(),
            RestaurantsScreen.routeName: (context) => const RestaurantsScreen(),
            RestuarantDetailScreen.routeName: (context) =>
                const RestuarantDetailScreen(),
            GetStarted.routeName: (context) => const GetStarted(),
            Profile.routeName: (context) => const Profile(),
            MoreScreen.routeName: (context) => MoreScreen(),
            DeliveryInfo.routeName: (context) => const DeliveryInfo(),
            ReservationInfo.routeName: (context) => const ReservationInfo(),
            Address.routeName: (context) => const Address(),
            AddAddress.routeName: (context) => const AddAddress(),
            UserInformation.routeName: (context) => const UserInformation(),
            CheckOut.routeName: (context) => const CheckOut(),
          },

          // retrun supportedLocale.first;
        ),
      ),
    );
  }
}
