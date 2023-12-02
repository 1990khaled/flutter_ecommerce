import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';

class OrderListItem extends StatelessWidget {
  final AddToCartModel? cartItem;
  double totalAmount = 1.0;
  int index = 0;

  OrderListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cartItem == null || cartItem!.id.isEmpty) {
      return const Center(
        
        child: Text("لا يوجد بيانات"),
      ); // Replace this with an appropriate handling for null or empty cart items
    }

    totalAmount = cartItem!.price * cartItem!.qunInCarton * cartItem!.quantity;

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.23,
      child: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: size.height * 0.12,
                  width: size.height * 0.14,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(16.0),
                    ),
                    child: Image.network(
                      cartItem!.imgUrl,
                      // .imgUrl, // Change index to display the first product image
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    Text(
                      "الكمية: ${cartItem!.quantity}", // Change index to display the first product quantity
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.height * 0.20,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      cartItem!
                          .title, // Change index to display the first product title
                      softWrap: true,
                      textAlign: TextAlign.right,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                "${cartItem!.qunInCarton} : ${cartItem!.script}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                softWrap: true,
                textAlign: TextAlign.right,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "السعر: ${cartItem!.price}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "القيمة : $totalAmount",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



//-------------------------------------------------
// class OrderListItem extends StatefulWidget {
//   final OrdersModel? cartItem;
//   double totalAmount = 1.0;

//   OrderListItem({
//     Key? key,
//     required this.cartItem,
//   }) : super(key: key);

//   @override
//   State<OrderListItem> createState() => _OrderListItemState();
// }

// class _OrderListItemState extends State<OrderListItem> {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unnecessary_null_comparison
//     if (widget.cartItem == null) {
//       return Container(); // Replace this with an appropriate handling for null cart items
//     }

//     widget.totalAmount = widget.cartItem!.totalAmount;
//     final size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height * 0.23,
//       child: Card(
//         color: Colors.white70,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: size.height * 0.12,
//                   width: size.height * 0.14,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(16.0),
//                     ),
//                     child: Image.network(
//                       widget.cartItem!.theOrder[i].imgUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       "الكمية: ${widget.cartItem!.theOrder[].quantity}",
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             fontWeight: FontWeight.w400,
//                           ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.height * 0.12,
//                   width: size.height * 0.20,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       widget.cartItem!.theOrder[].title, // Fix placed within Text widget
//                       softWrap: true,
//                       textAlign: TextAlign.right,
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             ListTile(
//               title: Text(
//                 "${widget.cartItem!.theOrder[i].qunInCarton} : ${widget.cartItem!.theOrder[i].script} ",
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(),
//                 softWrap: true,
//                 textAlign: TextAlign.right,
//               ),
//               subtitle: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "السعر: ${widget.cartItem!.theOrder[i].price}",
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   Text(
//                     " القيمة : ${widget.totalAmount}", // Named parameter added
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }



//---------------------------------------------------------
// class OrderListItem extends StatefulWidget {
//   final AddToCartModel cartItem;
//    double totalAmount = 1.0;
//   OrderListItem({
//     Key? key,
//     required this.cartItem,
//   }) : super(key: key);

//   @override
//   State<OrderListItem> createState() => _OrderListItemState();
// }

// class _OrderListItemState extends State<OrderListItem> {
//   @override
//   Widget build(BuildContext context) {
//     widget.totalAmount = widget.cartItem.price *
//         widget.cartItem.qunInCarton *
//         widget.cartItem.quantity;
//     final size = MediaQuery.of(context).size;
//     return SizedBox(
//       height: size.height * 0.23,
//       child: Card(
//         color: Colors.white70,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Column(
//           children: [
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(
//                   height: size.height * 0.12,
//                   width: size.height * 0.14,
//                   child: ClipRRect(
//                     borderRadius: const BorderRadius.all(
//                       Radius.circular(16.0),
//                     ),
//                     child: Image.network(
//                       widget.cartItem.imgUrl,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 Column(
//                   children: [
//                     Text(
//                       textAlign: TextAlign.center,
//                       "الكمية: ${widget.cartItem.quantity}",
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             fontWeight: FontWeight.w400,
//                           ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: size.height * 0.12,
//                   width: size.height * 0.20,
//                   child: Align(
//                     alignment: Alignment.center,
//                     child: Text(
//                       softWrap: true,
//                       textAlign: TextAlign.right,
//                       widget.cartItem.title,
//                       style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                             fontWeight: FontWeight.w600,
//                           ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             ListTile(
//               title: Text(
//                 "${widget.cartItem.qunInCarton} : ${widget.cartItem.script} ",
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(),
//                 softWrap: true,
//                 textAlign: TextAlign.right,
//               ),
//               subtitle: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     textAlign: TextAlign.right,
//                     " القيمة : ${widget.totalAmount}",
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   Text(
//                     "السعر: ${widget.cartItem.price}",
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
