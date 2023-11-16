import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/favourite_modle.dart';
import '../../models/product.dart';
import '../../utilities/constants.dart';
import '../widgets/main_button.dart';
import '../widgets/main_dialog.dart';

class NewProductDetails extends StatefulWidget {
  final Product product;
  const NewProductDetails({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<NewProductDetails> createState() => _NewProductDetailsState();
}

class _NewProductDetailsState extends State<NewProductDetails> {
  bool isFavorite = false;

  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        qunInCarton: widget.product.qunInCarton,
      );

      // Check if the item is already in the cart
      final exists = await database.isItemInCart(widget.product.title).first;
      if (exists) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const
         AlertDialog(
          content: Text(
            "المنتج موجود بالفعل",
            textAlign: TextAlign.center,
          ),
        );
          },
        );
      } else {
        database.addToCart(addToCartProduct);
      }
    } catch (e) {
      return MainDialog(
        title: 'Error',
        content: 'Couldn\'t add to the cart, please try again!',
      ).showAlertDialog();
    }
  }

//--------------------------------------------------------
  Future<void> _addToFavourite(Database database) async {
    try {
      final addToFavouriteProduct = FavouriteModel(
        id: documentIdFromLocalData(),
        title: widget.product.title,
        price: widget.product.price,
        productId: widget.product.id,
        imgUrl: widget.product.imgUrl,
        qunInCarton: widget.product.qunInCarton,
      );

      // Check if the item is already in the favorite
      final exists =
          await database.isItemInFavourite(widget.product.title).first;
      if (exists) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const
         AlertDialog(
          content: Text(
            "المنتج موجود بالفعل",
            textAlign: TextAlign.center,
          ),
        );
          },
        );
      } else {
        database.addToFavourite(addToFavouriteProduct);
      }
    } catch (e) {
      return MainDialog(
        title: 'Error',
        content: 'Couldn\'t add to the favorite, please try again!',
      ).showAlertDialog();
    }
  }

  //---------------------------------------------------------
//  Future<void> _addToFavourite(Database database) async {
//     try {
//       final addToFavouriteProduct = FavouriteModel(
//         id: documentIdFromLocalData(),
//         title: widget.product.title,
//         price: widget.product.price,
//         productId: widget.product.id,
//         imgUrl: widget.product.imgUrl,
//         qunInCarton: widget.product.qunInCarton,
//       );
//       await database.addToFavourite(addToFavouriteProduct);
//     } catch (e) {
//       return MainDialog(
//         // context: context,
//         title: 'Error',
//         content: 'Couldn\'t adding to the Favourite, please try again!',
//       ).showAlertDialog();
//     }
//   }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_right_alt_sharp),
            color: Colors.white,
          )
        ],
        centerTitle: true,
        title: Text(widget.product.title,
            softWrap: true,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255),
                )),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.product.imgUrl,
              width: double.infinity,
              height: size.height * 0.55,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24.0),
                  ListTile(
                    title: Text(
                      maxLines: 4,
                      softWrap: true,
                      textAlign: TextAlign.right,
                      widget.product.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    leading: Text(
                      'ج ${widget.product.price}السعر',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                    ),
                    subtitle: Text(
                      '${widget.product.script}  ${widget.product.qunInCarton}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                          _addToFavourite(database);
                        },
                        child: SizedBox(
                          height: 60,
                          width: 60,
                          child: DecoratedBox(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border_outlined,
                                color: isFavorite
                                    ? Colors.redAccent
                                    : Colors.black45,
                                size: 30,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SmallMainButton(
                        text: 'اضافة الى طلبيتك',
                        onTap: () => _addToCart(database),
                        hasCircularBorder: true,
                      ),
                    ],
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
