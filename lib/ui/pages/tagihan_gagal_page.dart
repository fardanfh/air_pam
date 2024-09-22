
import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class TagihanGagalPage extends StatelessWidget {
  const TagihanGagalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Pembayaran Tagihan\n Tidak Berhasil',
              style:
                  blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 26),
            Text(
              'Gagal Membayar\nTagihan Air Pam',
              style: greyTextStyle.copyWith(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            CustomFilledButton(
                title: 'Back to Home',
                width: 183,
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
