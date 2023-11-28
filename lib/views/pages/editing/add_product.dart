import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/product.dart';
import 'package:image_picker/image_picker.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController textFieldController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final picker = ImagePicker();
  XFile? _image;
  bool _uploading = false;

  String _imageUrl = "_imageUrl";
  String _productName = " ";
  String _productCategory = " ";
  double _productPrice = 1.0;
  int _productQuantity = 1;
  String _productScript = "";
  int _productmaximum = 5;

  Future<void> _getImage(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      _image = pickedFile;
    });
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image != null) {
      String imageName =
          textFieldController.text; // Provide a custom image name

      Reference storageReference =
          FirebaseStorage.instance.ref().child('product image/$imageName');

      String extension = _image!.path.split('.').last;

      UploadTask uploadTask = storageReference.putFile(
        File(_image!.path),
        SettableMetadata(contentType: 'image/$extension'),
      );

      setState(() {
        _uploading = true;
      });

      await uploadTask.whenComplete(() async {
        String url = await storageReference.getDownloadURL();
        setState(() {
          _imageUrl = url;
          _uploading = false;
        });
      });
    }
  }

  Future<String?> _getImageName() {
    Completer<String?> completer = Completer();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Image Name'),
          content: TextField(
            controller: textFieldController,
            decoration: const InputDecoration(hintText: "Image Name"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () async {
                _uploadImageToFirebase();
                _uploading
                    ? const CircularProgressIndicator()
                    : Navigator.of(context).pop(textFieldController.text);
              },
            ),
            const SizedBox(
              width: 20,
            ),
            TextButton(
              child: const Text('done'),
              onPressed: () async {
                Navigator.of(context).pop(textFieldController.text);
              },
            ),
          ],
        );
      },
    ).then((value) {
      completer.complete(value);
    });

    return completer.future;
  }

  //------------------------------------------------------------ all above are Functions --Start UI--------
  @override
  Widget build(BuildContext context) {
    //-------------------------------------------------- Build Context
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    Product prouct = Product(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      imgUrl: _imageUrl,
      price: _productPrice,
      qunInCarton: _productQuantity,
      title: _productName,
      category: _productCategory,
      script: _productScript,
      maximum: _productmaximum,
    );
    Map<String, dynamic> productData = prouct.toMap();

    Future<void> addProductToFirestore(Map<String, dynamic> productData) async {
      try {
        await firestore.collection('products').add(productData);
        debugPrint('Product added to Firestore successfully!');
      } catch (e) {
        debugPrint('Error adding product to Firestore: $e');
        // Handle the error as per your application's requirements
      }
    }

    // final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _key,
          child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: <Widget>[
                _image != null
                    ? Image.file(File(_image!.path))
                    : const Text('No image selected'),
                IconButton(
                  onPressed: () {
                    showMenu(
                      context: context,
                      position: const RelativeRect.fromLTRB(200, 300, 0, 0),
                      items: [
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.add),
                            title: const Text('Use Camera'),
                            onTap: () => _getImage(ImageSource.camera),
                          ),
                        ),
                        PopupMenuItem(
                          child: ListTile(
                            leading: const Icon(Icons.add),
                            title: const Text('Use Gallery'),
                            onTap: () => _getImage(ImageSource.gallery),
                          ),
                        ),
                      ],
                    );
                  },
                  icon: const Icon(Icons.camera_alt),
                  iconSize: 50,
                ),
                const SizedBox(height: 10),
                _uploading
                    ? const CircularProgressIndicator()
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: _getImageName,
                            child: const Text('Upload Image'),
                          ),
                          if (_imageUrl != "_imageUrl")
                            Image.network(
                              _imageUrl,
                              height: 30,
                              width: 40,
                            ),
                        ],
                      ),
                const SizedBox(
                  height: 10,
                ),

                //---------------------------------------------- start TextFields
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: TextFormField(
                        onChanged: (value) {
                          _productName = value;
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
                          _productScript = value;
                        },
                        decoration: const InputDecoration(
                          hintText: "_productScript",
                          labelText: "_productScript",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "_productScript cannot be empty";
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
                          if (value.isNotEmpty) {
                            // Check if the value is not empty
                            setState(() {
                              try {
                                // Try parsing the input to double
                                _productPrice = double.parse(value);
                              } catch (e) {
                                // Handle if the input cannot be parsed to double
                                Center(child: Text("Invalid input: $e"));
                                _productPrice = 1.0;
                              }
                            });
                          } else {
                            // Handle empty input scenario here if needed
                            _productPrice = 1.0;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Product Price",
                          labelText: "Product Price",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Product Price cannot be empty";
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
                          _productCategory = value;
                        },
                        decoration: const InputDecoration(
                          hintText: "Product Category",
                          labelText: "Product Category",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Product Category cannot be empty";
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
                          if (value.isNotEmpty) {
                            // Check if the value is not empty
                            setState(() {
                              try {
                                // Try parsing the input to double
                                _productQuantity = int.parse(value);
                              } catch (e) {
                                // Handle if the input cannot be parsed to double
                                debugPrint("Invalid input: $e");
                                _productQuantity = 1;
                              }
                            });
                          } else {
                            // Handle empty input scenario here if needed
                            _productQuantity = 1;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Product Carton Quantity",
                          labelText: "Product Carton Quantity",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Product Carton Quantity cannot be empty";
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
                          if (value.isNotEmpty) {
                            // Check if the value is not empty
                            setState(() {
                              try {
                                // Try parsing the input to double
                                _productmaximum = int.parse(value);
                              } catch (e) {
                                // Handle if the input cannot be parsed to double
                                debugPrint("Invalid input: $e");
                                _productmaximum = 1;
                              }
                            });
                          } else {
                            // Handle empty input scenario here if needed
                            _productmaximum = 1;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Product maximum Quan",
                          labelText: "Product maximum Quan",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Product Max Quan cannot be empty";
                          }
                          // Add more validation if needed
                          return null;
                        },
                      ),
                    ),
                  ],
                  //----------------------------------------------------------------------
                ),
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () async {
                    // Validate the form before submission
                    if (_key.currentState!.validate()) {
                      // Trigger image upload if an image is selected
                      if (_image?.path == "_imageUrl" || _image == null) {
                        await _uploadImageToFirebase();
                      }

                      // Create the product object

                      // Add the product to Firestore
                      // debugPrint(product.title);
                      await addProductToFirestore(productData);

                      // Optionally, show a success message or navigate to another screen
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Product added successfully!'),
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
