import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:uc_tractors/widget/category-card.dart';

class CategoryPlaceholder extends StatelessWidget {
  const CategoryPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: (Colors.grey[300])!,
      highlightColor: (Colors.grey[100])!,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(100),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Color.fromARGB(255, 85, 214, 90),
        ),
      ),
    );
  }
}
