import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:uc_tractors/provider/products.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});
  static const routeName = "/filter-screen";

  @override
  State<FilterScreen> createState() => _FilerScreenState();
}

class _FilerScreenState extends State<FilterScreen> {
  List<String> _tyre = [
    "0-20%",
    "20-40%",
    "40-60%",
    "60-80%",
    "80-100%",
  ];
  List<String> _model = [
    "Less than 2 yr",
    "Less than 5 yr",
    "Less than 10 yr",
    "Less than 20 yr"
  ];
  List<String> _condition = [
    "Excellent",
    "Like New",
    "Perfect",
    "Good",
    "Poor",
  ];

  @override
  Widget build(BuildContext context) {
    var filters = Provider.of<Products>(context).filterList;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Select the filters",
          style: GoogleFonts.lilitaOne(
            textStyle: TextStyle(color: Colors.black),
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              "Close",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Tyre',
              style: GoogleFonts.breeSerif(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Wrap(
              spacing: 5.0,
              children: _tyre.map((tyre) {
                return FilterChip(
                  label: Text(tyre),
                  selected: filters["tyre"]!.contains(tyre),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filters["tyre"]!.add(tyre);
                      } else {
                        filters["tyre"]!.remove(tyre);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Model',
              style: GoogleFonts.breeSerif(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Wrap(
              spacing: 5.0,
              children: _model.map((model) {
                return FilterChip(
                  label: Text(model),
                  selected: filters["model"]!.contains(model),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filters["model"]!.add(model);
                      } else {
                        filters["model"]!.remove(model);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 10.0),
            Text(
              'Condition',
              style: GoogleFonts.breeSerif(
                textStyle: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            Wrap(
              spacing: 5.0,
              children: _condition.map((condition) {
                return FilterChip(
                  label: Text(condition),
                  selected: filters["condition"]!.contains(condition),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        filters["condition"]!.add(condition);
                      } else {
                        filters["condition"]!.remove(condition);
                      }
                    });
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
