// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/database_controller.dart';
// import '../../models/new_product.dart';
// import '../../models/news_modle.dart';
// import '../../models/product.dart';
// import '../../utilities/routes.dart';

// class ListTileProduct extends StatefulWidget {
//   final Product product;
//    final NewProduct newProduct;
//      final NewsModel newsModel;
//   final VoidCallback onTap;
//   // final ValueChanged<bool?> onChanged;
//   final int num;
//   const ListTileProduct({
//     Key? key,
//     required this.product,
//     required this.onTap,
//     required this.num, required this.newProduct, required this.newsModel,
//     // required this.onChanged,
//   }) : super(key: key);

//   @override
//   State<ListTileProduct> createState() => _ListTileProductState();
// }

// class _ListTileProductState extends State<ListTileProduct> {
//   bool checked = false;
//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<Database>(context);
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: 6.0,
//         ),
//         child: InkWell(
//           onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
//             AppRoutes.addNewProduct,
//             // TODO: we need to refactor to create models for the arguments
//             arguments: {
//               'product': widget.product,
//               'database': database,
//             },
//           ),
//           child: ListTile(
//             shape: RoundedRectangleBorder(
//               side: const BorderSide(width: 2),
//               borderRadius: BorderRadius.circular(20),
//             ),
//             leading: CircleAvatar(
//               backgroundColor: const Color.fromARGB(255, 43, 179, 221),
//               child: Text(
//                 widget.num.toString(),
//                 style: const TextStyle(color: Colors.black),
//               ),
//             ),
//             title: Text(
//               widget.newProduct.title,
//               style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                     fontWeight: FontWeight.w600,
//                   ),
//             ),
//             subtitle: Text('${widget.newProduct.price}'),
//             // trailing: Text('${widget.nawaqes.price}'),
//             trailing: Checkbox(
//               value: checked,
//               onChanged: (newValue) {
//                 setState(() {
//                   checked = newValue!;
//                 });
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
