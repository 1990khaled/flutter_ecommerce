import 'package:flutter/material.dart';

import '../models/add_to_cart_model.dart';
import '../models/new_product.dart';
import '../models/news_modle.dart';
import '../models/product.dart';

class SpecialController with ChangeNotifier {
  Product product = Product(
      id: "1", title: "title", price: 1.1, imgUrl: "imgUrl", qunInCarton: 1);
  NewProduct newProduct = NewProduct(
      id: "id", title: "title", price: 1.1, imgUrl: "imgUrl", qunInCarton: 1);
  NewsModel newsModel =
      NewsModel(id: "id", title: "title", imgUrl: "imgUrl", url: "url");

  AddToCartModel cartModel = AddToCartModel(id:"id" ,imgUrl:"imgUrl" , price:1.5 , productId:"productId" , title:"title" , qunInCarton:1 , collectionPath: "collectionPath", quantity:1 );
}

class LocalQuant extends ChangeNotifier {
  int _count = 1;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    if (_count > 1) {
      _count--;
      notifyListeners();
    }
  }
}
