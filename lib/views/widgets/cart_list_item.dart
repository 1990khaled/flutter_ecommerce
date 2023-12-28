import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';

class CartListItem extends StatefulWidget {
  final AddToCartModel cartItem;

  const CartListItem({
    super.key,
    required this.cartItem,
  });

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {
  @override
  Widget build(BuildContext context) {
    final double totalAmount = widget.cartItem.price *
        widget.cartItem.qunInCarton *
        widget.cartItem.quantity;
    final formattedTotalAmount =
        NumberFormat("#,##0.0", "en_US").format(totalAmount);
//---------------------------------------------------------------------------------
    final int totalQuantity =
        widget.cartItem.qunInCarton * widget.cartItem.quantity;
    final formattedTotalQuantity =
        NumberFormat("#,##0", "en_US").format(totalQuantity);
    final database = Provider.of<Database>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.29,
      child: Card(
        color: Colors.white,
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
                Expanded(
                  child: Column(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_up),
                        onPressed: () async {
                          if (widget.cartItem.quantity <
                              widget.cartItem.maximum) {
                            widget.cartItem.quantity++;
                            try {
                              await database.updateQuantityInCart(
                                  widget.cartItem, widget.cartItem.quantity);
                            } catch (e) {
                              // Handle the error, if any
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'الوصول للحد الأقصى - لمزيد من التفاصيل برجاء التواصل مع الصفحة'),
                              ),
                            );
                          }
                          setState(
                              () {}); // Trigger a rebuild after updating the quantity
                        },
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        "${widget.cartItem.quantity}",
                      ),
                      IconButton(
                        icon: const Icon(Icons.arrow_drop_down),
                        onPressed: () async {
                          if (widget.cartItem.quantity >
                              widget.cartItem.minimum) {
                            widget.cartItem.quantity--;
                            try {
                              await database.updateQuantityInCart(
                                  widget.cartItem, widget.cartItem.quantity);
                            } catch (e) {
                              // Handle the error, if any
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'الوصول للحد الأدنى - لمزيد من التفاصيل برجاء التواصل مع الصفحة'),
                              ),
                            );
                          }
                          setState(
                              () {}); // Trigger a rebuild after updating the quantity
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SizedBox(
                    height: size.height * 0.12,
                    width: size.height * 0.20,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        widget.cartItem.title,
                        softWrap: true,
                        textAlign: TextAlign.right,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text(
                "${widget.cartItem.qunInCarton} : ${widget.cartItem.script} ",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                softWrap: true,
                textAlign: TextAlign.right,
              ),
              trailing: IconButton(
                  onPressed: () {
                    database.removeFromCart(widget.cartItem);
                  },
                  icon: const Icon(Icons.delete)),
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
                    "السعر: ${widget.cartItem.price}",
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
