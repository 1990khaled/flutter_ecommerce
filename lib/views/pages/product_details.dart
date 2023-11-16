import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/add_to_cart_model.dart';
import 'package:flutter_ecommerce/models/new_product.dart';
import 'package:flutter_ecommerce/utilities/constants.dart';
import 'package:flutter_ecommerce/views/widgets/main_button.dart';
import 'package:flutter_ecommerce/views/widgets/main_dialog.dart';
import 'package:provider/provider.dart';

class ProductDetails extends StatefulWidget {
  final NewProduct newProduct;
  const ProductDetails({
    Key? key,
    required this.newProduct,
  }) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  bool isFavorite = false;
  late String dropdownValue;

  Future<void> _addToCart(Database database) async {
    try {
      final addToCartProduct = AddToCartModel(
        id: documentIdFromLocalData(),
        title: widget.newProduct.title,
        price: widget.newProduct.price,
        productId: widget.newProduct.id,
        imgUrl: widget.newProduct.imgUrl,
        qunInCarton: widget.newProduct.qunInCarton,
      );

      // Check if the item is already in the cart
      final exists = await database.isItemInCart(widget.newProduct.title).first;
      if (exists) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return const AlertDialog(
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
        title: Text(
          widget.newProduct.title,
          softWrap: true,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              widget.newProduct.imgUrl,
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
                      widget.newProduct.title,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    leading: Text(
                      'ج ${widget.newProduct.price - widget.newProduct.price * widget.newProduct.discountValue}السعر',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                    ),
                    subtitle: Text(
                      '${widget.newProduct.script}  ${widget.newProduct.qunInCarton}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  const SizedBox(height: 24.0),
                  MainButton(
                    text: 'اضافة الى طلبيتك',
                    onTap: () => _addToCart(database),
                    hasCircularBorder: true,
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


// ------------------------------------------------------
// new product changed with product details : its mean for new product details we use product details we el aks


