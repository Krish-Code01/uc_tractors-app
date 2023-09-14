import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uc_tractors/provider/banner.dart';
import 'package:http/http.dart' as http;

class CompanyItems {
  final String id;
  final String name;
  final BannerItems banner;

  CompanyItems({
    required this.id,
    required this.name,
    required this.banner,
  });
}

class Companies with ChangeNotifier {
  List<CompanyItems> _companies = [];

  List<CompanyItems> get company {
    return [..._companies];
  }

  bool isLoading = true;

  CompanyItems findById(String id) {
    return _companies.firstWhere((tractor) => tractor.id == id);
  }

  Future<void> fetchCompanies() async {
    var urlCompany = Uri.parse(
        "https://uc-tractors-admin.vercel.app/api/8e1df19e-0749-46df-bdfa-303f99ff02c6/companies");
    var urlBanner = Uri.parse(
        "https://uc-tractors-admin.vercel.app/api/8e1df19e-0749-46df-bdfa-303f99ff02c6/banners");
    try {
      final companyResponse = await http.get(urlCompany);
      final bannerResponse = await http.get(urlBanner);

      List extractedBanners = json.decode(bannerResponse.body);
      List extractedCompanies = json.decode(companyResponse.body);

      if (extractedBanners == null || extractedCompanies == null) {
        return;
      }

      final List<CompanyItems> loadedCompanies = [];
      extractedCompanies.forEach((companyData) {
        final bannerData = extractedBanners
            .firstWhere((banner) => banner["id"] == companyData["bannerId"]);

        loadedCompanies.add(
          CompanyItems(
            id: companyData["id"],
            name: companyData["name"],
            banner: BannerItems(
              id: bannerData["id"],
              label: bannerData["label"],
              imageUrl: bannerData["imageUrl"],
            ),
          ),
        );
      });
      _companies = loadedCompanies;
      isLoading = false;
      notifyListeners();
    } catch (error) {
      throw (error);
    }
  }
}
