// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../shared/theme.dart';

class CustomFormField extends StatelessWidget {
  final String title;
  final bool obscureText;
  final TextEditingController? controllerText;
  final bool isShowTitle;
  final TextInputType? keyboardType;
  final Function(String)? onFieldSubmitter;

  const CustomFormField({
    Key? key,
    required this.title,
    this.obscureText = false,
    this.controllerText,
    this.isShowTitle = true,
    this.keyboardType,
    this.onFieldSubmitter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isShowTitle)
          Text(title,
              style: blackTextStyle.copyWith(fontSize: 14, fontWeight: medium)),
        if (isShowTitle)
          const SizedBox(
            height: 8,
          ),
        TextFormField(
          controller: controllerText,
          obscureText: obscureText,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: !isShowTitle ? title : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            contentPadding: const EdgeInsets.all(12),
          ),
          onFieldSubmitted: onFieldSubmitter,
        ),
      ],
    );
  }
}
