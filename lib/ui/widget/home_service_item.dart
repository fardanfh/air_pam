// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeService extends StatelessWidget {

  final String iconUrl;
  final String title;
  final VoidCallback? onTap;

  const HomeService({
    Key? key,
    required this.iconUrl,
    required this.title,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 70,
            height: 70,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor
            ),
            child: Center(
              child: Image.asset(
                iconUrl,
                width: 26,
              ),
            ),
          ),
          Text(
            title,
            style: blackTextStyle.copyWith(
              fontWeight: medium
            ),
          )
        ],
      ),
    );
  }
}
