import 'package:flutter/material.dart';

import '../widgets/drop_down_menu.dart';
import '../widgets/main_button.dart';

class AddOfferpage extends StatefulWidget {
  const AddOfferpage({super.key});

  @override
  State<AddOfferpage> createState() => _AddOfferpageState();
}

class _AddOfferpageState extends State<AddOfferpage> {
  final _formKey = GlobalKey<FormState>();
  final _ammountController = TextEditingController();
  final _custmNameController = TextEditingController();
  final _priceController = TextEditingController();
  final _ammountFocusNode = FocusNode();
  final _custmNameFocusNode = FocusNode();
  final _priceFocusNode = FocusNode();
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
    _ammountController.dispose();
    _custmNameController.dispose();
    _priceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("اضافة عرض", textAlign: TextAlign.center),
          backgroundColor: Theme.of(context).primaryColorDark,
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "اضافة عرض",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  const SizedBox(height: 40.0),
                   
                  TextFormField(
                    controller: _custmNameController,
                    focusNode: _custmNameFocusNode,
                    onEditingComplete: () =>
                        FocusScope.of(context).requestFocus(_ammountFocusNode),
                    textInputAction: TextInputAction.next,
                    // onChanged: model.updateEmail,
                    validator: (val) =>
                        val!.isEmpty ? 'من فضلك ادخل اسم العميل' : null,
                    decoration: const InputDecoration(
                      labelText: 'اسم العميل',
                      hintText: 'ادخل اسم العميل',
                    ),
                  ),
            const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _ammountController,
                    focusNode: _ammountFocusNode,
                    validator: (val) =>
                        val!.isEmpty ? 'من فضلك ادخل الكمية المتاحة' : null,
                    // onChanged: model.updatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'الكمية المتاحة',
                      hintText: 'ادخل الكمية المتاحة',
                    ),
                  ),
                 
                  const SizedBox(height: 24.0),
                  TextFormField(
                    controller: _priceController,
                    focusNode: _priceFocusNode,
                    validator: (val) =>
                        val!.isEmpty ? 'من فضلك ادخل السعر المتوفر' : null,
                    // onChanged: model.updatePassword,
                    obscureText: true,
                    decoration: const InputDecoration(
                      labelText: 'السعر المتوفر',
                      hintText: 'ادخل السعر المتوفر',
                    ),
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
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // _submit(model);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )));
  }
}
