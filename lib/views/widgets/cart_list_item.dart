import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';

class CartListItem extends StatefulWidget {
  final AddToCartModel cartItem;
  late double totalammount;
 
  CartListItem({
    Key? key,
    required this.cartItem,
  }) : super(key: key);

  @override
  State<CartListItem> createState() => _CartListItemState();
}

class _CartListItemState extends State<CartListItem> {

  @override
  Widget build(BuildContext context) {
    widget.totalammount = widget.cartItem.price *
        widget.cartItem.qunInCarton *
        widget.cartItem.quantity;
    final database = Provider.of<Database>(context);
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height * 0.27,
      child: Card(
        // color: Colors.white60,
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
                          if (widget.cartItem.quantity <
                              widget.cartItem.maximum) {
                            setState(() async {
                              widget.cartItem.quantity++;
                              await database.updateQuantityInCart(
                                  widget.cartItem, widget.cartItem.quantity);
                            });
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                    'الوصول للحد الاقصى - لمزيد من التفاصيل برجاء التواصل مع الصفحة'),
                              ),
                            );
                          }
                        });
                      },
                    ),
                    Text(
                        textAlign: TextAlign.center,
                        "${widget.cartItem.quantity}"),
                    IconButton(
                      icon: const Icon(Icons.arrow_drop_down),
                      onPressed: () {
                        if (widget.cartItem.quantity >
                            widget.cartItem.minimum) {
                          setState(() async {
                            widget.cartItem.quantity--;
                            await database.updateQuantityInCart(
                                widget.cartItem, widget.cartItem.quantity);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'الوصول للحد الادنى - لمزيد من التفاصيل برجاء التواصل مع الصفحة'),
                            ),
                          );
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
              title: Text(
                "${widget.cartItem.qunInCarton} : ${widget.cartItem.script} ",
                style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                softWrap: true,
                textAlign: TextAlign.right,
              ),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "السعر: ${widget.cartItem.price}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    textAlign: TextAlign.right,
                    " القيمة : ${widget.totalammount}",
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
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
