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
    super.key,
    required this.newProduct,
  });

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
        script: widget.newProduct.script,
        maximum: widget.newProduct.maximum,
        quantity: widget.newProduct.minimum,
        minimum: widget.newProduct.minimum,
      );

      // Check if the item is already in the cart
      final exists = await database.isItemInCart(widget.newProduct.title).first;
      if (exists) {
        // ignore: use_build_context_synchronously
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
        await database.addToCart(addToCartProduct);
        // ignore: use_build_context_synchronously
        Navigator.of(context).pop();
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
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          widget.newProduct.title,
          softWrap: true,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w600,
                color: const Color.fromARGB(255, 255, 255, 255),
              ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Container(
              width: double.infinity,
              height: size.height * 0.50,
              decoration: BoxDecoration(
                border: Border.all(
                  color: scaffoldBackgroundColor,
                  width: 20.0, // Border width
                ), // Rounded corners for the image
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30.0),
                child: Image.network(
                  widget.newProduct.imgUrl,
                  width: double.infinity,
                  height: size.height * 0.50,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 6.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const SizedBox(height: 10.0),
                  ListTile(
                    title: Text(
                      maxLines: 4,
                      softWrap: true,
                      textAlign: TextAlign.right,
                      widget.newProduct.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                    leading: Text(
                      'السعر :${widget.newProduct.price} ج',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.red,
                          ),
                    ),
                    subtitle: Text(
                      '${widget.newProduct.script} : ${widget.newProduct.qunInCarton}',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 18.0,
                      vertical: 4.0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          ' السعر قبل الخصم  ${widget.newProduct.discountValue} ج',
                          style:
                              Theme.of(context).textTheme.titleMedium!.copyWith(
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                          // textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.04,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 6.0,
                    ),
                    child: MainButton(
                        text: 'اضافة الى طلبيتك',
                        onTap: () async {
                         await _addToCart(database);
                        }
                        // hasCircularBorder: true,
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


// ------------------------------------------------------
// new product changed with product details :
//its mean for new product details we use product details we el aks


