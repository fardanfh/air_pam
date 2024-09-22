import 'dart:convert';
import 'dart:io';

import 'package:air_pam/models/sign_up_form_model.dart';
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/ui/pages/sign_up_set_ktp_page.dart';
import 'package:flutter/material.dart';

import '../../shared/theme.dart';
import '../widget/button.dart';
import '../widget/form.dart';
import 'package:image_picker/image_picker.dart';

class SignUpSetProfilePgae extends StatefulWidget {
  final SignUpFormModel data;

  const SignUpSetProfilePgae({
    Key? key,
    required this.data,
  }) : super(key: key);

  @override
  State<SignUpSetProfilePgae> createState() => _SignUpSetProfilePgaeState();
}

class _SignUpSetProfilePgaeState extends State<SignUpSetProfilePgae> {
  final pinController = TextEditingController(text: '');
  XFile? selectedImage;

  selectImage() async {
    final imagePicker = ImagePicker();
    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = image;
      });
    }
  }

  bool _validate() {
    if (pinController.text.length != 6 || selectedImage == null) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            width: 155,
            height: 50,
            margin: const EdgeInsets.only(top: 100, bottom: 100),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/img_logo_light.png'))),
          ),
          Text(
            'Upload Your\nProfile Here',
            style: blackTextStyle.copyWith(fontSize: 20, fontWeight: semiBold),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: whiteColor),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    selectImage();
                  },
                  child: Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: lightBackgroundColor,
                      image: selectedImage == null
                          ? null
                          : DecorationImage(
                              fit: BoxFit.cover,
                              image: FileImage(
                                File(
                                  selectedImage!.path,
                                ),
                              ),
                            ),
                    ),
                    child: selectedImage != null
                        ? null
                        : Center(
                            child: Image.asset(
                              'assets/ic_upload.png',
                              width: 32,
                            ),
                          ),
                  ),
                ),
                // Container(
                //   width: 120,
                //   height: 120,
                //   decoration: BoxDecoration(
                //       shape: BoxShape.circle,
                //       image: DecorationImage(
                //           image: AssetImage('assets/img_profile.png'),
                //           fit: BoxFit.cover)),
                // ),
                const SizedBox(height: 16),
                Text(
                  'Upload Image Anda',
                  style:
                      blackTextStyle.copyWith(fontSize: 18, fontWeight: medium),
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFormField(
                  title: 'Set PIN (6 digit nomor)',
                  obscureText: true,
                  controllerText: pinController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomFilledButton(
                    title: 'Continue',
                    onPressed: () {
                      if (_validate()) {
                         Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpSetKtpPage(
                            data: widget.data.copyWith(
                              profilePicture: selectedImage == null
                                  ? null
                                  : 'data:image/png;base64,' +
                                      base64Encode(File(selectedImage!.path)
                                          .readAsBytesSync()),
                              pin: pinController.text,
                            ),
                          ),
                        ),
                      );
                    } else {
                      showCustomSnackbar(context, 'Set PIN (6 digit number)');
                    }
                    })
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }
}
