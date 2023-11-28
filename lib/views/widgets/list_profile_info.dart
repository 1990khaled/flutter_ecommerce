import 'package:flutter/material.dart';

import '../../models/user_modle.dart';

class ListProfileInfo extends StatefulWidget {
  final UserModle userModle;

  const ListProfileInfo({
    Key? key,
    required this.userModle,
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
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            child: Image.network(
              widget.userModle.profileImg,
              width: size.height * 0.20,
              height: size.height * 0.20,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color.fromARGB(255, 0, 0, 0),
                width: 2,
              ),
            ),
            child: Text(
              widget.userModle.name,
              maxLines: 2,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'الموبايل: ${widget.userModle.phoneNum}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(
            'اسم الشركة: ${widget.userModle.companyName}',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 12),
          Text(
            'العنوان: ${widget.userModle.adress}',
            style: const TextStyle(fontSize: 16),
          ),
         
        ],
      ),
    );
  }
}

//----------------------------------------------------------
