import 'package:flutter/material.dart';

class OrderSummaryComponent extends StatelessWidget {
  final String title;
  final String value;
  const OrderSummaryComponent({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
         Text(
          value,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: const Color.fromARGB(255, 34, 34, 34),
              ),
        ),
       
      ],
    );
  }
}
