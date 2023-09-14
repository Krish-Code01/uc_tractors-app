import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:uc_tractors/provider/products.dart';
import 'package:uc_tractors/widget/dialog-box.dart';
import 'package:uc_tractors/widget/product-placeholder.dart';

import '../provider/cart.dart';

class ProductCard extends StatefulWidget {
  const ProductCard({super.key});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  Widget build(BuildContext context) {
    Provider.of<Products>(context).fetchProducts();
    final productList = Provider.of<Products>(context).tractor;
    String formatNumberAsINR(double amount) {
      var formatter = NumberFormat.currency(locale: 'en_IN', symbol: '₹');
      return formatter.format(amount);
    }

    var _isLoading = (Provider.of<Products>(context, listen: true).isLoading);
    return Flex(
      direction: Axis.horizontal,
      children: [
        Expanded(
          child: _isLoading
              ? Center(
                  child: ProductPlaceholder(),
                )
              : GridView(
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3 / 4.5,
                  ),
                  scrollDirection: Axis.vertical,
                  children: productList.map((product) {
                    return GestureDetector(
                      onTap: () => {},
                      child: Container(
                        padding: EdgeInsets.all(12),
                        margin: EdgeInsets.all(12),
                        height: 100,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: double.infinity,
                              child: Container(
                                height: 120,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    product.images[0].url,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  formatNumberAsINR(
                                    double.parse(product.price),
                                  ),
                                  style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: 12,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (context) {
                                                return ProductDetailBox(
                                                  id: product.id,
                                                );
                                              });
                                        },
                                        icon: Icon(Icons.tab,
                                            size: 25, color: Colors.grey[600]),
                                      ),
                                      SizedBox(width: 20),
                                      IconButton(
                                        onPressed: () {
                                          Provider.of<Cart>(context,
                                                  listen: false)
                                              .addItem(
                                            product.id,
                                            product.price,
                                            product.name,
                                            product.images[0].url,
                                          );
                                        },
                                        icon: Icon(Icons.shopping_cart,
                                            size: 25, color: Colors.grey[600]),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
        ),
      ],
    );
  }
}
