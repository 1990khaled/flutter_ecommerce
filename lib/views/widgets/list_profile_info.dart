import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import 'package:provider/provider.dart';

import '../../controllers/auth_controller.dart';
import '../../utilities/custom_material.dart';
import '../pages/editing/my_special_button.dart';

class ListProfileInfo extends StatefulWidget {
  final UserModel userModel;

  const ListProfileInfo({
    super.key,
    required this.userModel,
  });

  @override
  State<ListProfileInfo> createState() => _ListProfileInfoState();
}

class _ListProfileInfoState extends State<ListProfileInfo> {
  @override
  Widget build(BuildContext context) {
    CustomMaterialColor customMaterialColor =
        CustomMaterialColor(0, 27, 69, 118);
    final size = MediaQuery.of(context).size;
    return Consumer<AuthController>(builder: (_, model, __) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            width: size.height * 0.40,
            height: size.height * 0.40,
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(45)),
              child: Image.network(
                widget.userModel.profileImg,
                width: size.height * 0.20,
                height: size.height * 0.20,
                fit: BoxFit.cover,
                errorBuilder: (BuildContext context, Object exception,
                    StackTrace? stackTrace) {
                  return Container(
                    width: size.height * 0.20,
                    height: size.height * 0.20,
                    color: Colors.grey, // Placeholder color for the error case
                    // You can also add an icon or text to indicate the error
                  );
                },
              ),
            ),
          ),

          SmallField(
              size: size,
              customMaterialColor: customMaterialColor,
              widget: widget,
              describe: widget.userModel.companyName,
              constDescribe: "اسم الشركة"),
          // const SizedBox(height: 8),
          SmallField(
              size: size,
              customMaterialColor: customMaterialColor,
              widget: widget,
              describe: widget.userModel.phoneNum,
              constDescribe: "رقم الموبايل"),
          // const SizedBox(height: 8),

          SmallField(
            size: size,
            customMaterialColor: customMaterialColor,
            widget: widget,
            describe: widget.userModel.address,
            constDescribe: "العنوان",
          ),
          // const SizedBox(height: 8),
          //----------------------------------------------
          if (widget.userModel.access == "adminRole")
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color(0xFF1B4571),
                    width: 2,
                  ),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MySpecialButtonWidget(
                                phoneNum: widget.userModel.phoneNum,
                                access: widget.userModel.access,
                              )));
                    },
                    icon: const Icon(Icons.library_add))),
        ],
      );
    });
  }
}

class SmallField extends StatelessWidget {
  final Size size;
  final CustomMaterialColor customMaterialColor;
  final ListProfileInfo widget;
  final String describe;
  final String constDescribe;
  const SmallField({
    super.key,
    required this.size,
    required this.customMaterialColor,
    required this.widget,
    required this.describe,
    required this.constDescribe,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Container(
              height: size.height * 0.05,
              width: size.height * 0.30,
              // margin: const EdgeInsets.only(left: 4, right: 4),
              // padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: const BoxDecoration(
                color: Color(0xFF1B4571),
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFF1B4571),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  describe.split(' ').take(6).join(' '),
                  maxLines: 4,
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Container(
              height: size.height * 0.05,
              width: size.height * 0.12,
              margin: const EdgeInsets.only(left: 2, right: 2),
              // padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: const Color(0xFF1B4571),
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: const Offset(0, 4), // changes position of shadow
                  ),
                ],
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  constDescribe,
                  maxLines: 1,
                  style: Theme.of(context).textTheme.titleSmall!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 255, 255, 255),
                      ),
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

//----------------------------------------------------------
