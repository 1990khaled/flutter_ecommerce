class ApiPath {
  static String products() => 'products/';
  static String newProduct() => 'newproduct/';
  static String newsStream() => 'news/';
  static String ordersCollection(String orderId) => 'orders/$orderId';
  // -------------------------------------------------------------
  static String profileInfoStream() => 'profileInfoStream/';
    static String profileInfo(String uid,) =>
      'users/$uid/profileInfo/';
  // -------------------------------------------------------------
  
  // ------------------------------------------------------------
  static String deliveryMethods() => 'deliveryMethods/';
  // ------------------------------------------------------------
  static String user(String uid) => 'users/$uid';

  static String addToCart(String uid, String addToCartId ) =>
      'users/$uid/cart/$addToCartId/';

     static String addOrderToUserData(String uid , String addToOrderId) =>
      'users/$uid/userOrders/$addToOrderId';
  static String userOrderData(String uid) =>
      'users/$uid/userOrders/';

  static String addToFavourite(String uid, String addToFavourite) =>
      'users/$uid/Favourite/$addToFavourite';
  //-----------------------------------------------------------------------
  static String userShippingAddress(String uid) =>
      'users/$uid/shippingAddresses/';
  static String newAddress(String uid, String addressId) =>
      'users/$uid/shippingAddresses/$addressId';
    static String myProductsCart(String uid) => 'users/$uid/cart/';
    static String myFavourite(String uid) => 'users/$uid/Favourite/';
}


/*  



Future updateField(String documentId, String field, dynamic value) async {
  try {
    await FirebaseFirestore.instance.collection('your_collection_name')
        .doc(documentId)
        .coll(collectionPath)
        .doc(documentId)
        .update({field: value});
        
    print('Field updated successfully!');
  } catch (e) {
    print('Error updating field: $e');
  }
} */
