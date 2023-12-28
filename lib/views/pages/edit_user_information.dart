import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/utilities/api_path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../controllers/database_controller.dart';
import '../../models/user_data.dart';
import '../../services/firestore_services.dart';
import '../../utilities/constants.dart';

class EditUserInformation extends StatefulWidget {
  const EditUserInformation({
    super.key,
  });

  @override
  // ignore: library_private_types_in_public_api
  _EditUserInformationState createState() => _EditUserInformationState();
}

class _EditUserInformationState extends State<EditUserInformation> {
  final user = FirebaseAuth.instance.currentUser;
  final ImagePicker picker = ImagePicker();
  late UserData userData;
  XFile? _image;
  bool _uploading = false;
  String _imgUrl = "imgUrl";
  String _companyName = '';
  String _address = '';
  late TextEditingController _imgUrlController;
  late TextEditingController _companyNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumController;

  @override
  void initState() {
    super.initState();
    String phoneNumber = user!.phoneNumber ?? '';
    _imgUrlController = TextEditingController(text: _imgUrl);
    _companyNameController = TextEditingController(text: _companyName);
    _addressController = TextEditingController(text: _address);
    _phoneNumController = TextEditingController(text: phoneNumber);

    // Fetch the existing data using the newProductId when the page initializes
    fetchNewsDetails(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> fetchNewsDetails(String uid) async {
    // Fetch news details using the provided newsId
    final newsDetails = await FirestoreServices.instance
        .getData(path: ApiPath.getUserInformation(uid));

    if (newsDetails != null) {
      setState(() {
        _imgUrl = newsDetails['profileImg'] ?? '';
        _companyName = newsDetails['companyName'] ?? '';
        _address = newsDetails['address'] ?? '';

        // Update controllers with new data

        _imgUrlController.text = _imgUrl;
        _companyNameController.text = _companyName;
        _addressController.text = _address;
      });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _imgUrl = pickedImage.path;
      });
    }
  }

  String name = documentIdFromLocalData();

  Future<void> _uploadImageToFirebase() async {
    if (_image != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user profile img/$name');

      String extension = _image!.path.split('.').last;

      UploadTask uploadTask = storageReference.putFile(
        File(_image!.path),
        SettableMetadata(contentType: 'image/$extension'),
      );

      try {
        setState(() {
          _uploading = true;
        });

        String url = await (await uploadTask).ref.getDownloadURL();

        if (!mounted) {
          return; // Check if the widget is still mounted
        }

        setState(() {
          _imgUrl = url;
          _uploading = false;
        });

        // Now that the state is updated, proceed to save user information
        _saveUserInfo();
      } catch (e) {
        const Center(child: Text('مشكلة بالاتصال'));
        if (mounted) {
          setState(() {
            _uploading = false;
          });
        }
      }
    }
  }

  Future<void> _saveUserInfo() async {
    if (_formKey.currentState!.validate()) {
      UserModel updatedUser = UserModel(
        companyName: _companyNameController.text,
        address: _addressController.text,
        phoneNum: _phoneNumController.text,
        profileImg: _imgUrl,
        access: "user",
        id: "npyZVhIDq34g3vTR7Prq",
      );
      try {
        await saveUserInformation(updatedUser);
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('تمت اضافة البيانات', textAlign: TextAlign.center),
          ),
        );
      } catch (e) {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'مشكلة بالاتصال حاول مرة اخرى',
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    }
  }

  Future<void> saveUserInformation(UserModel user) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.setUserInfo(user);
  }

  final _formKey = GlobalKey<FormState>();
//-------------------------------------------------------------------------
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Consumer<AuthController>(builder: (_, model, __) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("تعديل البيانات الشخصية"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            actions: [
                              PopupMenuItem(
                                child: ListTile(
                                  leading: const Icon(Icons.add),
                                  title: const Text('استخدم الكاميرا'),
                                  onTap: () => _pickImage(ImageSource.camera),
                                ),
                              ),
                              PopupMenuItem(
                                child: ListTile(
                                  leading: const Icon(Icons.add),
                                  title: const Text('استخدم المعرض'),
                                  onTap: () => _pickImage(ImageSource.gallery),
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: TextButton(
                                  child: const Text("تــم",
                                      style: TextStyle(fontSize: 20)),
                                  onPressed: () => Navigator.pop(context),
                                ),
                              )
                            ],
                          ),
                        );
                      },
                      child: SizedBox(
                        width: size.height * 0.40,
                        height: size.height * 0.40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(45),
                          child: _image != null
                              ? Image.file(
                                  File(_image!
                                      .path), // Display the user-selected image
                                  fit: BoxFit.cover,
                                  errorBuilder: (BuildContext context,
                                      Object exception,
                                      StackTrace? stackTrace) {
                                    return Container(
                                      color: Colors
                                          .grey, // Placeholder color for the error case
                                    );
                                  },
                                )
                              : (_imgUrl.isNotEmpty && _imgUrl != "imgUrl")
                                  ? Image.network(
                                      _imgUrl, // Display the image from the database
                                      fit: BoxFit.cover,
                                      errorBuilder: (BuildContext context,
                                          Object exception,
                                          StackTrace? stackTrace) {
                                        return Container(
                                          color: Colors.grey,
                                          child: const Text(
                                            "اضغط لاختيار صورة",
                                            textAlign: TextAlign.center,
                                          ),
                                        );
                                      },
                                    )
                                  : Container(
                                      color: Colors.grey,
                                      child: const Text(
                                        "اضغط لاختيار صورة",
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                        ),
                      )),
                ),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _companyNameController,
                    decoration: const InputDecoration(labelText: 'اسم الشركة'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل اسم الشركة';
                      }
                      return null;
                    },
                    onChanged: model.updateCompanyName,
                  ),
                ),
                const SizedBox(height: 20),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(labelText: 'العنوان'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'من فضلك ادخل العنوان';
                      }
                      return null;
                    },
                    onChanged: model.updateAddress,
                  ),
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: _uploading
                      ? null
                      : () async {
                          bool result =
                              await InternetConnectionChecker().hasConnection;
                          if (result == true) {
                            if (_formKey.currentState!.validate()) {
                              if (!mounted) {
                                return;
                              }

                              setState(() {
                                _uploading = true;
                              });
                              try {
                                await _uploadImageToFirebase();
                                if (!mounted) {
                                  return;
                                }
                                _saveUserInfo();
                                if (mounted) {
                                  Navigator.pop(context);
                                }
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text('مشكلة بالاتصال حاول مرة اخرى'),
                                  ),
                                );
                              } finally {
                                if (mounted) {
                                  setState(() {
                                    _uploading =
                                        false; // Set uploading flag back to false
                                  });
                                }
                              }
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
                  child: _uploading
                      ? const Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                                color: Colors
                                    .white), // Circular progress indicator
                          ],
                        )
                      : const Text(
                          'حفظ البيانات', // Show regular text when not uploading
                        ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
