import 'package:air_pam/blocs/auth_bloc.dart';
import 'package:air_pam/blocs/operator_card/operator_card_bloc.dart';
import 'package:air_pam/blocs/tagihan/tagihan_bloc.dart';
import 'package:air_pam/models/operator_card_model.dart';
import 'package:air_pam/models/tagihan_bayar_model.dart';
import 'package:air_pam/models/tagihan_model.dart';
import 'package:air_pam/services/auth_service.dart';
import 'package:air_pam/services/tagihan_service.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/pages/data_package_page.dart';
import 'package:air_pam/ui/pages/pin_page.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:air_pam/ui/widget/data_provider_item.dart';
import 'package:air_pam/ui/widget/tagihan_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../shared/shared_methods.dart';

class TagihanPage extends StatefulWidget {
  const TagihanPage({super.key});

  @override
  State<TagihanPage> createState() => _TagihanPageState();
}

class _TagihanPageState extends State<TagihanPage> {
  TagihanModel? selectedTagihan;
  bool isLoading = false;

  String formatDate(String tanggal) {
    try {
      // Parse the date string into a DateTime object
      DateTime dateTime = DateTime.parse(tanggal);

      // Define the date format with commas
      DateFormat formatter =
          DateFormat('EEEE, d MMMM yyyy'); // Day name, day, month, year

      // Format the DateTime object into the desired string format
      return formatter.format(dateTime);
    } catch (e) {
      print('Error parsing date: $e');
      return tanggal; // Return the original string if parsing fails
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tagihan Air PAM'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Text(
            'Meteran',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Image.asset('assets/img_wallet.png', width: 80),
              const SizedBox(width: 16),
              BlocBuilder<AuthBloc, AuthState>(
                builder: (context, state) {
                  if (state is AuthSuccess) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.user.cardNumber!.replaceAllMapped(
                              RegExp(r".{4}"), (match) => "${match.group(0)} "),
                          style: blackTextStyle.copyWith(
                              fontSize: 16, fontWeight: medium),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Saldo: ${formatCurrency(state.user.balance ?? 0)}',
                          style: greyTextStyle.copyWith(fontSize: 12),
                        )
                      ],
                    );
                  }
                  return Container();
                },
              )
            ],
          ),
          const SizedBox(height: 40),
          Text(
            'Tagihan',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          const SizedBox(height: 14),
          BlocProvider(
            create: (context) => TagihanBloc()..add(TagihanGet()),
            child: BlocBuilder<TagihanBloc, TagihanState>(
              builder: (context, state) {
                if (state is TagihanSuccess) {
                  return Column(
                    children: state.tagihanCard.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedTagihan = e;
                            print(selectedTagihan!.id);
                          });
                        },
                        child: TagihanItem(
                          tagihanCard: e,
                          isSelected: e.id == selectedTagihan?.id,
                        ),
                      );
                    }).toList(),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
          ),
          const SizedBox(height: 57),
        ],
      ),
      floatingActionButton: isLoading
          ? Container()
          : (selectedTagihan != null && selectedTagihan!.status == 'N')
              ? Container(
                  margin: const EdgeInsets.all(24),
                  child: CustomFilledButton(
                    title: 'Bayar Tagihan',
                    onPressed: () async {
                      if (await Navigator.pushNamed(context, '/pin-page') ==
                          true) {
                        final authState = context.read<AuthBloc>().state;

                        String pin = "";
                        if (authState is AuthSuccess) {
                          pin = authState.user.pin!;
                        }

                        TagihanBayarModel requestModel = TagihanBayarModel(
                          pin: int.parse(pin),
                          idTagihan: selectedTagihan!.id!,
                        );

                        showLoadingDialog(context);

                        try {
                          // Send the request
                          await TagihanService()
                              .sendTagihanRequest(requestModel);

                          await Future.delayed(Duration(seconds: 5));

                          dismissLoadingDialog(context);

                          Navigator.pushNamedAndRemoveUntil(
                              context, '/tagihansuccess', (route) => false);
                        } catch (e) {
                          await Future.delayed(Duration(seconds: 5));

                          dismissLoadingDialog(context);
                          Navigator.pushNamedAndRemoveUntil(
                              context, '/tagihangagal', (route) => false);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('Saldo Tidak Mencukupi')),
                          );
                        } finally {
                          setState(() {
                            isLoading = false;
                          });
                        }
                      }
                    },
                  ),
                )
              : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      AnimationController animationController = AnimationController(
        duration: const Duration(milliseconds: 300),
        vsync: Navigator.of(context),
      );

      animationController.forward();

      return Center(
        child: AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(milliseconds: 300),
          child: ScaleTransition(
            scale: CurvedAnimation(
              parent: animationController,
              curve: Curves.easeInOut,
            ),
            child: AlertDialog(
              backgroundColor: Colors.transparent,
              insetPadding: EdgeInsets.zero,
              alignment: Alignment.bottomCenter,
              content: Container(
                height: 400,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: lightBackgroundColor,
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Memproses Pembayaran',
                      style: blackTextStyle.copyWith(
                        fontSize: 20,
                        fontWeight: semiBold,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, state) {
                            if (state is AuthSuccess) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nomor Meteran',
                                    style: greyTextStyle.copyWith(
                                      fontSize: 14,
                                      fontWeight: light,
                                    ),
                                  ),
                                  Text(
                                    state.user.cardNumber!.replaceAllMapped(
                                        RegExp(r".{4}"), 
                                        (match) => "${match.group(0)} "),
                                    style: blackTextStyle.copyWith(
                                      fontSize: 18, 
                                      fontWeight: medium,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                ],
                              );
                            }
                            return Container();
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meteran Sebelum',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: light,
                              ),
                            ),
                            Text(
                              selectedTagihan!.meteranTerakhir.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Meteran Sekarang',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: light,
                              ),
                            ),
                            Text(
                              selectedTagihan!.meteran.toString(),
                              style: blackTextStyle.copyWith(
                                fontSize: 18,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Jumlah Bayar',
                              style: greyTextStyle.copyWith(
                                fontSize: 14,
                                fontWeight: light,
                              ),
                            ),
                            const SizedBox(height: 0), 
                            Text(
                              formatCurrency(
                                  selectedTagihan!.jumlahTagihan ?? 0),
                              style: blackTextStyle.copyWith(
                                fontSize: 24,
                                fontWeight: semiBold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                      backgroundColor: Colors.grey[300],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}


  void dismissLoadingDialog(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}
