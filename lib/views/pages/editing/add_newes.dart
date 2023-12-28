import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../models/news_modle.dart';

class AddNewsPage extends StatefulWidget {
  const AddNewsPage({super.key});

  @override
  State<AddNewsPage> createState() => _AddNewsPageState();
}

class _AddNewsPageState extends State<AddNewsPage> {
  TextEditingController textFieldController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String _imagUrl = "_imagUrl ";
  String _productName = "";
  String _productUrl = " ";

  //-------------------------------------------------- Build Context
  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    NewsModel prouct = NewsModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      imgUrl: _imagUrl,
      title: _productName,
      url: _productUrl,
    );

    Map<String, dynamic> productData = prouct.toMap();

    Future<void> addProductToFirestore(Map<String, dynamic> productData) async {
      try {
        await firestore.collection('news').add(productData);
        debugPrint('Product added to Firestore successfully!');
      } catch (e) {
        debugPrint('Error adding product to Firestore: $e');
        // Handle the error as per your application's requirements
      }
    }

    // final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add News ...."),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                //---------------------------------------------- start TextFields
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _productName = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Product Name",
                        labelText: "Product Name",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product Name cannot be empty";
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _imagUrl = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Product image",
                        labelText: "Product image",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      // Set keyboard type to number
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Product image be empty";
                        }
                        // Add more validation if needed
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: TextFormField(
                      onChanged: (value) {
                        setState(() {
                          _productUrl = value;
                        });
                      },
                      decoration: const InputDecoration(
                        hintText: "Product _product Url",
                        labelText: "Product _product Url",
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.all(8.0),
                      ),
                      // Set keyboard type to number
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "product Url before discount cannot be empty";
                        }
                        // Add more validation if needed
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                ]),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    bool result =
                        await InternetConnectionChecker().hasConnection;
                    if (result == true) {
                      // Validate the form before submission
                      if (_key.currentState!.validate()) {
                        await addProductToFirestore(productData);

                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Product added successfully!'),
                          ),
                        );
                      }
                    } else {
                      // ignore: use_build_context_synchronously
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                            'تفقد الاتصال بالانترنت',
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


//------------------------------ the text button to send data to firebase
 //  TextButton(
                //   child: const Text('OK'),
                //   onPressed: () async {
                //     // Validate the form before submission
                //     if (_key.currentState!.validate()) {
                //       // Trigger image upload if an image is selected
                //       if (_image?.path == "_imageUrl" || _image == null) {
                //         await _uploadImageToFirebase();
                //       }

                //       // Create the product object
                //       Product product = Product(
                //         id: DateTime.now().second.toString(),
                //         imgUrl: _imageUrl,
                //         price: _productPrice,
                //         qunInCarton: _productQuantity,
                //         title: _productName,
                //         category: _productCategory,
                //         script: _productScribt,

                //       );

                //       // Add the product to Firestore
                //       // debugPrint(product.title);
                //       await database.addProduct(product);

                //       // Optionally, show a success message or navigate to another screen
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         const SnackBar(
                //           content: Text('Product added successfully!'),
                //         ),
                //       );
                //     }
                //   },
                // ),
