class ApiPath {
  static String products() => 'products/';
  static String newProduct() => 'newproduct/';
  static String newsStream() => 'news/';
  // -------------------------------------------------------------
  static String profileInfoStream() => 'profileInfoStream/';
    static String profileInfo(String uid,) =>
      'users/$uid/profileInfo/';
  // -------------------------------------------------------------
  
  // ------------------------------------------------------------
  static String deliveryMethods() => 'deliveryMethods/';
  // ------------------------------------------------------------
  static String user(String uid) => 'users/$uid';
  static String addToCart(String uid, String addToCartId) =>
      'users/$uid/cart/$addToCartId';
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
