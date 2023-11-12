import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/button_special_contrroler.dart';
import '../pages/add_new_product.dart';
import '../pages/add_newes.dart';
import '../pages/add_product.dart';
import '../pages/edit_new_product.dart';
import '../pages/edit_news.dart';
import '../pages/edit_product.dart';

class MySpecialButtonWidget extends StatelessWidget {
  const MySpecialButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var specialController = Provider.of<SpecialController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(" SpecialButton "),
      ),
      body: SingleChildScrollView(
        child: ListTile(
          title: Text(
            "Edit Data",
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: const Color.fromARGB(255, 26, 27, 26),
                ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.add),
            iconSize: 50,
            onPressed: () {
              showMenu(
                context: context,
                position: const RelativeRect.fromLTRB(200, 200, 0, 0),
                items: [
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add Offer'),
                      onTap: () {
                        // Perform action for Settings option
                        Navigator.pop(context);
                        // Add your code here
                        MaterialPageRoute(
                            builder: (context) => AddOfferPage(
                                  product: specialController.product,
                                ));
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.add),
                      title: const Text('Add News'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => AddNewsPage(
                                    product: specialController.product,
                                  )),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                        leading: const Icon(Icons.add),
                        title: const Text('Add Product'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => AddProduct(
                                      product: specialController.product,
                                    )),
                          );
                        }),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Edit News'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const EditNews()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: const Icon(Icons.edit),
                      title: const Text('Edit Offer'),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                              builder: (context) => const EditNewProduct()),
                        );
                      },
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                        leading: const Icon(Icons.edit),
                        title: const Text('Edit Product'),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => const EditProduct()),
                          );
                        }),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
