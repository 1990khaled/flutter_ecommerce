import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../controllers/database_controller.dart';
import '../../models/user_data.dart';
// Import your necessary files/models/controllers

class AddUserInfoFirstTime extends StatefulWidget {
  const AddUserInfoFirstTime({
    Key? key,
  }) : super(key: key);

  @override
  _AddUserInfoFirstTimeState createState() => _AddUserInfoFirstTimeState();
}

class _AddUserInfoFirstTimeState extends State<AddUserInfoFirstTime> {
  final _formKey = GlobalKey<FormState>();
  final ImagePicker picker = ImagePicker();
  late UserData userData;
  XFile? _image;
  bool _uploading = false;
  String _imgUrl = "imgUrl";
  late TextEditingController _nameController;
  late TextEditingController _companyNameController;
  late TextEditingController _addressController;
  late TextEditingController _phoneNumController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _companyNameController = TextEditingController();
    _addressController = TextEditingController();
    _phoneNumController = TextEditingController();
  }

  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
      });
    }
  }

  String autonamed() {
    String name = DateTime.now().microsecondsSinceEpoch as String;
    return name;
  }

  Future<void> _uploadImageToFirebase() async {
    if (_image != null) {
      Reference storageReference =
          FirebaseStorage.instance.ref().child('user profile img/$autonamed');

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
        // Handle upload failure
        print('Error: $e');
        if (mounted) {
          setState(() {
            _uploading = false;
          });
        }
      }
    }
  }

  // Future<void> _uploadImageToFirebase() async {
  //   if (_image != null) {
  //     Reference storageReference =
  //         FirebaseStorage.instance.ref().child('user profile img/$_imgUrl');

  //     String extension = _image!.path.split('.').last;

  //     UploadTask uploadTask = storageReference.putFile(
  //       File(_image!.path),
  //       SettableMetadata(contentType: 'image/$extension'),
  //     );

  //     setState(() {
  //       _uploading = true;
  //     });

  //     uploadTask.whenComplete(() async {
  //       String url = await storageReference.getDownloadURL();

  //       setState(() {
  //         _imgUrl = url;
  //         _uploading = false;
  //       });
  //     });
  //   }
  // }
  Future<void> _saveUserInfo() async {
    if (_formKey.currentState!.validate()) {
      UserModel updatedUser = UserModel(
        name: _nameController.text,
        companyName: _companyNameController.text,
        address: _addressController.text,
        phoneNum: _phoneNumController.text,
        profileImg: _imgUrl,
        access: "user",
        id: "npyZVhIDq34g3vTR7Prq",
      );

      try {
        await saveUserInformation(updatedUser);
        print('User information saved successfully!');
      } catch (e) {
        print('Error saving user information: $e');
        // Handle error if saving fails
      }
    }
  }

  Future<void> saveUserInformation(UserModel user) async {
    final database = Provider.of<Database>(context, listen: false);
    await database.setUserInfo(user);
  }

  // Future<void> _saveUserInfo() async {
  //   if (_formKey.currentState!.validate()) {
  //     UserModel updatedUser = UserModel(
  //       name: _nameController.text,
  //       companyName: _companyNameController.text,
  //       address: _addressController.text,
  //       phoneNum: _phoneNumController.text,
  //       profileImg: _imgUrl,
  //       access: "user",
  //       id: "npyZVhIDq34g3vTR7Prq",
  //     );

  //     await saveUserInformation(updatedUser);
  //   }
  // }

  // Future<void> saveUserInformation(UserModel user) async {
  //   final database =
  //       Provider.of<Database>(context, listen: false); // Add listen: false here
  //   await database.setUserInfo(user);
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("تعديل البيانات الشخصية"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // _image != null
              //     ? Image.file(File(_image!.path))
              //     : const Text('No image selected'),
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
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(100)),
                      border: Border.all(),
                      color: Colors.blue[100],
                    ),
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: _image != null
                              ? FileImage(
                                  File(_image!.path),
                                )
                              : const AssetImage('path_to_default_image')
                                  as ImageProvider<Object>?,
                        ),
                        const Positioned(
                          bottom: 6,
                          right: 12,
                          child: Icon(Icons.camera_alt_outlined),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل الاسم';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _companyNameController,
                decoration: const InputDecoration(labelText: 'اسم الشركة'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل اسم الشركة';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'العنوان'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل العنوان';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _phoneNumController,
                decoration: const InputDecoration(labelText: 'رقم التليفون'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'من فضلك ادخل احدى عشر رقما';
                  } else if (value.length != 11 ||
                      int.tryParse(value) == null) {
                    return 'من فضلك ادخل رقم هاتف صحيحاً مكون من 11 رقم';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: () async {
                  if (!mounted) {
                    return; // Check if the widget is still mounted
                  }

                  setState(() {
                    _uploading = true; // Set uploading flag to true
                  });

                  try {
                    await _uploadImageToFirebase(); // Wait for image upload

                    if (!mounted) {
                      return; // Check again if the widget is still mounted
                    }

                    // Image uploaded successfully
                    _saveUserInfo();

                    if (mounted) {
                      Navigator.pop(
                          context); // Navigate back if widget is still mounted
                    }
                  } catch (e) {
                    // Handle upload failure
                    print('Error: $e');
                    if (mounted) {
                      setState(() {
                        _uploading = false; // Set uploading flag back to false
                      });
                    }
                  }
                },
                child: _uploading
                    ? const Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(Icons.save), // Your icon to represent saving
                          CircularProgressIndicator(), // Circular progress indicator
                        ],
                      )
                    : Icon(Icons.save), // Show regular icon when not uploading
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _companyNameController.dispose();
    _addressController.dispose();
    _phoneNumController.dispose();
    super.dispose();
  }
}
