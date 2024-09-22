import 'package:air_pam/blocs/transaction/transaction_bloc.dart';
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/ui/widget/home_latest_transactions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/theme.dart';

class TransactionPage extends StatefulWidget {
  const TransactionPage({super.key});

  @override
  State<TransactionPage> createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Riwayat Transaksi'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Text(
            'Riwayat Transaksi Anda',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 10),
          BlocProvider(
            create: (context) => TransactionBloc()..add(TransactionGet()),
            child: BlocBuilder<TransactionBloc, TransactionState>(
              builder: (context, state) {
                if (state is TransactionSuccess) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: state.data.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(25),
                              ),
                            ),
                            builder: (context) {
                              final transaction = state.data[index];
                              final isCredit =
                                  transaction.transactionType?.action == 'cr';

                              return Container(
                                padding: const EdgeInsets.all(16),
                                height: MediaQuery.of(context).size.height *
                                    0.4, // Make the bottom sheet taller
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Header Row
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          isCredit
                                              ? Icons
                                                  .account_balance_wallet_outlined
                                              : Icons.water_drop_outlined,
                                          size: 40,
                                          color: blackColor,
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          isCredit
                                              ? 'Top Up Saldo'
                                              : 'Bayar Tagihan PAM',
                                          style: blackTextStyle.copyWith(
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 25),

                                    // Transaction Type
                                    Row(
                                      children: [
                                        const Icon(Icons.shopping_cart_outlined,
                                            color: Colors.black),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${transaction.transactionType!.name}',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),

                                    // Amount
                                    Row(
                                      children: [
                                        const Icon(Icons.attach_money,
                                            color: Colors.black),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${formatCurrency(transaction.amount!)}',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),

                                    // Date
                                    Row(
                                      children: [
                                        const Icon(Icons.calendar_today,
                                            color: Colors.black),
                                        const SizedBox(width: 10),
                                        Text(
                                          '${DateFormat('MMM dd, yyyy').format(transaction.createdAt ?? DateTime.now())}',
                                          style: blackTextStyle.copyWith(
                                              fontSize: 18,
                                              fontWeight: FontWeight.normal),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 15),

                                    // Barcode Image
                                    Expanded(
                                      child: Center(
                                        child: Image.asset(
                                          'assets/barcode.png', // Replace with your barcode image path
                                          height: 40,
                                          width: double
                                              .infinity, // Set the width to 100% of the parent
                                          fit: BoxFit
                                              .fitWidth, // Ensure the image maintains its aspect ratio
                                        ),
                                      ),
                                    ),

                                    // Close Button
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 0),
                                      child: Center(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(
                                                context); // Close the bottom sheet
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: purpleColor,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 32, vertical: 8),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          child: Text(
                                            'Tutup',
                                            style: whiteTextStyle.copyWith(
                                                fontSize: 18),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          child: Card(
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: HomeLatestTransactionItem(
                                transaction: state.data[index]),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
