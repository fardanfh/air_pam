import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:flutter/material.dart';

class SignUpSuccessPage extends StatelessWidget {
  const SignUpSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Akun Berhasil\nTerdaftar',
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
                title: 'Get Started',
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
