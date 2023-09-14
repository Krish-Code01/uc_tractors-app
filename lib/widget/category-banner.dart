import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_shadow/simple_shadow.dart';

import '../provider/company.dart';

class CategoryBanner extends StatelessWidget {
  const CategoryBanner({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<Companies>(context).fetchCompanies();
    List<CompanyItems> companyData = Provider.of<Companies>(context).company;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: SimpleShadow(
          child: Image.network(
            "https://i.postimg.cc/9MgV2Ddx/Premium-Tractors.gif",
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
