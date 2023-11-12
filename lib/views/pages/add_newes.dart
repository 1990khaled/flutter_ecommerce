import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/database_controller.dart';
import '../../models/add_to_cart_model.dart';
import '../../models/product.dart';
import '../../utilities/constants.dart';
import '../widgets/main_button.dart';
import '../widgets/main_dialog.dart';

class AddNewsPage extends StatefulWidget {
  // static Map<String, dynamic> get newdata {
  //   return data;
  // }
  final Product product;
  final notificationId = UniqueKey().hashCode;

  AddNewsPage({super.key, required this.product});

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

// Map<String, dynamic> data = {};

class _AddNewsPageState extends State<AddNewsPage> {
  bool isFavorite = false;
  late String dropdownValue;

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
      await database.addToCart(addToCartProduct);
    } catch (e) {
      return MainDialog(
        // context: context,
        title: 'Error',
        content: 'Couldn\'t adding to the cart, please try again!',
      ).showAlertDialog();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.product.title,
          maxLines: 3,
          softWrap: true,
          style: Theme.of(context).textTheme.titleMedium,
        ),
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
                        text: 'تحديــــث  ',
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
