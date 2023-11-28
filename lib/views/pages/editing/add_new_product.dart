import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/new_product.dart';

class AddNewProductPage extends StatefulWidget {
  const AddNewProductPage({super.key});

  @override
  _AddNewProductPageState createState() => _AddNewProductPageState();
}

class _AddNewProductPageState extends State<AddNewProductPage> {
  TextEditingController textFieldController = TextEditingController();

  final _key = GlobalKey<FormState>();
  final picker = ImagePicker();
  XFile? _image;
  bool _uploading = false;

  String _imageUrl = "_imageUrl";
  String _productName = " ";
  double _productDiscountValue = 1.0;
  double _productPrice = 1.0;
  int _productQuantity = 1;
  String _productScript = " ";
  int _productMax = 25;
  int _productMini = 5;

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
    NewProduct prouct = NewProduct(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      imgUrl: _imageUrl,
      price: _productPrice,
      qunInCarton: _productQuantity,
      title: _productName,
      discountValue: _productDiscountValue,
      script: _productScript,
      maximum: _productMax,
      minimum: _productMini,
    );
    Map<String, dynamic> productData = prouct.toMap();

    Future<void> addProductToFirestore(Map<String, dynamic> productData) async {
      try {
        await firestore.collection('newproduct').add(productData);
        debugPrint('Product added to Firestore successfully!');
      } catch (e) {
        debugPrint('Error adding product to Firestore: $e');
        // Handle the error as per your application's requirements
      }
    }

    // final database = Provider.of<Database>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("offer New Product"),
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
                          if (value.isNotEmpty) {
                            // Check if the value is not empty
                            setState(() {
                              try {
                                // Try parsing the input to double
                                _productDiscountValue = double.parse(value);
                              } catch (e) {
                                // Handle if the input cannot be parsed to double
                                Center(child: Text("Invalid input: $e"));
                                _productDiscountValue = 1.0;
                              }
                            });
                          } else {
                            // Handle empty input scenario here if needed
                            _productDiscountValue = 1.0;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "Product price before discount",
                          labelText: "Product price before discount",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Product price before discount cannot be empty";
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
                                _productMax = int.parse(value);
                              } catch (e) {
                                // Handle if the input cannot be parsed to double
                                debugPrint("Invalid input: $e");
                                _productMax = 1;
                              }
                            });
                          } else {
                            // Handle empty input scenario here if needed
                            _productMax = 1;
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
                                _productMini = int.parse(value);
                              } catch (e) {
                                // Handle if the input cannot be parsed to double
                                debugPrint("Invalid input: $e");
                                _productMini = 1;
                              }
                            });
                          } else {
                            // Handle empty input scenario here if needed
                            _productMini = 1;
                          }
                        },
                        decoration: const InputDecoration(
                          hintText: "_productMini Quan",
                          labelText: "_productMini Quan",
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(8.0),
                        ),
                        keyboardType:
                            TextInputType.number, // Set keyboard type to number
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "_productMini Quan cannot be empty";
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
