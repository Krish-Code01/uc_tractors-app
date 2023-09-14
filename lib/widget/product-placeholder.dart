import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProductPlaceholder extends StatelessWidget {
  const ProductPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Shimmer.fromColors(
          baseColor: (Colors.grey[300])!,
          highlightColor: (Colors.grey[100])!,
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 4.55),
            margin: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
          ),
        ),
        Shimmer.fromColors(
          baseColor: (Colors.grey[300])!,
          highlightColor: (Colors.grey[100])!,
          child: Container(
            padding: EdgeInsets.all(MediaQuery.of(context).size.width / 4.55),
            margin: EdgeInsets.all(10),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(),
            ),
          ),
        ),
      ],
    );
  }
}
