import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/database_controller.dart';

class EditNewProduct extends StatelessWidget {
  const EditNewProduct({super.key});
  // final Product product;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold();
  }
}