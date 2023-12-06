import 'package:flutter/material.dart';

class EditUserInformation extends StatelessWidget {
  const EditUserInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// import 'dart:io';

// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_ecommerce/utilities/api_path.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:provider/provider.dart';
// import '../../controllers/database_controller.dart';
// import '../../models/user_data.dart';
// import '../../services/firestore_services.dart';

// class EditUserInformation extends StatefulWidget {
//   const EditUserInformation({
//     Key? key,
//   }) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _EditUserInformationState createState() => _EditUserInformationState();
// }

// class _EditUserInformationState extends State<EditUserInformation> {
//   final ImagePicker picker = ImagePicker();
//   late UserData userData;
//   XFile? _image;
//   bool _uploading = false;
//   String _imgUrl = "imgUrl";
//   String? _name;
//   String? _companyName;
//   String? _address;
//   String? _phoneNum;
//   late TextEditingController _nameController;
//   late TextEditingController _imgUrlController;
//   late TextEditingController _companyNameController;
//   late TextEditingController _addressController;
//   late TextEditingController _phoneNumController;

//   @override
//   void initState() {
//     super.initState();
//     // Initialize the controllers with fetched data when the page initializes
//     _nameController = TextEditingController(text: _name ?? '');
//     _imgUrlController = TextEditingController(text: _imgUrl ?? '');
//     _companyNameController = TextEditingController(text: _companyName ?? '');
//     _addressController = TextEditingController(text: _address ?? '');
//     _phoneNumController = TextEditingController(text: _phoneNum ?? '');

//     // Fetch the existing data using the newProductId when the page initializes
//     fetchNewsDetails(userData.uid);
//   }

//   Future<void> fetchNewsDetails(String uid) async {
//     // Fetch news details using the provided newsId
//     final newsDetails = await FirestoreServices.instance
//         .getData(path: ApiPath.userInformation(uid));

//     if (newsDetails != null) {
//       setState(() {
//         _name = newsDetails['name'] ?? '';
//         _imgUrl = newsDetails['imgUrl'] ?? '';
//         _companyName = newsDetails['companyName'] ?? '';
//         _address = newsDetails['address'] ?? '';
//         _phoneNum = newsDetails['phoneNum'] ?? '';

//         // Update controllers with new data
//         _nameController.text = _name ?? '';
//         _imgUrlController.text = _imgUrl ?? '';
//         _companyNameController.text = _companyName ?? '';
//         _addressController.text = _address ?? '';
//         _addressController.text = _address ?? '';
//       });
//     }
//   }

//   Future<void> _pickImage(ImageSource source) async {
//     final XFile? pickedImage = await picker.pickImage(source: source);

//     setState(() {
//       _image = pickedImage;
//     });
//   }

//   Future<void> _uploadImageToFirebase() async {
//     if (_image != null) {
//       String imageName = _imgUrlController.text; // Provide a custom image name

//       Reference storageReference =
//           FirebaseStorage.instance.ref().child('product image/$imageName');

//       String extension = _image!.path.split('.').last;

//       UploadTask uploadTask = storageReference.putFile(
//         File(_image!.path),
//         SettableMetadata(contentType: 'image/$extension'),
//       );

//       setState(() {
//         _uploading = true;
//       });

//       await uploadTask.whenComplete(() async {
//         String url = await storageReference.getDownloadURL();
//         setState(() {
//           _imgUrl = url;
//           _uploading = false;
//         });
//       });
//     }
//   }

//   Future<void> _saveUserInfo() async {
//     if (_formKey.currentState!.validate()) {
//       // Create a UserModel object

//       UserData updatedUser = UserData(
//         // Assign values from text controllers to UserModel properties
//         name: _nameController.text,
//         companyName: _companyNameController.text,
//         address: _addressController.text,
//         phoneNum: _phoneNumController.text,
//         profileImg: _imgUrlController.text,
//         access: "user",
//         email: '',
//         uid: '',
//       );

//       // Now you can use updatedUser to save or update user information
//       // For example:
//       await saveUserInformation(updatedUser);
//     }
//   }

//   Future<void> saveUserInformation(UserData user) async {
//     // Use 'user' object to save or update the user information
//     // For example, use the database controller to update user information
//     await database.updateUserInformation(user);
//   }

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final database = Provider.of<Database>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("تعديل البيانات الشخصية"),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         padding: const EdgeInsets.all(20.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               _image != null
//                   ? Image.file(File(_image!.path))
//                   : const Text('No image selected'),
//               Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     AlertDialog(
//                       actions: [
//  PopupMenuItem(
//                             child: ListTile(
//                               leading: const Icon(Icons.add),
//                               title: const Text('Use Camera'),
//                               onTap: () => _pickImage(ImageSource.camera),
//                             ),
//                           ),
//                           PopupMenuItem(
//                             child: ListTile(
//                               leading: const Icon(Icons.add),
//                               title: const Text('Use Gallery'),
//                               onTap: () => _pickImage(ImageSource.gallery),
//                             ),
//                           ),
//                       ],
//                       content: TextButton(child: const Text("تــم", style: TextStyle(fontSize: 20)),onPressed: () => Navigator.pop(context))
//                     );
//                   },
//                   child: DecoratedBox(
//                     decoration: BoxDecoration(
//                       borderRadius:
//                           const BorderRadius.all(Radius.circular(100)),
//                       border: Border.all(),
//                       color: Colors.blue[100],
//                     ),
//                     child: Stack(
//                       children: [
//                         CircleAvatar(
//                           radius: 50,
//                           backgroundImage: _image != null
//                               ? FileImage(
//                                   File(_image!.path),
//                                 )
//                               : const AssetImage('path_to_default_image')
//                                   as ImageProvider<Object>?,
//                         ),
//                         const Positioned(
//                           bottom: 6,
//                           right: 12,
//                           child: Icon(Icons.camera_alt_outlined),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _nameController,
//                 decoration: const InputDecoration(labelText: 'Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _companyNameController,
//                 decoration: const InputDecoration(labelText: 'Company Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your company name';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _addressController,
//                 decoration: const InputDecoration(labelText: 'Address'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your address';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 20),
//               TextFormField(
//                 controller: _phoneNumController,
//                 decoration: const InputDecoration(labelText: 'phone Number'),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value != null && value.isNotEmpty) {
//                     // Add email validation logic if needed
//                     // For now, it's optional
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 30),
//               ElevatedButton(
//                 onPressed: () {
//                   _uploadImageToFirebase;
//                   _saveUserInfo;
//                 },
//                 child: const Text('حفظ البيانات'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _companyNameController.dispose();
//     _addressController.dispose();
//     _phoneNumController.dispose();
//     super.dispose();
//   }
// }


// // Column / children ------------------------------------
// //  

// // IconButton(
// //                   onPressed: () {
// //                     showMenu(
// //                       context: context,
// //                       position: const RelativeRect.fromLTRB(200, 300, 0, 0),
// //                       items: [
// //                         PopupMenuItem(
// //                           child: ListTile(
// //                             leading: const Icon(Icons.add),
// //                             title: const Text('Use Camera'),
// //                             onTap: () => _getImage(ImageSource.camera),
// //                           ),
// //                         ),
// //                         PopupMenuItem(
// //                           child: ListTile(
// //                             leading: const Icon(Icons.add),
// //                             title: const Text('Use Gallery'),
// //                             onTap: () => _getImage(ImageSource.gallery),
// //                           ),
// //                         ),
// //                       ],
// //                     );
// //                   },
// //                   icon: const Icon(Icons.camera_alt),
// //                   iconSize: 50,
// //                 ),