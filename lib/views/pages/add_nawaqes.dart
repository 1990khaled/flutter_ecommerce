// import 'package:cloud_firestore/cloud_firestore;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../controllers/database_controller.dart';
import '../../models/nawqes.dart';
import '../widgets/drop_down_menu.dart';
import '../widgets/main_button.dart';

class AddNawaqespage extends StatefulWidget {
  // static Map<String, dynamic> get newdata {
  //   return data;
  // }

  final notificationId = UniqueKey().hashCode;

  AddNawaqespage({super.key});

  @override
  State<AddNawaqespage> createState() => _AddNawaqespageState();
}

// Map<String, dynamic> data = {};

class _AddNawaqespageState extends State<AddNawaqespage> {
  final database = FirestoreDatabase('123');
  final _formKey = GlobalKey<FormState>();
  final _productNameController = TextEditingController();
  final _ammountController = TextEditingController();
  final _custmNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _productNameFocusNode = FocusNode();
  final _ammountFocusNode = FocusNode();
  final _custmNameFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();

  CollectionReference nawaqesCollection =
      FirebaseFirestore.instance.collection("nawaqes");
  late String dropdownValue;
  final List<String> actors = [
    "خالد ياسين",
    "محمد المنسي",
    "مصطفى ايهاب",
    "محمد علي",
    "احمد الروبي"
  ];
  
  @override
  void dispose() {
    _productNameController.dispose();
    _ammountController.dispose();
    _custmNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  ShowingNawaqesModel nawaqesModel = ShowingNawaqesModel(
      actorName: '',
      ammount: 0,
      description: '',
      id: AddNawaqespage().notificationId.toString(),
      title: '');

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("اضافة منتج", textAlign: TextAlign.center),
        backgroundColor: Theme.of(context).primaryColorDark,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "اضافة نواقــص",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 40.0),
                    TextFormField(
                      controller: _productNameController,
                      focusNode: _productNameFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_ammountFocusNode),
                      textInputAction: TextInputAction.next,
                      // onChanged: model.updateEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'من فضلك ادخل اسم الصنف' : null,
                      decoration: const InputDecoration(
                        labelText: 'الصنف',
                        hintText: 'ادخل اسم الصنف',
                      ),

                      onChanged: (value) {
                        nawaqesModel.title = value;
                      },
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _ammountController,
                      focusNode: _ammountFocusNode,
                      validator: (val) =>
                          val!.isEmpty ? 'من فضلك ادخل الكمية المطلوبة' : null,
                      // onChanged: model.updatePassword,

                      decoration: const InputDecoration(
                        labelText: 'الكمية المطلوبة',
                        hintText: 'ادخل الكمية المطلوبة',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            nawaqesModel.ammount = int.parse(value);
                          }
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),
                    TextFormField(
                      controller: _custmNameController,
                      focusNode: _custmNameFocusNode,
                      onEditingComplete: () => FocusScope.of(context)
                          .requestFocus(_ammountFocusNode),
                      textInputAction: TextInputAction.next,
                      // onChanged: model.updateEmail,
                      validator: (val) =>
                          val!.isEmpty ? 'من فضلك ادخل اسم العميل' : null,
                      decoration: const InputDecoration(
                        labelText: 'اسم العميل',
                        hintText: 'ادخل اسم العميل',
                      ),
                      onChanged: (value) {
                        setState(() {
                          nawaqesModel.description = value;
                        });
                      },
                    ),
                    const SizedBox(height: 24.0),

                    TextFormField(
                      controller: _priceController,
                      focusNode: _priceFocusNode,
                      validator: (val) =>
                          val!.isEmpty ? 'من فضلك ادخل السعر المعروض' : null,
                      // onChanged: model.updatePassword,

                      decoration: const InputDecoration(
                        labelText: 'السعر المعروض',
                        hintText: 'ادخل السعر المعروض',
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        setState(() {
                          if (value.isNotEmpty) {
                            nawaqesModel.price = int.parse(value);
                          }
                        });
                      },
                    ),

                    const SizedBox(height: 24.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 60,
                            child: DropDownMenuComponent(
                              items: actors,
                              hint: 'اسم البائع',
                              onChanged: (String? newValue) {
                                setState(() {
                                  dropdownValue = newValue!;
                                  nawaqesModel.actorName = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    // if (model.authFormType == AuthFormType.login)
                    const Align(
                      alignment: Alignment.topRight,
                      child: Text('شركة الامين لتجارة اكسسوارات  الالومنيوم'),
                    ),
                    const SizedBox(height: 24.0),
                    MainButton(
                      text: 'اضافة',
                      onTap: () async {
                        if (_formKey.currentState!.validate()) {
                          await nawaqesCollection.add(nawaqesModel.toMap());
                           if (context.mounted) Navigator.of(context).pop();
                          // _submit(model);
                          // await database.setNawqesData(
                          //   nawaqesModel,
                          // );
                          // .then(
                          //   (value) => (value.id),
                          // );
                          // nawaqesCollection
                          //     .add( AddNawaqespage().newdata)

                          // setState(() {
                          //   _uploading = false;
                          // });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
