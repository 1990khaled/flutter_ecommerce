import 'package:flutter/material.dart';

class HeaderOfList extends StatelessWidget {
  final String title;
  final String description;
  const HeaderOfList({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
              Text(
            description,
            style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: const Color.fromARGB(255, 2, 2, 2),
                ),
          ),
            ],
          ),
          
        ],
      ),
    );
  }
}
