import 'dart:async';

import 'package:air_pam/blocs/auth_bloc.dart';
import 'package:air_pam/blocs/topup/topup_bloc.dart';
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:url_launcher/url_launcher.dart' as launcher;
import '../../models/topup_form_model.dart';
import '../widget/button.dart';

class TopUpAmountPage extends StatefulWidget {
  final TopupFormModel data;

  const TopUpAmountPage({super.key, required this.data});

  @override
  State<TopUpAmountPage> createState() => _TopUpAmountPageState();
}

class _TopUpAmountPageState extends State<TopUpAmountPage> {
  TextEditingController amountController = TextEditingController(text: '0');

  addAmount(String number) {
    if (amountController.text == '0') {
      amountController.text = '';
    }
    setState(() {
      amountController.text = amountController.text + number;
      print(amountController.text);
    });
  }

  deleteAmount() {
    if (amountController.text.isNotEmpty) {
      setState(() {
        amountController.text = amountController.text
            .substring(0, amountController.text.length - 1);
        if (amountController.text == '') {
          amountController.text == '0';
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();

    amountController.addListener(() {
      final text = amountController.text;
      try {
        amountController.value = amountController.value.copyWith(
          text: NumberFormat.currency(
            locale: 'id',
            decimalDigits: 0,
            symbol: '',
          ).format(
            int.parse(text.replaceAll('.', '')),
          ),
        );
      } catch (e) {
// Handle the error here

        print('Error parsing amount: $e');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkBackgroundColor,
      body: BlocProvider(
        create: (context) => TopupBloc(),
        child: BlocConsumer<TopupBloc, TopupState>(
          listener: (context, state) async {
            if (state is TopupFailed) {
              showCustomSnackbar(context, state.e);
            }

            if (state is TopupSuccess) {
              if (await canLaunchUrl(Uri.parse(state.redirectUrl))) {
                launch(state.redirectUrl);
              }
              print(state.redirectUrl);

              context.read<AuthBloc>().add(
                    AuthUpdateBalance(
                      int.parse(
                        amountController.text.replaceAll('.', ''),
                      ),
                    ),
                  );

              Timer(const Duration(seconds: 5), () {
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  '/topupsuccess',
                  (route) => false,
                );
              });
            }
          },
          builder: (context, state) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 58),
              children: [
                const SizedBox(height: 56),
                Center(
                  child: Text('Total Amount',
                      style: whiteTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      )),
                ),
                const SizedBox(height: 67),
                Align(
                  child: SizedBox(
                    width: double.infinity,
                    child: TextFormField(
                      enabled: false,
                      controller: amountController,
                      cursorColor: greyColor,
                      style: whiteTextStyle.copyWith(
                        fontSize: 36,
                        fontWeight: medium,
                      ),
                      decoration: InputDecoration(
                          prefixIcon: Text(
                            'Rp',
                            style: whiteTextStyle.copyWith(
                              fontSize: 36,
                              fontWeight: medium,
                            ),
                          ),
                          disabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: greyColor))),
                    ),
                  ),
                ),
                const SizedBox(height: 66),
                GridView(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      childAspectRatio: 1,
                      mainAxisSpacing: 40,
                      crossAxisSpacing: 40),
                  children: [
                    CustomInputButton(
                      title: "1",
                      onTap: () => addAmount("1"),
                    ),
                    CustomInputButton(
                      title: "2",
                      onTap: () => addAmount("2"),
                    ),
                    CustomInputButton(
                      title: "3",
                      onTap: () => addAmount("3"),
                    ),
                    CustomInputButton(
                      title: "4",
                      onTap: () => addAmount("4"),
                    ),
                    CustomInputButton(
                      title: "5",
                      onTap: () => addAmount("5"),
                    ),
                    CustomInputButton(
                      title: "6",
                      onTap: () => addAmount("6"),
                    ),
                    CustomInputButton(
                      title: "7",
                      onTap: () => addAmount("7"),
                    ),
                    CustomInputButton(
                      title: "8",
                      onTap: () => addAmount("8"),
                    ),
                    CustomInputButton(
                      title: "9",
                      onTap: () => addAmount("9"),
                    ),
                    const SizedBox(),
                    CustomInputButton(
                      title: "0",
                      onTap: () => addAmount("0"),
                    ),
                    GestureDetector(
                      onTap: () => deleteAmount(),
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: numberBackgroundColor),
                        child: Center(
                            child: Icon(
                          Icons.arrow_back,
                          color: whiteColor,
                          size: 24,
                        )),
                      ),
                    )
                  ],
                ),
                const SizedBox(height: 50),
                CustomFilledButton(
                  title: 'Checkout Now',
                  onPressed: () async {
                    if (await Navigator.pushNamed(context, '/pin-page') ==
                        true) {
                      final authState = context.read<AuthBloc>().state;

                      String pin = "";
                      if (authState is AuthSuccess) {
                        pin = authState.user.pin!;
                      }

                      context.read<TopupBloc>().add(
                            TopupPost(
                              widget.data.copyWith(
                                pin: pin,
                                amount:
                                    amountController.text.replaceAll('.', ''),
                              ),
                            ),
                          );
                    }
                  },
                ),
                const SizedBox(height: 25),
                CustomTextWidget(
                  title: 'Terms & Conditions',
                  onPressed: () {},
                ),
                const SizedBox(height: 40),
              ],
            );
          },
        ),
      ),
    );
  }
}
