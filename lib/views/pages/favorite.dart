import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/favourite_modle.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../widgets/favourite__list_item.dart';

class Favorite extends StatefulWidget {
  const Favorite({super.key});

  @override
  State<Favorite> createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return SafeArea(
      child: StreamBuilder<List<FavouriteModel>>(
          stream: database.myFavouriteStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              Center(
                child: Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              );
            }
            if (snapshot.connectionState == ConnectionState.active) {
              final favouriteItem = snapshot.data;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(height: 16.0),
                      Text(
                        'المفضلة',
                        textAlign: TextAlign.right,
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                      const SizedBox(height: 16.0),
                      if (favouriteItem == null || favouriteItem.isEmpty)
                        Center(
                          child: Text(
                            "لا يوجد بيانات",
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ),
                      if (favouriteItem != null && favouriteItem.isNotEmpty)
                        ListView.builder(
                          itemCount: favouriteItem.length,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (BuildContext context, int i) {
                            final favouriteListItem = favouriteItem[i];
                            return FavouriteListItem(
                              favouriteModel: favouriteListItem,
                            );
                          },
                        ),
                      const SizedBox(height: 32.0),
                    ],
                  ),
                ),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
