import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controllers/database_controller.dart';

class Favorite extends StatelessWidget {
  const Favorite({super.key});
  // final Product product;

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    final database = Provider.of<Database>(context);
    return Scaffold();
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import '../../controllers/database_controller.dart';
// import '../../models/offer_model.dart';
// import '../widgets/drop_down_menu.dart';
// import '../widgets/main_button.dart';

// class AddOfferpage extends StatefulWidget {
//   final notificationId = UniqueKey().hashCode;
//   AddOfferpage({super.key});

//   @override
//   State<AddOfferpage> createState() => _AddOfferpageState();
// }

// class _AddOfferpageState extends State<AddOfferpage> {
//   final database = FirestoreDatabase('123');
//   final _formKey = GlobalKey<FormState>();
//   final _ammountController = TextEditingController();
//   final _custmNameController = TextEditingController();
//   final _priceController = TextEditingController();
//   final _ammountFocusNode = FocusNode();
//   final _custmNameFocusNode = FocusNode();
//   final _priceFocusNode = FocusNode();
//   late String dropdownValue;
//   CollectionReference nawaqesCollection =
//       FirebaseFirestore.instance.collection("actorsOffers");
//   final List<String> actors = [
//     "خالد ياسين",
//     "محمد المنسي",
//     "مصطفى ايهاب",
//     "محمد علي",
//     "احمد الروبي"
//   ];
//   final List<String> typeOfAmmount = ["قطعة", "كرتونة", "شوال", "علبة", "طقم" , "لفة"];
//   @override
//   void dispose() {
//     _ammountController.dispose();
//     _custmNameController.dispose();
//     _priceController.dispose();
//     super.dispose();
//   }

//   OfferModel offerModel = OfferModel(
//       actorName: '',
//       requiestAmmount: 0,
//       customerName: '',
//       id: AddOfferpage().notificationId.toString(),
//       typeOfAmmount: '');

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text("اضافة عرض", textAlign: TextAlign.center),
//           backgroundColor: Theme.of(context).primaryColorDark,
//         ),
//         body: SafeArea(
//             child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Column(
//                 // crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "اضافة عرض",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.headlineMedium,
//                   ),
//                   const SizedBox(height: 40.0),

//                   TextFormField(
//                     controller: _custmNameController,
//                     focusNode: _custmNameFocusNode,
//                     onEditingComplete: () =>
//                         FocusScope.of(context).requestFocus(_ammountFocusNode),
//                     textInputAction: TextInputAction.next,
//                     // onChanged: model.updateEmail,
//                     validator: (val) =>
//                         val!.isEmpty ? 'من فضلك ادخل اسم المورد' : null,
//                     decoration: const InputDecoration(
//                       labelText: 'اسم المورد',
//                       hintText: 'ادخل اسم المورد',
//                     ),
//                     onChanged: (value) {
//                       offerModel.customerName = value;
//                     },
//                   ),
//                   const SizedBox(height: 24.0),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       SizedBox(
//                         width: size.width * 0.6,
//                         child: TextFormField(
//                           controller: _ammountController,
//                           focusNode: _ammountFocusNode,
//                           validator: (val) => val!.isEmpty
//                               ? 'من فضلك ادخل الكمية المتاحة'
//                               : null,
//                           // onChanged: model.updatePassword,
//                           keyboardType: TextInputType.number,

//                           decoration: const InputDecoration(
//                             labelText: 'الكمية المتاحة',
//                             hintText: 'ادخل الكمية المتاحة',
//                           ),
//                           onChanged: (value) {
//                             setState(() {
//                               if (value.isNotEmpty) {
//                                 offerModel.requiestAmmount = int.parse(value);
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         // height: 60,
//                         width: size.width * 0.33,
//                         child: DropDownMenuComponent(
//                           items: typeOfAmmount,
//                           hint: 'نوع الكمية',
//                           onChanged: (String? newValue) {
//                             setState(() {
//                               dropdownValue = newValue!;
//                               offerModel.typeOfAmmount = newValue;
//                             });
//                           },
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 24.0),
//                   TextFormField(
//                     controller: _priceController,
//                     focusNode: _priceFocusNode,
//                     validator: (val) =>
//                         val!.isEmpty ? 'من فضلك ادخل السعر المتوفر' : null,
//                     // onChanged: model.updatePassword,
                    
//                     decoration: const InputDecoration(
//                       labelText: 'السعر المتوفر',
//                       hintText: 'ادخل السعر المتوفر',
//                     ),
//                     onChanged: (value) {
//                       setState(() {
//                         if (value.isNotEmpty) {
//                           offerModel.offeringPrice = int.parse(value);
//                         }
//                       });
//                     },
//                   ),

//                   const SizedBox(height: 24.0),
//                   SizedBox(
//                     height: 60,
//                     child: DropDownMenuComponent(
//                       items: actors,
//                       hint: 'اسم البائع',
//                       onChanged: (String? newValue) {
//                         setState(() {
//                           dropdownValue = newValue!;
//                           offerModel.actorName = newValue;
//                         });
//                       },
//                     ),
//                   ),
//                   const SizedBox(height: 16.0),
//                   // if (model.authFormType == AuthFormType.login)
//                   const Align(
//                     alignment: Alignment.topRight,
//                     child: Text('شركة الامين لتجارة اكسسوارات  الالومنيوم'),
//                   ),
//                   const SizedBox(height: 24.0),
//                   MainButton(
//                     text: 'اضافة',
//                     onTap: () async {
//                       if (_formKey.currentState!.validate()) {
//                         await nawaqesCollection.add(offerModel.toMap());
//                            if (context.mounted) Navigator.of(context).pop();
//                         // _submit(model);
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         )));
//   }
// }

