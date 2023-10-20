import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/nawqes.dart';
import '../widgets/list_tile.dart';
import 'add_nawaqes.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "نواقـــص",
          style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: Center(
        child: StreamBuilder<List<ShowingNawaqesModel>>(
            stream: database.nawqesProductsStream(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                final nawaqes = snapshot.data;
                if (nawaqes == null || nawaqes.isEmpty) {
                  return const Center(
                    child: Text('No Data Available!'),
                  );
                }
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: nawaqes.length,
                  itemBuilder: (_, int index) => Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTileProduct(
                      nawaqes: nawaqes[index],
                      onTap: () {},
                      num: index + 1,
                    ),
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddNawaqespage()),
            );
          }),
    );
  }
}
