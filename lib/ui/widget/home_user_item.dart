// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';

class HomeUserItems extends StatelessWidget {
  final String imageUrl;
  final String username;

  const HomeUserItems({
    Key? key,
    required this.imageUrl,
    required this.username,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 130,
      margin: EdgeInsets.only(right: 17),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: whiteColor),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            margin: const EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(imageUrl))),
          ),
          SizedBox(height: 16),
          Text(
            '@$username',
            style: blackTextStyle.copyWith(
              fontSize: 12, fontWeight: medium
            ),
          )
        ],
      ),
    );
  }
}
