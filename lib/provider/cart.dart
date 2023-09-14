import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartItem {
  final String id;
  final String title;
  final String price;
  final String imageUrl;

  CartItem({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
  });
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'],
      title: map['title'],
      price: map['price'],
      imageUrl: map['imageUrl'],
    );
  }
}

class Cart with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items {
    return [..._items];
  }

  var nullCartItem = CartItem(
    id: '',
    title: '',
    price: '',
    imageUrl: '',
  );

  Cart() {
    // Initialize the cart by loading data from shared preferences
    _loadCartData();
  }
  void _saveCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartData = _items.map((item) => item.toMap()).toList();
    await prefs.setString('cartData', json.encode(cartData));
  }

  void _loadCartData() async {
    final prefs = await SharedPreferences.getInstance();
    final cartDataString = prefs.getString('cartData');
    if (cartDataString != null) {
      final cartData = json.decode(cartDataString) as List<dynamic>;
      _items = cartData.map((data) => CartItem.fromMap(data)).toList()
          as List<CartItem>;
      notifyListeners();
    }
  }

  CartItem findById(String id) {
    return _items.firstWhere(
      (item) => item.id == id,
    );
  }

  bool isPresent(String productId) {
    final foundItem = _items.firstWhere(
      (item) =>
          item.id == productId, // Assuming product ID matches the CartItem ID
      orElse: () => nullCartItem,
    );
    return foundItem != nullCartItem;
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    var total = 0.0;
    _items.forEach((cartItem) {
      total += double.parse(cartItem.price);
    });
    return total;
  }

  void addItem(
    String productId,
    String price,
    String title,
    String imageUrl,
  ) {
    if (isPresent(productId)) {
      return;
    } else {
      _items.add(CartItem(
        id: productId,
        title: title,
        price: price,
        imageUrl: imageUrl,
      ));
    }
    notifyListeners();
    _saveCartData();
  }

  void removeItem(String productId) {
    CartItem tractor = findById(productId);
    _items.remove(tractor);
    notifyListeners();
    _saveCartData();
  }

  void clear() {
    _items = [];
    notifyListeners();
    _saveCartData();
  }
}
