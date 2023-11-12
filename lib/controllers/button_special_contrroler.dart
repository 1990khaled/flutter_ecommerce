import 'package:flutter/material.dart';
import '../models/new_product.dart';
import '../models/news_modle.dart';
import '../models/product.dart';

class SpecialController with ChangeNotifier {
  Product product = Product(id: "1", title: "title", price: 1.1, imgUrl: "imgUrl", qunInCarton: 1);
  NewProduct newProduct= NewProduct(id: "id", title: "title", price: 1.1, imgUrl: "imgUrl", qunInCarton: 1);
  NewsModel newsModel= NewsModel(id: "id", title: "title", imgUrl: "imgUrl", url: "url");

}
