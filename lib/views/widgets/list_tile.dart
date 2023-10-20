import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/nawqes.dart';
import '../../utilities/routes.dart';

class ListTileProduct extends StatefulWidget {
  final ShowingNawaqesModel nawaqes;
  final VoidCallback onTap;
  // final ValueChanged<bool?> onChanged;
  final int num;
  const ListTileProduct({
    Key? key,
    required this.nawaqes,
    required this.onTap,
    required this.num,
    // required this.onChanged,
  }) : super(key: key);

  @override
  State<ListTileProduct> createState() => _ListTileProductState();
}

class _ListTileProductState extends State<ListTileProduct> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 6.0,
        ),
        child: InkWell(
          onTap: () => Navigator.of(context, rootNavigator: true).pushNamed(
            AppRoutes.nawaqesDetailsRoute,
            // TODO: we need to refactor to create models for the arguments
            arguments: {
              'nawaqes': widget.nawaqes,
              'database': database,
            },
          ),
          child: ListTile(
            shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(20),
            ),
            leading: CircleAvatar(
              backgroundColor: const Color.fromARGB(255, 43, 179, 221),
              child: Text(
                widget.num.toString(),
                style: const TextStyle(color: Colors.black),
              ),
            ),
            title: Text(
              widget.nawaqes.title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            subtitle: Text('${widget.nawaqes.ammount}'),
            // trailing: Text('${widget.nawaqes.price}'),
            trailing: Checkbox(
              value: checked,
              onChanged: (newValue) {
                setState(() {
                  checked = newValue!;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
