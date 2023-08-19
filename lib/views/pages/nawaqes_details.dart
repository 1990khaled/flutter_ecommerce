// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/nawqes.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';

class NawaqestDetails extends StatelessWidget {
  final ShowingNawaqesModel nawaqes;
 const NawaqestDetails({Key? key, required this.nawaqes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    // final database = Provider.of<Database>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          nawaqes.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          IconButton(
            onPressed: () async {
              // _docReference.delete();
            },
            icon: const Icon(
              Icons.delete,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image.network(
            //   widget.nawaqes.imgUrl,
            //   width: double.infinity,
            //   height: size.height * 0.55,
            //   fit: BoxFit.cover,
            // ),
            // const SizedBox(height: 8.0),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                ), // border making ,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${nawaqes.price}',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                          Text(
                            nawaqes.title,
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(
                                  fontWeight: FontWeight.w600,
                                ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            " ${nawaqes.ammount.toString()} الكمية",
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(
                                  color: Colors.black54,
                                ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              'اسم المندوب ${nawaqes.actorName}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                      const SizedBox(height: 16.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "اسم العميل ${nawaqes.description}",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.pushNamed(context, AppRoutes.addOfferRout);
          },
          child: const Icon(Icons.add)),
    );
  }
}



  // Future<void> _addToCart(Database database) async {
  //   try {
  //     final addToCartProduct = AddToCartModel(
  //       id: documentIdFromLocalData(),
  //       title: widget.nawaqes.title,
  //       price: widget.nawaqes.price,
  //       productId: widget.nawaqes.id,
  //       imgUrl: widget.nawaqes.imgUrl,
  //       size: dropdownValue,
  //     );
  //     await database.addToCart(addToCartProduct);
  //   } catch (e) {
  //     return MainDialog(
  //       context: context,
  //       title: 'Error',
  //       content: 'Couldn\'t adding to the cart, please try again!',
  //     ).showAlertDialog();
  //   }
  // }
