import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widget/button.dart';

class ProfileEditSuccess extends StatelessWidget {
  const ProfileEditSuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Berhasil Update Data!',
              style: blackTextStyle.copyWith(fontSize: 20, fontWeight: bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 26,
            ),
            Text(
              'Grow Your Water Start\nTogether With Us',
              style: greyTextStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 50,
            ),
            CustomFilledButton(
                width: 180,
                title: 'My Profile',
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/home-page', (route) => false);
                })
          ],
        ),
      ),
    );
  }
}