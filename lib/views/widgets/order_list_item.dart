import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:intl/intl.dart';

class OrderListItem extends StatelessWidget {
  final AddToCartModel? cartItem;

  const OrderListItem({
    super.key,
    required this.cartItem,
  });

  @override
  Widget build(BuildContext context) {
    double totalAmount = 1.0;
    if (cartItem == null || cartItem!.id.isEmpty) {
      return const Center(
        child: Text("لا يوجد بيانات"),
      ); // Replace this with an appropriate handling for null or empty cart items
    }

    totalAmount = cartItem!.price * cartItem!.qunInCarton * cartItem!.quantity;
    final formattedTotalAmount =
        NumberFormat("#,##0.0", "en_US").format(totalAmount);
    //-----------------------------------------------------------------------------------
    final int totalQuantity = cartItem!.qunInCarton * cartItem!.quantity;
    final formattedTotalQuantity =
        NumberFormat("#,##0.", "en_US").format(totalQuantity);

    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height * 0.24,
      child: Card(
        color: Colors.white70,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: SizedBox(
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
                  ),
                  SizedBox(
                    width: size.height * 0.04,
                  ),
                  Expanded(
                    child: Text(
                      "الكمية: ${cartItem!.quantity}", // Change index to display the first product quantity
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: size.height * 0.12,
                      width: size.height * 0.20,
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          cartItem!
                              .title, // Change index to display the first product title
                          softWrap: true,
                          textAlign: TextAlign.right,
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                "${cartItem!.qunInCarton} : ${cartItem!.script}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                softWrap: true,
                textAlign: TextAlign.right,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.right,
                    " القيمة : $formattedTotalAmount",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "السعر: ${cartItem!.price}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  Text(
                    "$formattedTotalQuantity : اجمالي الكمية",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w400,
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


// class OrderListItem extends StatelessWidget {
//   final AddToCartModel? cartItem;

//   const OrderListItem({
//     Key? key,
//     required this.cartItem,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     double totalAmount = 1.0;
//     if (cartItem == null || cartItem!.id.isEmpty) {
//       return const Center(
//         child: Text("لا يوجد بيانات"),
//       ); // Replace this with an appropriate handling for null or empty cart items
//     }

//     totalAmount = cartItem!.price * cartItem!.qunInCarton * cartItem!.quantity;

//     final size = MediaQuery.of(context).size;

//     return SizedBox(
//       height: size.height * 0.24,
//       child: Card(
//         color: Colors.white70,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: Column(
//           children: [
//             Expanded(
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Expanded(
//                     child: SizedBox(
//                       height: size.height * 0.12,
//                       width: size.height * 0.14,
//                       child: ClipRRect(
//                         borderRadius: const BorderRadius.all(
//                           Radius.circular(16.0),
//                         ),
//                         child: Image.network(
//                           cartItem!.imgUrl,
//                           // .imgUrl, // Change index to display the first product image
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(
//                     width: size.height * 0.04,
//                   ),
//                   Expanded(
//                     child: Text(
//                       "الكمية: ${cartItem!.quantity}", // Change index to display the first product quantity
//                       style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                             fontWeight: FontWeight.w400,
//                           ),
//                     ),
//                   ),
//                   Expanded(
//                     child: SizedBox(
//                       height: size.height * 0.12,
//                       width: size.height * 0.20,
//                       child: Align(
//                         alignment: Alignment.center,
//                         child: Text(
//                           cartItem!
//                               .title, // Change index to display the first product title
//                           softWrap: true,
//                           textAlign: TextAlign.right,
//                           style:
//                               Theme.of(context).textTheme.titleLarge!.copyWith(
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ListTile(
//               title: Text(
//                 "${cartItem!.qunInCarton} : ${cartItem!.script}",
//                 style: Theme.of(context).textTheme.titleMedium!.copyWith(),
//                 softWrap: true,
//                 textAlign: TextAlign.right,
//               ),
//               subtitle: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     "السعر: ${cartItem!.price}",
//                     style: Theme.of(context).textTheme.titleMedium!.copyWith(
//                           fontWeight: FontWeight.w600,
//                         ),
//                   ),
//                   Text(
//                     "القيمة : $totalAmount",
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
