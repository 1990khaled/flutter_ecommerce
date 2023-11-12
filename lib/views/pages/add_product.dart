import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../controllers/button_special_contrroler.dart';
import '../../controllers/database_controller.dart';
import '../../models/product.dart';
import '../widgets/main_button.dart';

class AddProduct extends StatefulWidget {
  final Product product;
  final notificationId = UniqueKey().hashCode;

  AddProduct({super.key, required this.product});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _key = GlobalKey<FormState>();
  bool _validating = false;
  bool _uploading = false;
  Map<String, dynamic> data = {};
  FirebaseStorage storage = FirebaseStorage.instance;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    var specialController = Provider.of<SpecialController>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            autovalidateMode: _validating
                ? AutovalidateMode.always
                : AutovalidateMode.disabled,
            key: _key,
            child: Column(children: [
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    data['title'] = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "your product name",
                  label: Text("Title"),
                ),
                validator: (value) {
                  if (value!.length < 4) {
                    return "Tile Can noy be less than 4 letters";
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    data['category'] = value;
                  });
                },
                minLines: 3,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: "your product category",
                  label: Text("category"),
                ),
                validator: (value) {
                  if (value!.length < 4) {
                    return "category Can noy be less than 4 letters";
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    data['price'] = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "your product price",
                  label: Text("price"),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value as double <= 0) {
                    return "price Can not be less than 0";
                  }
                  return null;
                },
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    data['qunInCarton'] = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "your product amount",
                  label: Text("amount"),
                ),
                validator: (value) {
                  if (value as int < 0) {
                    return "Amount Can not be less than 0";
                  }
                  return null;
                },
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                onChanged: (value) {
                  setState(() {
                    data['script'] = value;
                  });
                },
                decoration: const InputDecoration(
                  hintText: "your product script",
                  label: Text("script"),
                ),
                validator: (value) {
                  if (value!.length < 10) {
                    return "script Can not be less than 10 letters";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 7,
              ),
              IconButton(
                  onPressed: () {
                    showMenu(
                        context: context,
                        position: const RelativeRect.fromLTRB(200, 300, 0, 0),
                        items: [
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text('Use Cam'),
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.camera);
                              },
                            ),
                          ),
                          PopupMenuItem(
                            child: ListTile(
                              leading: const Icon(Icons.add),
                              title: const Text('Use Galary'),
                              onTap: () async {
                                ImagePicker imagePicker = ImagePicker();
                                XFile? file = await imagePicker.pickImage(
                                    source: ImageSource.gallery);
                              },
                            ),
                          )
                        ]);
                  },
                  icon: const Icon(Icons.camera_alt),
                  iconSize: 50),
              const SizedBox(
                height: 7,
              ),
              SmallMainButton(
                text: 'تحديــــث  ',
                onTap: () {},
                hasCircularBorder: true,
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
            


//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       TextButton(
//                           onPressed: () async {
//                             showDialog(
//                               context: context,
//                               builder: (_) => AlertDialog(
//                                 title: const Text("Choose image Source"),
//                                 actions: [
//                                   TextButton(
//                                     onPressed: () async {
//                                       XFile? photo = await _picker.pickImage(
//                                           source: ImageSource.camera);
//                                       Navigator.of(context).pop();
//                                       try {
//                                         setState(() {
//                                           imageFile = File(photo!.path);
//                                         });
//                                       } catch (e) {
//                                         return debugPrint(e as String?);
//                                       }
//                                     },
//                                     child: const Text("Camera"),
//                                   ),
//                                   TextButton(
//                                     onPressed: () async {
//                                       XFile? photo = await _picker.pickImage(
//                                           source: ImageSource.gallery);
//                                       Navigator.of(context).pop();
//                                       try {
//                                         setState(() {
//                                           imageFile = File(photo!.path);
//                                         });
//                                       } catch (e) {
//                                         debugPrint(e as String?);
//                                       }
//                                     },
//                                     child: const Text("Gallery"),
//                                   ),
//                                 ],
//                               ),
//                             );
//                           },
//                           child: const Text("Choose Image")),
//                       Container(
//                         width: 100,
//                         height: 100,
//                         decoration: BoxDecoration(
//                           border: Border.all(
//                             width: 1,
//                             color: Colors.grey.shade300,
//                           ),
//                         ),
//                         child: imageFile == null
//                             ? const Center(
//                                 child: Text(
//                                   "No Image Choosen",
//                                   textAlign: TextAlign.center,
//                                 ),
//                               )
//                             : Image.file(
//                                 imageFile!,
//                                 fit: BoxFit.cover,
//                               ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 _uploading
//                     ? const CircularProgressIndicator()
//                     : ElevatedButton(
//                         onPressed: () async {
//                           if (_key.currentState!.validate()) {
//                             setState(() {
//                               _uploading = true;
//                             });
//                             data['imgUrl'] = await uploadFile(imageFile!.path);
//                             // data['id'] =

//                             //     await RepositoryProvider.of<UserProvider>(
//                             //             context)
//                             //         .getUserId();
//                             // BlocProvider.of<ProductsBloc>(context)
//                             //     .add(AddProduct(data));
//                             setState(() {
//                               _uploading = false;
//                             });
//                             Navigator.of(context).pop();
//                           } else {
//                             setState(() {
//                               _validating = true;
//                             });
//                           }
//                         },
//                         child: const Text("Add Product"),
//                       ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<String?> uploadFile(String filePath) async {
//     File file = File(filePath);
//     String? imageUrl;
//     try {
//       await FirebaseStorage.instance
//           .ref('products/123456${p.extension(file.path)}')
//           .putFile(file);
//       imageUrl = await FirebaseStorage.instance
//           .ref('products/123456${p.extension(file.path)}')
//           .getDownloadURL();
//     } on FirebaseException {
//       // e.g, e.code == 'canceled'
//     }
//     return imageUrl;
//   }
// }
