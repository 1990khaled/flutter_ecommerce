import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/database_controller.dart';
import '../../../models/new_product.dart';
import '../../../services/firestore_services.dart';

class NewProductEditing extends StatefulWidget {
  final String newProductId;
  const NewProductEditing({super.key, required this.newProductId});

  @override
  State<NewProductEditing> createState() => _NewProductEditingState();
}

class _NewProductEditingState extends State<NewProductEditing> {
  late TextEditingController _titleController;
  late TextEditingController _imgUrlController;
  late TextEditingController _scriptController;
  late TextEditingController _priceController;
  late TextEditingController _discountValueController;
  late TextEditingController _qunInCartonController;
  late TextEditingController _maximumController;
  late TextEditingController _minimumController;

  String? _title;
  String? _imgUrl;
  String? _script;
  double? _price;
  double? _discountValue;
  int? _qunInCarton;
  int? _maximum;
  int? _minimum;

  @override
  void initState() {
    super.initState();
    // Initialize the controllers with fetched data when the page initializes
    _titleController = TextEditingController(text: _title ?? '');
    _imgUrlController = TextEditingController(text: _imgUrl ?? '');
    _scriptController = TextEditingController(text: _script ?? '');

    _priceController =
        TextEditingController(text: _price != null ? _price!.toString() : '');
    _discountValueController = TextEditingController(
        text: _discountValue != null ? _discountValue!.toString() : '');
    _qunInCartonController = TextEditingController(
        text: _qunInCarton != null ? _qunInCarton!.toString() : '');
    _maximumController = TextEditingController(
        text: _maximum != null ? _maximum!.toString() : '');
    _minimumController = TextEditingController(
        text: _minimum != null ? _minimum!.toString() : '');

    // Fetch the existing data using the newProductId when the page initializes
    fetchNewsDetails();
  }

  Future<void> fetchNewsDetails() async {
    // Fetch news details using the provided newsId
    final newsDetails = await FirestoreServices.instance
        .getData(path: "newproduct/${widget.newProductId}");

    if (newsDetails != null) {
      setState(() {
        _title = newsDetails['title'] ?? '';
        _imgUrl = newsDetails['imgUrl'] ?? '';
        _script = newsDetails['script'] ?? '';
        _price = (newsDetails['price'] ?? 0.0).toDouble();
        _discountValue = (newsDetails['discountValue'] ?? 0.0).toDouble();
        _qunInCarton = (newsDetails['qunInCarton'] ?? 0).toInt();
        _maximum = (newsDetails['maximum'] ?? 0).toInt();
        _minimum = (newsDetails['minimum'] ?? 0).toInt();

        // Update controllers with new data
        _titleController.text = _title ?? '';
        _imgUrlController.text = _imgUrl ?? '';
        _scriptController.text = _script ?? '';
        _priceController.text = _price != null ? _price.toString() : '';
        _discountValueController.text =
            _discountValue != null ? _discountValue.toString() : '';
        _qunInCartonController.text =
            _qunInCarton != null ? _qunInCarton.toString() : '';
        _maximumController.text = _maximum != null ? _maximum.toString() : '';
        _minimumController.text = _minimum != null ? _minimum.toString() : '';
      });
    }
  }

  bool _updating = false;

  @override
  Widget build(BuildContext context) {
    final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit New offer'),
      ),
      body: _updating
          ? const Center(
              child:
                  CircularProgressIndicator(), // Display CircularProgressIndicator while updating
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _titleController,
                        decoration:
                            const InputDecoration(labelText: 'Edit Title'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _imgUrlController,
                        decoration:
                            const InputDecoration(labelText: 'Edit Image URL'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _scriptController,
                        decoration: const InputDecoration(
                            labelText: 'Edit _scriptController'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _qunInCartonController,
                        decoration: const InputDecoration(
                            labelText: 'Edit _qunInCartonController'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _priceController,
                        decoration: const InputDecoration(
                            labelText: 'Edit _priceController'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _minimumController,
                        decoration: const InputDecoration(
                            labelText: 'Edit _minimumController'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _maximumController,
                        decoration: const InputDecoration(
                            labelText: 'Edit _maximumController'),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      child: TextFormField(
                        controller: _discountValueController,
                        decoration: const InputDecoration(
                            labelText: 'Edit _discountValueController'),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          _updating = true; // Show CircularProgressIndicator
                        });

                        final NewProduct updatedNews = NewProduct(
                          id: widget.newProductId,
                          title: _titleController.text,
                          imgUrl: _imgUrlController.text,
                          price: double.parse(_priceController.text),
                          qunInCarton: int.parse(_qunInCartonController.text),
                          discountValue:
                              double.parse(_discountValueController.text),
                          maximum: int.parse(_maximumController.text),
                          minimum: int.parse(_minimumController.text),
                          script: _scriptController.text,
                        );

                        try {
                          // Update Firestore data
                          await database.updateNewProduct(updatedNews);
                          debugPrint(
                              "${updatedNews.title} ---------------------------------------------------");

                          // Navigate back after successful update
                          Navigator.pop(context);
                        } catch (e) {
                          // Handle Firestore update errors
                          debugPrint("Firestore update error: $e");
                          setState(() {
                            _updating =
                                false; // Hide CircularProgressIndicator on error
                          });
                        }
                      },
                      child: const Text('Save Changes'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
