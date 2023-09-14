import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uc_tractors/provider/cart.dart';
import 'package:uc_tractors/provider/company.dart';
import 'package:uc_tractors/provider/products.dart';
import 'package:uc_tractors/screen/cart-screen.dart';
import 'package:uc_tractors/screen/filter-screen.dart';
import 'package:uc_tractors/screen/home-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Products(),
        ),
        ChangeNotifierProvider.value(
          value: Companies(),
        ),
        ChangeNotifierProvider(
          create: (context) => Cart(),
        ),
      ],
      child: MaterialApp(
        title: 'UC Tractors',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: Colors.white,
            secondary: Colors.black,
            // or from RGB
          ),
        ),
        home: HomeScreen(key: key),
        routes: {
          CartScreen.routeName: (ctx) => CartScreen(),
          FilterScreen.routeName: (ctx) => FilterScreen(),
        },
      ),
    );
  }
}
