import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uc_tractors/provider/banner.dart';
import 'package:uc_tractors/provider/company.dart';
import 'package:uc_tractors/provider/images.dart';

class ProductItems {
  final String id;
  final CompanyItems company;
  final String name;
  final String tyre;
  final String condition;
  final String model;
  final String price;
  final bool isFeatured;
  final List<ImageItems> images;

  ProductItems({
    required this.id,
    required this.company,
    required this.name,
    required this.tyre,
    required this.condition,
    required this.model,
    required this.price,
    required this.isFeatured,
    required this.images,
  });
}

class Products with ChangeNotifier {
  List<ProductItems> _tractors = [];

  var filterList = {
    "company": [],
    "tyre": [],
    "model": [],
    "condition": [],
  };
  bool isSelected = true;

  void toggle() {
    isSelected = !isSelected;
  }

  bool isLoading = true;

  void toggleLoading() {
    isLoading = !isLoading;
  }

  int extractFirstNumberFromString(String input) {
    RegExp regExp = RegExp(r'\d+');
    Match? match = regExp.firstMatch(input);
    if (match != null) {
      String matchedNumber = match.group(0)!;
      int number = int.parse(matchedNumber);
      return number;
    } else {
      throw FormatException("No number found in the string");
    }
  }

  List<ProductItems> get tractor {
    List<ProductItems> filteredTractors = _tractors.where((tractor) {
      bool companyMatch = filterList["company"]!.isEmpty ||
          filterList["company"]!.contains(tractor.company.name);

      bool conditionMatch = filterList["tyre"]!.isEmpty ||
          filterList["tyre"]!.contains(tractor.tyre);

      bool modelMatch = filterList["model"]!.isEmpty ||
          filterList["model"]!.contains(tractor.model);

      bool conditionFilterMatch = filterList["condition"]!.isEmpty ||
          filterList["condition"]!.contains(tractor.condition);

      return conditionMatch &&
          modelMatch &&
          conditionFilterMatch &&
          companyMatch;
    }).toList();
    return [...filteredTractors];
  }

  ProductItems findById(String id) {
    return _tractors.firstWhere((tractor) => tractor.id == id);
  }

  Future<void> fetchProducts() async {
    var urlProduct = Uri.parse(
        "https://uc-tractors-admin.vercel.app/api/8e1df19e-0749-46df-bdfa-303f99ff02c6/products");
    var urlBanner = Uri.parse(
        "https://uc-tractors-admin.vercel.app/api/8e1df19e-0749-46df-bdfa-303f99ff02c6/banners");
    try {
      final productResponse = await http.get(urlProduct);
      final bannerResponse = await http.get(urlBanner);

      final extractedBanners = json.decode(bannerResponse.body);
      final extractedProducts = json.decode(productResponse.body);

      final List<ProductItems> loadedProducts = [];
      extractedProducts.forEach((prodData) {
        List loadedImages = prodData["images"];
        List<ImageItems> imageData = [];
        loadedImages.forEach((image) {
          imageData.add(ImageItems(id: image["id"], url: image["url"]));
        });
        final bannerData = extractedBanners.firstWhere(
            (banner) => banner["id"] == prodData["company"]["bannerId"]);

        loadedProducts.add(ProductItems(
          id: prodData["id"],
          company: CompanyItems(
            id: prodData["company"]["id"],
            name: prodData["company"]["name"],
            banner: BannerItems(
              id: prodData["company"]["bannerId"],
              label: bannerData["label"],
              imageUrl: bannerData["imageUrl"],
            ),
          ),
          name: prodData["name"],
          tyre: prodData["tyre"],
          condition: prodData["condition"],
          model: prodData["model"],
          price: prodData["price"],
          isFeatured: prodData["isFeatured"],
          images: imageData,
        ));
      });
      _tractors = loadedProducts;
      isLoading = false;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
