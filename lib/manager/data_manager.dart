import 'dart:convert';

import 'package:coffee_masters/models/product.dart';
import 'package:coffee_masters/models/cart.dart';
import 'package:coffee_masters/models/category.dart';
import 'package:http/http.dart' as http;

class DataManager {
  List<Category>? _menu;
  List<ItemInCart> cart = [];

  addToCart(Product product) {
    bool found = false;
    for (var item in cart) {
      if (item.product.id == product.id) {
        item.quantity++;
        found = true;
        break;
      }
    }
    if (!found) {
      cart.add(ItemInCart(product: product, quantity: 1));
    }
  }

  removeFromCart(Product product) {
    cart.removeWhere((element) => element.product.id == product.id);
  }

  clearCart() {
    cart.clear();
  }

  double cartTotal() {
    double total = 0;
    for (var item in cart) {
      total += item.quantity * item.product.price;
    }
    return total;
  }

  fetchMenu() async {
    try {
      const url = 'https://firtman.github.io/coffeemasters/api/menu.json';
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        _menu = [];
        var decodedData = jsonDecode(response.body) as List<dynamic>;
        for (var json in decodedData) {
          _menu?.add(Category.fromJson(json));
        }
      } else {
        throw Exception("Error loading data");
      }
    } catch (e) {
      throw Exception("Error loading data");
    }
  }

  Future<List<Category>> getMenu() async {
    if (_menu == null) {
      await fetchMenu();
    }
    return _menu!;
  }
}
