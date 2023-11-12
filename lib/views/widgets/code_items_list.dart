// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/database_controller.dart';
// import '../../models/new_product.dart';
// import '../../models/news_modle.dart';
// import '../../models/product.dart';
// import '../pages/add_new_product.dart';
// import 'list_product_tile.dart';

// class ItemListCode extends StatelessWidget {
//   final Product product;
//   final NewProduct newProduct;
//   final NewsModel newsModel;

//   const ItemListCode({
//     Key? key,
//     required this.product, required this.newProduct, required this.newsModel,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // final size = MediaQuery.of(context).size;
//     final database = Provider.of<Database>(context);
//     return Scaffold(
//       body: Center(
//         child: StreamBuilder<List<NewProduct>>(
//             stream: database.newProductsStream(),
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.active) {
//                 final newProduct = snapshot.data;
//                 if (newProduct == null || newProduct.isEmpty) {
//                   return const Center(
//                     child: Text('No Data Available!'),
//                   );
//                 }
//                 return ListView.builder(
//                   scrollDirection: Axis.vertical,
//                   itemCount: newProduct.length,
//                   itemBuilder: (_, int index) => Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: ListTileProduct(
//                       newProduct: newProduct[index],
//                    onTap: () {},
//                       num: index + 1, 
//                       product: product,
//                        newsModel: newsModel,
//                     ),
//                   ),
//                 );
//               }
//               return const Center(
//                 child: CircularProgressIndicator(),
//               );
//             }),
//       ),
//       floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                   builder: (context) => AddOfferPage(
//                         product: product,
//                       )),
//             );
//           }),
//     );
//   }
// }
