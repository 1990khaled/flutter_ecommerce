import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../utilities/api_path.dart';

class CartListItem extends StatefulWidget {
  final AddToCartModel cartItem;
  late double totalammount;
  // double calculateTotalAmount(List<AddToCartModel>? cartItems) {
  //   double total = 0;
  //   if (cartItems != null) {
  //     for (var element in cartItems) {
  //       total += element.price * element.qunInCarton * element.quantity;
  //     }
  //   }
  //   return total;
  // }

  CartListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  

  // void updateLocalQuantity(int newQuantity) {
  //   setState(() {
  //     widget.localQuantity = newQuantity;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    widget.totalammount =
        widget.cartItem.price * widget.cartItem.qunInCarton * widget.cartItem.quantity;
    final database = Provider.of<Database>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.27,
      child: Card(
        color: Colors.white60,
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
                      widget.cartItem.imgUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_up),
                      onPressed: () {
                        setState(() async {
                          widget.cartItem.quantity++;
                          await database.updateQuantityInCart(widget.cartItem, widget.cartItem.quantity);
                          
                        });
                      },
                    ),
                    Text(textAlign: TextAlign.center, "${widget.cartItem.quantity}"),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        if (widget.cartItem.quantity > 1) {
                          setState(()async {
                            widget.cartItem.quantity--;
                            await database.updateQuantityInCart(widget.cartItem, widget.cartItem.quantity);
                          });
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: size.height * 0.12,
                  width: size.height * 0.20,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      softWrap: true,
                      textAlign: TextAlign.right,
                      widget.cartItem.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "السعر: ${widget.cartItem.price}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "${widget.cartItem.qunInCarton} :الكمية داخل العبوة",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                  ),
                ],
              ),
              subtitle: Text(
                textAlign: TextAlign.right,
                " اجمالي السعر: ${widget.totalammount}",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
              ),
              trailing: IconButton(
                  onPressed: () {
                    database.removeFromCart(widget.cartItem);
                  },
                  icon: const Icon(Icons.delete)),
            ),
          ],
        ),
      ),
    );
  }
}
  




//--------------------------
// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/models/add_to_cart_model.dart';

// class CartListItem extends StatefulWidget {
//   final AddToCartModel cartItem;

//   const CartListItem({
//     Key? key,
//     required this.cartItem,
//   }) : super(key: key);

//   @override
//   State<CartListItem> createState() => _CartListItemState();
// }

// class _CartListItemState extends State<CartListItem> {
//   int qunatity = 1;
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 150,
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16.0),
//         ),
//         child: ListTile(
//           title: Text(
//             widget.cartItem.title,
//             style: Theme.of(context).textTheme.titleLarge!.copyWith(
//                   fontWeight: FontWeight.w600,
//                 ),
//           ),
// // titleAlignment:ListTileTitleAlignment.center ,
//           subtitle:
//               Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//             GestureDetector(
//                 child: Text(
//                   "$qunatity",
//                 ),
//                 onTapDown: (TapDownDetails details) {
//                   setState(() {
//                     qunatity--;
//                   });
//                 },
//                 onTapUp: (TapUpDetails details) {
//                   setState(() {
//                     qunatity++;
//                   });
//                 }),
//           ]),

//           leading: ClipRRect(
//             borderRadius: const BorderRadius.only(
//               topLeft: Radius.circular(16.0),
//               bottomLeft: Radius.circular(16.0),
//             ),
//             child: Image.network(
//               widget.cartItem.imgUrl,
//               fit: BoxFit.cover,
//             ),
//           ),
//           trailing: Text(
//             "${widget.cartItem.qunInCarton}",
//             style: Theme.of(context).textTheme.titleMedium!.copyWith(),
//           ),
//         ),
//       ),
//     );
//   }
// }
