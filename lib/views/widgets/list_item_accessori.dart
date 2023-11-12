import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

class ListItemAccessories extends StatelessWidget {
  final Product product;

  const ListItemAccessories({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
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
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                product.imgUrl,
                width: size.height * 0.20,
                height: size.height * 0.16,
                fit: BoxFit.cover,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.topCenter,
                child: ListTile(
                  leading: Text.rich(
                    TextSpan(
                      text: '  ${product.price}',
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: const Color.fromARGB(255, 0, 0, 0),
                          ),
                    ),
                  ),
                  
                  title: Text(
                    textAlign: TextAlign.center,
                    product.title,
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
