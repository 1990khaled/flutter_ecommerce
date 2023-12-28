import 'package:flutter/material.dart';

class OrderSummaryComponent extends StatelessWidget {
  final String title;
  final String value;
  const OrderSummaryComponent({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(value,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w600,
                )),
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: const Color.fromARGB(255, 34, 34, 34),
                fontWeight: FontWeight.w400,
              ),
        ),
      ],
    );
  }
}
