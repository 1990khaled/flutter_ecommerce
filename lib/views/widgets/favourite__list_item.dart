import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/favourite_modle.dart';
import '../../models/product.dart';
import '../../utilities/routes.dart';

class FavouriteListItem extends StatefulWidget {
  final FavouriteModel favouriteModel;

  const FavouriteListItem({super.key, required this.favouriteModel});

  @override
  State<FavouriteListItem> createState() => _FavouriteListItemState();
}

class _FavouriteListItemState extends State<FavouriteListItem> {
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    final size = MediaQuery.of(context).size;
    final Product product = Product(
        id: widget.favouriteModel.id,
        title: widget.favouriteModel.title,
        price: widget.favouriteModel.price,
        imgUrl: widget.favouriteModel.imgUrl,
        qunInCarton: widget.favouriteModel.qunInCarton);
    return InkWell(
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetailsRoute,
        arguments: {
          'product': product,
          'database': database,
        },
      ),
      child: SizedBox(
        height: size.height * 0.23,
        child: Card(
          color: Colors.white54,
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
                        widget.favouriteModel.imgUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.12,
                    width: size.height * 0.25,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        softWrap: true,
                        textAlign: TextAlign.right,
                        widget.favouriteModel.title,
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
                  softWrap: true,
                  textAlign: TextAlign.center,
                  "السعر: ${widget.favouriteModel.price}",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                subtitle: Text(
                  textAlign: TextAlign.center,
                  "${widget.favouriteModel.qunInCarton} : ${widget.favouriteModel.script} ",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(),
                ),
                trailing: IconButton(
                    onPressed: () {
                      database.removeFromFavourite(widget.favouriteModel);
                    },
                    icon: const Icon(
                      Icons.delete,
                      size: 35,
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
