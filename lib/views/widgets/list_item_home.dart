import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

import '../../models/new_product.dart';

class ListItemHome extends StatelessWidget {
  final NewProduct newProduct;

  const ListItemHome({
    super.key,
    required this.newProduct,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return InkWell(
      onTap: () {
        Navigator.of(context, rootNavigator: true).pushNamed(
          AppRoutes.newproductDetailsRoute,
          arguments: {
            'product': newProduct,
            'database': database,
          },
        );
      },
      child: ClipRRect(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.network(newProduct.imgUrl,
                  width: size.height * 0.21,
                  height: size.height * 0.19,
                  fit: BoxFit.cover, errorBuilder: (BuildContext context,
                      Object exception, StackTrace? stackTrace) {
                return SizedBox(
                  width: size.height * 0.20,
                  height: size.height * 0.19,
                  child: const Center(child: Text("لا يوجد صورة")),
                  // Placeholder color for the error case
                  // You can also add an icon or text to indicate the error
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
              child: SizedBox(
                width: size.height * 0.19,
                child: Text(
                  newProduct.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 4.0),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${newProduct.discountValue} ج',
                    style: Theme.of(context).textTheme.titleSmall!.copyWith(
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                  ),
                  TextSpan(
                    text: '  ${newProduct.price} ',
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          color: Colors.red,
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
