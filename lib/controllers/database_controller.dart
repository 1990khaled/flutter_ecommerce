import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/models/delivery_method.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

import '../models/favourite_modle.dart';
import '../models/new_product.dart';
import '../models/news_modle.dart';
import '../models/user_modle.dart';

abstract class Database {
  Stream<List<NewsModel>> newsStream();
  Stream<List<UserModle>> profileInfoStream();
  Stream<List<Product>> salesProductsStream();
  Stream<List<NewProduct>> newProductsStream();
  Stream<List<FavouriteModel>> myFavouriteStream();
  Stream<bool> isItemInFavourite(String productId);
  Stream<List<AddToCartModel>> myProductsCart();
  Stream<bool> isItemInCart(String productId);
  Stream<List<DeliveryMethod>> deliveryMethodsStream();
  Stream<List<ShippingAddress>> getShippingAddresses();
  Future<void> setUserData(UserData userData);
  Future<void> addProduct(Product product);
  Future<void> addNewProduct(NewProduct product);
  Future<void> addNews(NewsModel product);
  Future<void> addToCart(AddToCartModel product);
  // Future<void> updateData(Map<String, dynamic> data, String path );
  Future<void> removeFromCart(AddToCartModel product);
  Future<void> addToFavourite(FavouriteModel product);
  Future<void> removeFromFavourite(FavouriteModel product);
  Future<void> saveAddress(ShippingAddress address);
  Future<void> updateQuantityInCart(AddToCartModel product, int newQuantity);
  Future<void> updateNews(NewsModel newsModel);
}

class FirestoreDatabase implements Database {
  final String uid;
  final _service = FirestoreServices.instance;
  FirestoreDatabase(this.uid);

  @override
  Stream<List<NewsModel>> newsStream() => _service.collectionsStream(
        path: ApiPath.newsStream(),
        builder: (data, documentId) => NewsModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<Product>> salesProductsStream() => _service.collectionsStream(
        path: ApiPath.products(),
        builder: (data, documentId) => Product.fromMap(data!, documentId),
      );

  @override
  Stream<List<NewProduct>> newProductsStream() => _service.collectionsStream(
        path: ApiPath.newProduct(),
        builder: (data, documentId) => NewProduct.fromMap(data!, documentId),
      );

  @override
  Stream<List<UserModle>> profileInfoStream() => _service.collectionsStream(
        path: ApiPath.profileInfo(uid),
        builder: (data, documentId) => UserModle.fromMap(data!, documentId),
      );

  //-------------------------------------------------------------
  @override
  Future<void> saveAddress(ShippingAddress address) => _service.setData(
        path: ApiPath.newAddress(
          uid,
          address.id,
        ),
        data: address.toMap(),
      );

  @override
  Future<void> setUserData(UserData userData) async => await _service.setData(
        path: ApiPath.user(userData.uid),
        data: userData.toMap(),
      );

  @override
  Future<void> addProduct(Product product) async => _service.setData(
        path: ApiPath.products(),
        data: product.toMap(),
      );
  @override
  Future<void> addNewProduct(NewProduct product) async => _service.setData(
        path: ApiPath.newProduct(),
        data: product.toMap(),
      );

  @override
  Future<void> addNews(NewsModel product) async => _service.setData(
        path: ApiPath.newsStream(),
        data: product.toMap(),
      );

  @override
  Future<void> addToFavourite(FavouriteModel product) async => _service.setData(
        path: ApiPath.addToFavourite(uid, product.id),
        data: product.toMap(),
      );

  @override
  Future<void> removeFromFavourite(FavouriteModel product) async =>
      _service.deleteData(
        path: ApiPath.addToFavourite(uid, product.id),
      );

  @override
  Stream<List<FavouriteModel>> myFavouriteStream() =>
      _service.collectionsStream(
        path: ApiPath.myFavourite(uid),
        builder: (data, documentId) =>
            FavouriteModel.fromMap(data!, documentId),
      );

  @override
  Stream<bool> isItemInFavourite(String productId) {
    return myFavouriteStream().map(
      (cartItems) => cartItems.any((item) => item.title == productId),
    );
  }

//-----------------------------------------------------------------------
  @override
  Future<void> addToCart(AddToCartModel product) async => _service.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: product.toMap(),
      );
  @override
  Future<void> removeFromCart(AddToCartModel product) async =>
      _service.deleteData(
        path: ApiPath.addToCart(uid, product.id),
      );

  @override
  Stream<List<AddToCartModel>> myProductsCart() => _service.collectionsStream(
        path: ApiPath.myProductsCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );

  @override
  Stream<bool> isItemInCart(String productId) {
    return myProductsCart().map(
      (cartItems) => cartItems.any((item) => item.title == productId),
    );
  }

  //---------------------------------------------------------------

  @override
  Stream<List<DeliveryMethod>> deliveryMethodsStream() =>
      _service.collectionsStream(
          path: ApiPath.deliveryMethods(),
          builder: (data, documentId) =>
              DeliveryMethod.fromMap(data!, documentId));

  @override
  Stream<List<ShippingAddress>> getShippingAddresses() =>
      _service.collectionsStream(
        path: ApiPath.userShippingAddress(uid),
        builder: (data, documentId) =>
            ShippingAddress.fromMap(data!, documentId),
      );
//-------------------------------------------------------------------------------------
  @override
  Future<void> updateQuantityInCart(
      AddToCartModel product, int newQuantity) async {
    // Extract the existing data from Firebase
    final existingData = await FirestoreServices.instance
        .getData(path: ApiPath.addToCart(uid, product.id));

    if (existingData != null) {
      // Update only the quantity field
      existingData['quantity'] = newQuantity;

      // Update the data with the modified quantity
      await FirestoreServices.instance.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: existingData,
      );
    } else {
      // Handle the case where the document doesn't exist
      print('Document does not exist!');
    }
  }

  //--------------------------------------------

  @override
  Future<void> updateNews(NewsModel newsModel) async {
    try {
      // Fetch the existing data from Firestore
      final existingData = await FirestoreServices.instance
          .getData(path: "news/${newsModel.id}");

      if (existingData != null) {
        // Update logic: Replace existing fields with provided data if available
        final Map<String, dynamic> updatedData = {
          if (newsModel.title != null) 'title': newsModel.title,
          if (newsModel.imgUrl != null) 'imgUrl': newsModel.imgUrl,
          if (newsModel.url != null) 'url': newsModel.url,
          // Add other fields you want to update similarly
        };

        // Merge updatedData with existingData to keep the old data intact
        final mergedData = {...existingData, ...updatedData};

        // Check if any update was made, then update the Firestore document
        if (mergedData.isNotEmpty) {
          await FirestoreServices.instance.setData(
            path: "news/${newsModel.id}",
            data: mergedData,
          );
          // Successful update, log a message
          debugPrint("News updated successfully!");
        } else {
          // No updates provided in newsModel
          debugPrint("No updates provided for ID: ${newsModel.id}");
        }
      } else {
        // Document doesn't exist
        debugPrint("Document does not exist for ID: ${newsModel.id}");
      }
    } catch (e) {
      // Firestore operation error
      debugPrint("Firestore Error: $e");
      throw e; // Propagate the error further if needed
    }
  }
}
