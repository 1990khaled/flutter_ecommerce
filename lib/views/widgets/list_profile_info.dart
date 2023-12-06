import 'package:flutter/material.dart';
import 'package:flutter_ecommerce/models/user_data.dart';
import '../pages/editing/my_special_button.dart';

class ListProfileInfo extends StatefulWidget {
  final UserModel userModel;

  const ListProfileInfo({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  @override
  State<ListProfileInfo> createState() => _ListProfileInfoState();
}

class _ListProfileInfoState extends State<ListProfileInfo> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: Image.network(
              widget.userModel.profileImg,
              width: size.height * 0.20,
              height: size.height * 0.20,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            width: size.height * 0.50,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Text(
              widget.userModel.name,
              maxLines: 2,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),

          Container(
            width: size.height * 0.50,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Text(
              'الموبايل: ${widget.userModel.phoneNum}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              softWrap: true,
            ),
          ),
          // const SizedBox(height: 8),
          Container(
            width: size.height * 0.50,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Text(
              'اسم الشركة: ${widget.userModel.companyName}',
              style: const TextStyle(fontSize: 16),
              maxLines: 2,
              softWrap: true,
              textAlign: TextAlign.center,
            ),
          ),

          Container(
            width: size.height * 0.50,
            margin: const EdgeInsets.only(left: 10, right: 10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
              ),
            ),
            child: Text(
              'العنوان: ${widget.userModel.address}',
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
              maxLines: 2,
              softWrap: true,
            ),
          ),
          //----------------------------------------------
          if (widget.userModel.access == "adminRole")
            Container(
                margin: const EdgeInsets.all(10),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    width: 2,
                  ),
                ),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const MySpecialButtonWidget()));
                    },
                    icon: const Icon(Icons.library_add))),
        ],
      ),
    );
  }
}

//----------------------------------------------------------
