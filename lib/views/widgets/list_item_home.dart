import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/controllers/database_controller.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_ecommerce/utilities/routes.dart';
import 'package:provider/provider.dart';

class ListItemHome extends StatefulWidget {
  final Product product;
  final bool isNew;
  final VoidCallback? addToFavorites;
  final bool isFavorite;
  const ListItemHome({
    Key? key,
    required this.product,
    required this.isNew,
    this.addToFavorites,
    this.isFavorite = false,
  }) : super(key: key);

  @override
  State<ListItemHome> createState() => _ListItemHomeState();
}

class _ListItemHomeState extends State<ListItemHome> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return InkWell(
      onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
        AppRoutes.productDetailsRoute,
        // TODO: we need to refactor to create models for the arguments
        arguments: {
          'product': widget.product,
          'database': database,
        },
      ),
      child: Stack(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  widget.product.imgUrl,
                  width: 200,
                  height: 200,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 50,
                  height: 25,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: widget.isNew ? Colors.black : Colors.red,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Center(
                        child: Text(
                          widget.isNew ? 'NEW' : '${widget.product.discountValue}%',
                          style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          // TODO: Create one component for the favorite button
          Positioned(
            left: size.width * 0.38,
            bottom: size.height * 0.12,
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    blurRadius: 5,
                    color: Colors.grey,
                    spreadRadius: 2,
                  )
                ],
              ),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20.0,
                child: InkWell(
                  onTap: widget.addToFavorites,
                  child: Icon(
                    widget.isFavorite ? Icons.favorite : Icons.favorite_outline,
                    size: 20.0,
                    color: widget.isFavorite ? Colors.red : Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    RatingBarIndicator(
                      itemSize: 25.0,
                      rating: widget.product.rate?.toDouble() ?? 4.0,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      direction: Axis.horizontal,
                    ),
                    const SizedBox(width: 4.0),
                    Text(
                      '(100)',
                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                Text(
                  widget.product.category,
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Colors.grey,
                      ),
                ),
                const SizedBox(height: 6.0),
                Text(
                  widget.product.title,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                ),
                const SizedBox(height: 6.0),
                widget.isNew
                    ? Text(
                        '${widget.product.price}\$',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              color: Colors.grey,
                            ),
                      )
                    : Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${widget.product.price}\$  ',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
                                    color: Colors.grey,
                                    decoration: TextDecoration.lineThrough,
                                  ),
                            ),
                            TextSpan(
                              text:
                                  '  ${widget.product.price * (widget.product.discountValue!) / 100}\$',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall!
                                  .copyWith(
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
