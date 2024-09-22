// ignore_for_file: use_build_context_synchronously

import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:air_pam/ui/widget/form.dart';
import 'package:air_pam/ui/widget/package_item.dart';
import 'package:flutter/material.dart';

class DataPackagePage extends StatelessWidget {
  const DataPackagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Paket Data'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Text('Phone Number',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              )),
          const SizedBox(height: 14),
          const CustomFormField(
            title: '+628',
            isShowTitle: false,
          ),
          const SizedBox(height: 40),
          Text(
            'Select Package',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 25,
            runSpacing: 25,
            children: [
              PackageItem(amount: 10, price: 100000),
              PackageItem(
                amount: 25,
                price: 200000,
                isSelected: true,
              ),
              PackageItem(amount: 40, price: 400000),
              PackageItem(amount: 99, price: 1000000),
            ],
          ),
          const SizedBox(height: 85),
          CustomFilledButton(
            title: 'Continue',
            onPressed: () async {
              if (await Navigator.pushNamed(context, '/pin-page') == true) {
                Navigator.pushNamedAndRemoveUntil(
                    context, '/datasuccess', (route) => false);
              }
            },
          ),
          const SizedBox(height: 57),
        ],
      ),
    );
  }
}
