import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/models/shipping_address.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import 'package:flutter_ecommerce/services/firestore_services.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';

import '../models/favourite_modle.dart';
import '../models/new_product.dart';
import '../models/news_modle.dart';
import '../models/orders_model.dart';

abstract class Database {
  Stream<List<NewsModel>> newsStream();
  Future<void> setUserInfo(UserModel userModel);
  Stream<List<Product>> salesProductsStream();
  Stream<List<NewProduct>> newProductsStream();
  Stream<List<FavouriteModel>> myFavouriteStream();
  Stream<bool> isItemInFavourite(String productId);
  Stream<List<AddToCartModel>> myProductsCart();
  Stream<List<OrdersModel>> myOrdersStream();
  Stream<List<UserModel>> getUserInformationStream();
  Stream<bool> isItemInCart(String productId);
  Future<void> setUserData(UserData userData);
  Future<void> addProduct(Product product);
  Future<void> addNewProduct(NewProduct product);
  Future<void> addNews(NewsModel product);
  Future<void> addToCart(AddToCartModel product);
  Future<void> removeFromCart(AddToCartModel product);
  Future<void> addToFavourite(FavouriteModel product);
  Future<void> removeFromFavourite(FavouriteModel product);
  Future<void> deleteOrder(OrdersModel product);
  Future<void> saveAddress(ShippingAddress address);
  Future<void> updateQuantityInCart(AddToCartModel product, int newQuantity);
  Future<void> updateNews(NewsModel newsModel);
  Future<void> updateNewProduct(NewProduct newProduct);
  Future<void> updateProduct(Product newProduct);
  Future<void> addToMyOrders(OrdersModel product, String orderId);
  Future<void> updateUserInformation(UserModel userModel);
  Future<UserModel?> getUserInformation();
  Future<void> clearCart(String uid);
  Future<void> deleteFromProduct(Product product);
  Future<void> deleteFromNewProduct(NewProduct product);
  Future<void> deleteFromNews(NewsModel news);
  // Future<String> getUserId(String uid);
  // Stream<List<OrdersModel>> userOrdersStream();
  // Future<void> addToUserOrders(OrdersModel product);
  // Stream<List<DeliveryMethod>> deliveryMethodsStream();
  // Stream<List<ShippingAddress>> getShippingAddresses();
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
  Future<void> setUserInfo(UserModel userModel) async => await _service.setData(
        path: ApiPath.getUserInformation(uid),
        data: userModel.toMap(),
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
  Future<void> deleteOrder(OrdersModel product) async => _service.deleteData(
        path: ApiPath.ordersCollection(product.id),
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

  @override
  Stream<List<UserModel>> getUserInformationStream() =>
      _service.collectionsStream(
        path: "users/$uid/profileInfo/",
        builder: (data, documentId) => UserModel.fromMap(data!, documentId),
      );
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

  @override
  Stream<List<OrdersModel>> myOrdersStream() => _service.collectionsStream(
        path: "orders",
        builder: (data, documentId) => OrdersModel.fromMap(data!, documentId),
      );

  @override
  Future<void> addToMyOrders(OrdersModel product, String orderId) async {
    try {
      final data = product.toMap();
      debugPrint('Adding order: $data');

      await _service.setData(
        path: ApiPath.ordersCollection(orderId),
        data: data,
      );

      debugPrint('Order added successfully!');
    } catch (e) {
      debugPrint('Error adding order: $e');
      // Handle error accordingly
      return;
    }
  }

  // @override
  // Stream<List<OrdersModel>> userOrdersStream() => _service.collectionsStream(
  //       path: ApiPath.userOrderData(uid),
  //       builder: (data, documentId) => OrdersModel.fromMap(data!, documentId),
  //     );

  // @override
  // Future<void> addToUserOrders(OrdersModel product) async => _service.setData(
  //       path: ApiPath.addOrderToUserData(uid, product.id),
  //       data: product.toMap(),
  //     );
  //---------------------------------------------------------------
  @override
  Future<void> deleteFromNews(NewsModel news) async => _service.deleteData(
        path: ApiPath.newsItem(news.id),
      );
  @override
  Future<void> deleteFromNewProduct(NewProduct product) async =>
      _service.deleteData(
        path: ApiPath.newProductItem(product.id),
      );
  @override
  Future<void> deleteFromProduct(Product product) async => _service.deleteData(
        path: ApiPath.productsItem(product.id),
      );

  // @override
  // Stream<List<DeliveryMethod>> deliveryMethodsStream() =>
  //     _service.collectionsStream(
  //         path: ApiPath.deliveryMethods(),
  //         builder: (data, documentId) =>
  //             DeliveryMethod.fromMap(data!, documentId));

  // @override
  // Stream<List<ShippingAddress>> getShippingAddresses() =>
  //     _service.collectionsStream(
  //       path: ApiPath.userShippingAddress(uid),
  //       builder: (data, documentId) =>
  //           ShippingAddress.fromMap(data!, documentId),
  // );
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
      return;
      // Handle the case where the document doesn't exist
      // print('Document does not exist!');
    }
  }

// --------------------------------------------
  // @override
  // Future<String> getUserId(String uid) async {
  //   uid = FirebaseAuth.instance.currentUser!.uid;
  //   return uid;
  // }
//----------------------------------------------------
  @override
  Future<UserModel?> getUserInformation() async {
    try {
      final collectionRef = FirestoreServices.instance.collectionReference(
        path: "users/$uid/profileInfo",
      );

      final collections = await collectionRef.get();

      if (collections.docs.isNotEmpty) {
        final userData = await FirestoreServices.instance.getData(
          path: ApiPath.getUserInformation(uid),
        );

        if (userData != null && userData.isNotEmpty) {
          return UserModel.fromMap(userData, ApiPath.getUserInformation(uid));
        } else {
          return null;
        }
      } else {
        return null;
      }
    } catch (e) {
      // debugPrint("Firestore Error: $e");
      rethrow;
    }
  }

//----------------------------------------------------------------------
  @override
  Future<void> updateUserInformation(UserModel userModel) async {
    try {
      // Fetch the existing data from Firestore
      final existingData = await FirestoreServices.instance.getData(
          path: ApiPath.userInformation(
        uid,
      ));

      if (existingData != null) {
        // Update logic: Replace existing fields with provided data if available
        final Map<String, dynamic> updatedData = {
          'address': userModel.address,
          'companyName': userModel.companyName,
        };

        final mergedData = {...existingData, ...updatedData};

        // Check if any update was made, then update the Firestore document
        if (mergedData.isNotEmpty) {
          await FirestoreServices.instance.setData(
            path: ApiPath.userInformation(uid),
            data: mergedData,
          );
          // // Successful update, log a message
          // debugPrint("News updated successfully!");
        } else {
          return;
          // // No updates provided in newsModel
          // debugPrint("No updates provided for ID: ${userModel.id}");
        }
      } else {
        return;
        // // Document doesn't exist
        // debugPrint("Document does not exist for ID: ${userModel.id}");
      }
    } catch (e) {
      // // Firestore operation error
      // debugPrint("Firestore Error: $e");
      rethrow; // Propagate the error further if needed
    }
  }
//--------------------------------------------------

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
          'title': newsModel.title,
          'imgUrl': newsModel.imgUrl,
          'url': newsModel.url,
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
          return;
          // // No updates provided in newsModel
          // debugPrint("No updates provided for ID: ${newsModel.id}");
        }
      } else {
        return;
        // // Document doesn't exist
        // debugPrint("Document does not exist for ID: ${newsModel.id}");
      }
    } catch (e) {
      // Firestore operation error
      debugPrint("Firestore Error: $e");
      rethrow; // Propagate the error further if needed
    }
  }

//--------------------------------------------
  @override
  Future<void> updateNewProduct(NewProduct newProduct) async {
    try {
      // Fetch the existing data from Firestore
      final existingData = await FirestoreServices.instance
          .getData(path: "newproduct/${newProduct.id}");

      if (existingData != null) {
        // Update logic: Replace existing fields with provided data if available
        final Map<String, dynamic> updatedData = {
          'title': newProduct.title,
          'imgUrl': newProduct.imgUrl,
          'discountValue': newProduct.discountValue,
          'maximum': newProduct.maximum,
          'price': newProduct.price,
          'script': newProduct.script,
          'minimum': newProduct.minimum,
          'qunInCarton': newProduct.qunInCarton,
          // Add other fields you want to update similarly
        };

        // Merge updatedData with existingData to keep the old data intact
        final mergedData = {...existingData, ...updatedData};

        // Check if any update was made, then update the Firestore document
        if (mergedData.isNotEmpty) {
          await FirestoreServices.instance.setData(
            path: "newproduct/${newProduct.id}",
            data: mergedData,
          );
          // Successful update, log a message
          debugPrint("News updated successfully!");
        } else {
          return;
          // // No updates provided in newsModel
          // debugPrint("No updates provided for ID: ${newProduct.id}");
        }
      } else {
        return;
        // // Document doesn't exist
        // debugPrint("Document does not exist for ID: ${newProduct.id}");
      }
    } catch (e) {
      // Firestore operation error
      debugPrint("Firestore Error: $e");
      rethrow; // Propagate the error further if needed
    }
  }

  //---------------------------------------------------
  @override
  Future<void> updateProduct(Product newProduct) async {
    try {
      // Fetch the existing data from Firestore
      final existingData = await FirestoreServices.instance
          .getData(path: "products/${newProduct.id}");

      if (existingData != null) {
        // Update logic: Replace existing fields with provided data if available
        final Map<String, dynamic> updatedData = {
          'title': newProduct.title,
          'imgUrl': newProduct.imgUrl,
          'category': newProduct.category,
          'maximum': newProduct.maximum,
          'price': newProduct.price,
          'script': newProduct.script,
          'minimum': newProduct.minimum,
          'qunInCarton': newProduct.qunInCarton,
          // Add other fields you want to update similarly
        };

        // Merge updatedData with existingData to keep the old data intact
        final mergedData = {...existingData, ...updatedData};

        // Check if any update was made, then update the Firestore document
        if (mergedData.isNotEmpty) {
          await FirestoreServices.instance.setData(
            path: "products/${newProduct.id}",
            data: mergedData,
          );
        } else {
          return;
          // No updates provided in newsModel
          // debugPrint("No updates provided for ID: ${newProduct.id}");
        }
      } else {
        return;
        // Document doesn't exist
        // debugPrint("Document does not exist for ID: ${newProduct.id}");
      }
    } catch (e) {
      // Firestore operation error

      rethrow; // Propagate the error further if needed
    }
  }

  @override
  Future<void> clearCart(String uid) async {
    final FirebaseFirestore fireStore = FirebaseFirestore.instance;
    try {
      final userRef = fireStore.collection('users').doc(uid);
      final cartSnapshot = await userRef.collection('cart').get();

      final List<Future<void>> deleteFutures = [];
      for (final doc in cartSnapshot.docs) {
        final reference = doc.reference;
        deleteFutures.add(reference.delete());
      }
      await Future.wait(deleteFutures);
    } catch (e) {
      rethrow;
      // Handle or log the error as needed
    }
  }
}
