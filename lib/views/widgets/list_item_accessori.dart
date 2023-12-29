import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

class ListItemAccessories extends StatefulWidget {
  final Product product;

  const ListItemAccessories({
    super.key,
    required this.product,
  });

  @override
  State<ListItemAccessories> createState() => _ListItemAccessoriesState();
}

class _ListItemAccessoriesState extends State<ListItemAccessories> {
  @override
  void initState() {
    checkIfFavourite();
    super.initState();
  }

  Future<void> checkIfFavourite() async {
    final database = Provider.of<Database>(context, listen: false);
    bool isFav = await database.isItemInFavourite(widget.product.title).first;
    setState(() {
      widget.product.isFavourite = isFav;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return InkWell(
        customBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        onTap: () async {
          await checkIfFavourite().whenComplete(
              () => Navigator.of(context, rootNavigator: true).pushNamed(
                    AppRoutes.productDetailsRoute,
                    arguments: {
                      'product': widget.product,
                      'database': database,
                    },
                  ));
        },
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(widget.product.imgUrl,
                  width: size.height * 0.20,
                  height: size.height * 0.16,
                  fit: BoxFit.cover, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                return SizedBox(
                  width: size.height * 0.20,
                  height: size.height * 0.16,
                  child: const Center(child: Text("لا يوجد صورة")),
                );
              }),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListTile(
                  leading: Text.rich(
                    TextSpan(
                      text: '  ${widget.product.price}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                    ),
                  ),
                  title: Text(
                    textAlign: TextAlign.center,
                    widget.product.title,
                    maxLines: 2,
                    softWrap: true,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
