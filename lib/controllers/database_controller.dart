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
  Stream<List<AddToCartModel>> myProductsCart();
  Stream<List<DeliveryMethod>> deliveryMethodsStream();
  Stream<List<ShippingAddress>> getShippingAddresses();
  Future<void> setUserData(UserData userData);
  Future<void> addProduct(Product product);
  Future<void> addNewProduct(NewProduct product);
  Future<void> addNews(NewsModel product);
  Future<void> addToCart(AddToCartModel product);
  Future<void> addToFavourite(FavouriteModel product);
  Future<void> saveAddress(ShippingAddress address);
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
  Future<void> addToCart(AddToCartModel product) async => _service.setData(
        path: ApiPath.addToCart(uid, product.id),
        data: product.toMap(),
      );

  //-------------------------------------------------

  @override
  Stream<List<AddToCartModel>> myProductsCart() => _service.collectionsStream(
        path: ApiPath.myProductsCart(uid),
        builder: (data, documentId) =>
            AddToCartModel.fromMap(data!, documentId),
      );

  @override
  Stream<List<FavouriteModel>> myFavouriteStream() =>
      _service.collectionsStream(
        path: ApiPath.myFavourite(uid),
        builder: (data, documentId) =>
            FavouriteModel.fromMap(data!, documentId),
      );

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
}
