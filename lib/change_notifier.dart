import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_api_call/productmodel.dart';

class Apicall extends ChangeNotifier {
  List<Product> shoppinglist = [];
  Future<List<Product>> getHttp() async {
    try {
      var response = await Dio().get('https://fakestoreapi.com/products');
      var store = response.data as List;
      print(store.toString());

      return store
          .map((item) => Product.fromJson(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      print(e);
      throw UnimplementedError();
    }
  }

  void addtoshop(Product pm) {
    shoppinglist.add(pm);
    notifyListeners();
  }
}
