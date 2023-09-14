import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uc_tractors/screen/cart-screen.dart';
import 'package:uc_tractors/screen/filter-screen.dart';
import '../provider/cart.dart';
import '../widget/category-banner.dart';
import '../widget/category-card.dart';
import '../widget/product-card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var len = Provider.of<Cart>(context).itemCount;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Soil Health Monitoring System",
          style: GoogleFonts.lilitaOne(),
        ),
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushNamed(CartScreen.routeName);
            },
            icon: Icon(Icons.shopping_cart_outlined),
            label: Text("(${len})"),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.transparent,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          CategoryBanner(),
          CategoryCard(),
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pushNamed(FilterScreen.routeName);
              },
              icon: Image.network(
                "https://www.iconsdb.com/icons/preview/white/empty-filter-xxl.png",
                width: 20,
                height: 20,
              ),
              label: Text("Filter"),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.black,
                ),
              ),
            ),
          ),
          ProductCard(),
        ],
      ),
    );
  }
}
