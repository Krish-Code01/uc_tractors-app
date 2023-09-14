import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';
import 'package:uc_tractors/provider/company.dart';
import 'package:uc_tractors/widget/category-placeholder.dart';
import 'package:uc_tractors/widget/product-card.dart';
import 'package:uc_tractors/widget/product-placeholder.dart';

import '../provider/products.dart';

class CategoryCard extends StatefulWidget {
  const CategoryCard({
    Key? key,
  }) : super(key: key);

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final companiesProvider = Provider.of<Companies>(context);
    productsProvider.fetchProducts();

    final companyData = companiesProvider.company;
    final filters = productsProvider.filterList;
    final _isSelected = productsProvider.isSelected;
    final _isLoading = companiesProvider.isLoading;
    return SizedBox(
      height: MediaQuery.of(context).size.width / 4,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        children: companyData.map((company) {
          return _isLoading
              ? ProductPlaceholder()
              : Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Provider.of<Products>(context, listen: false).toggle();
                        await Provider.of<Products>(context, listen: false)
                            .fetchProducts();
                        setState(() {
                          if (_isSelected) {
                            filters["company"]!.add(company.name);
                          } else {
                            filters["company"]!.remove(company.name);
                          }
                        });
                        Provider.of<Products>(context, listen: false)
                            .toggleLoading();
                      },
                      child: Container(
                        padding: EdgeInsets.all(10),
                        child: Container(
                          width: MediaQuery.of(context).size.width / 3.2,
                          height: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color.fromARGB(255, 85, 214, 90),
                          ),
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 10,
                              right: 10,
                              left: 10,
                              bottom: 5,
                            ),
                            child: Text(
                              company.name,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width / 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: SimpleShadow(
                          child: Image.network(
                            company.banner.imageUrl,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                );
        }).toList(),
      ),
    );
  }
}
