import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';

class PackageItem extends StatelessWidget {
  final int amount;
  final int price;
  final bool isSelected;
  const PackageItem(
      {super.key,
      required this.amount,
      required this.price,
      this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 185,
      height: 175,
      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 22,
      ),
      decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? blueColor : whiteColor,
            width: 2,
          )),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 13),
          Text('${amount}GB',
              style: blackTextStyle.copyWith(
                fontSize: 32,
                fontWeight: medium,
              )),
          const SizedBox(height: 2),
          Text(formatCurrency(price), style: greyTextStyle.copyWith(fontSize: 12)),
        ],
      ),
    );
  }
}
