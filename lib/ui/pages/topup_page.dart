import 'package:air_pam/blocs/payment_method/payment_method_bloc.dart';
import 'package:air_pam/models/topup_form_model.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/pages/topup_amount_page.dart';
import 'package:air_pam/ui/widget/bank_item.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc.dart';
import '../../models/payment_method_mode.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {

  PaymentMethodModel? selectedPaymentMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Up'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Text('Wallet',
              style:
                  blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold)),
          const SizedBox(height: 10),
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              if (state is AuthSuccess) {
                return Row(
                  children: [
                    Image.asset('assets/img_wallet.png', width: 80),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: blackTextStyle.copyWith(
                            fontWeight: medium,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          state.user.name.toString().toUpperCase(),
                          style: greyTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    )
                  ],
                );
              }
              return Container();
            },
          ),
          const SizedBox(height: 40),
          Text('Select Bank',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              )),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => PaymentMethodBloc()..add(PaymentMethodGet()),
            child: BlocBuilder<PaymentMethodBloc, PaymentMethodState>(
              builder: (context, state) {
                if (state is PaymentMethodSuccess) {
                  return Column(
                    children: state.paymentMethods.map((paymentMethods) {
                       return GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              selectedPaymentMethod = paymentMethods;
                              print(paymentMethods.name);
                            },
                          );
                        },
                        child: BankItem(
                          paymentMethod: paymentMethods,
                          isSelected: paymentMethods.id == selectedPaymentMethod?.id,
                        ),
                      );
                    }).toList()
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(height: 12),
          
        ],
      ),
      floatingActionButton: (selectedPaymentMethod != null)
          ? Container(
              margin: const EdgeInsets.all(24),
              child: CustomFilledButton(
                title: 'Continue',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TopUpAmountPage(
                        data: TopupFormModel(
                          paymentMethodCode: selectedPaymentMethod?.code,
                        ),
                      ),
                    ),
                  );
                },
              ),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
