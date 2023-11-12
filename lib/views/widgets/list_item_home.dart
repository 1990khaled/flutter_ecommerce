import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

import '../../models/new_product.dart';

class ListItemHome extends StatelessWidget {
  final NewProduct newProduct;

  const ListItemHome({
    Key? key,
    required this.newProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.newproductDetailsRoute,
        arguments: {
          'product': newProduct,
          'database': database,
        },
      ),
      child: Stack(
        children: [
          Stack(children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(
                newProduct.imgUrl,
                width: size.height * 0.20,
                height: size.height * 0.20,
                fit: BoxFit.cover,
              ),
            ),
          ]),
          Positioned(
            height: size.height * 0.17,
            bottom: 0.7,
            right: 7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: size.height * 0.17,
                  child: Text(
                    newProduct.title,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
                const SizedBox(height: 4.0),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${newProduct.price} ج',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                      ),
                      TextSpan(
                        text:
                            '  ${newProduct.price - newProduct.price * newProduct.discountValue}',
                        style:
                            Theme.of(context).textTheme.titleMedium!.copyWith(
                                  color: Colors.red,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
