import 'dart:math';

import 'package:air_pam/blocs/transaction/transaction_bloc.dart';
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/widget/home_latest_transactions.dart';
import 'package:air_pam/ui/widget/home_service_item.dart';
import 'package:air_pam/ui/widget/home_tips_item.dart';
import 'package:air_pam/ui/widget/home_user_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  Future<void> _refreshPage(BuildContext context) async {
    // Simulate a network request or other async operations.
    BlocProvider.of<AuthBloc>(context).add(AuthGetCurrent());

    // You can add a small delay if you want to simulate a longer refresh time.
    await Future.delayed(const Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: lightBackgroundColor,
        bottomNavigationBar: BottomAppBar(
          color: whiteColor,
          shape: const CircularNotchedRectangle(),
          clipBehavior: Clip.antiAlias,
          notchMargin: 6,
          elevation: 0,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            elevation: 0,
            selectedItemColor: purpleColor,
            unselectedItemColor: blackColor,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            selectedLabelStyle:
                blueTextStyle.copyWith(fontSize: 10, fontWeight: medium),
            unselectedLabelStyle:
                greyTextStyle.copyWith(fontSize: 10, fontWeight: medium),
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_overview.png',
                    width: 20,
                    color: purpleColor,
                  ),
                  label: 'Overview'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_history.png',
                    width: 20,
                  ),
                  label: 'History'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_statistic.png',
                    width: 20,
                  ),
                  label: 'Statistic'),
              BottomNavigationBarItem(
                  icon: Image.asset(
                    'assets/ic_reward.png',
                    width: 20,
                  ),
                  label: 'Reward'),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: purpleColor,
          onPressed: () {},
          child: Image.asset(
            'assets/ic_plus_circle.png',
            width: 24,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        body: RefreshIndicator(
        onRefresh: () => _refreshPage(context),
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            buildProfile(context),
            buildWalletCard(),
            buildLevel(),
            buildService(context),
            buildLatestTransaction(),
            buildSendAgain(),
            buildFriendlyTips()
          ],
        ),
      ),);
  }

  Widget buildProfile(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthSuccess) {
          return Container(
            margin: const EdgeInsets.only(top: 60),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hallo,',
                      style: greyTextStyle.copyWith(fontSize: 14),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      state.user.username.toString(),
                      style: blackTextStyle.copyWith(
                          fontSize: 18, fontWeight: semiBold),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    //print('test');
                    // Navigator.pushNamed(context, '/profile-page');
                    Navigator.pushNamed(context, '/profile-page');
                  },
                  child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: state.user.profilePicture == null
                                ? const AssetImage(
                                    'assets/img_profile.png',
                                  )
                                : NetworkImage(state.user.profilePicture!)
                                    as ImageProvider,
                          )),
                      child: state.user.verified == 1
                          ? Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                height: 16,
                                width: 16,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle, color: whiteColor),
                                child: Center(
                                  child: Icon(
                                    Icons.check_circle,
                                    color: greenColor,
                                    size: 14,
                                  ),
                                ),
                              ))
                          : null),
                )
              ],
            ),
          );
        }

        return Container();
      },
    );
  }

  Widget buildWalletCard() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {

        if (state is AuthSuccess) {
          return Container(
          width: double.infinity,
          height: 250,
          margin: const EdgeInsets.only(top: 30),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(28),
              image: const DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img_bg_card.png'))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                state.user.name.toString().toUpperCase(),
                style: whiteTextStyle.copyWith(
                  fontSize: 18,
                  fontWeight: regular,
                  letterSpacing: 1,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                'Nomor Meteran',
                style: whiteTextStyle,
              ),
              Text(
                '${state.user.cardNumber!.substring(0,4)} ${state.user.cardNumber!.substring(4,8)} ${state.user.cardNumber!.substring(8,12)} ${state.user.cardNumber!.substring(12,16)}',
                style: whiteTextStyle.copyWith(
                    fontSize: 20, fontWeight: semiBold, letterSpacing: 4),
              ),
              const SizedBox(
                height: 35,
              ),
              Text(
                'Saldo',
                style: whiteTextStyle,
              ),
              Text(
                formatCurrency(state.user.balance ?? 0),
                style:
                    whiteTextStyle.copyWith(fontSize: 25, fontWeight: bold),
              )
            ],
          ),
        );
        }
        return Container();
      },
    );
  }

  Widget buildLevel() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: whiteColor),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Level 1',
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              ),
              const Spacer(),
              Text(
                '55%',
                style: greenTextStyle.copyWith(fontWeight: semiBold),
              ),
              Text(
                ' of ' + formatCurrency(20000),
                style: blackTextStyle.copyWith(fontWeight: semiBold),
              )
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(55),
            child: LinearProgressIndicator(
              value: 0.55,
              minHeight: 5,
              backgroundColor: lightBackgroundColor,
              valueColor: AlwaysStoppedAnimation(greenColor),
            ),
          )
        ],
      ),
    );
  }

  Widget buildService(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Layanan Kami',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              HomeService(
                iconUrl: 'assets/ic_topup.png',
                title: 'Top Up',
                onTap: () {
                  Navigator.pushNamed(context, '/topup');
                },
              ),
              HomeService(
                iconUrl: 'assets/ic_product_water.png',
                title: 'Tagihan PAM',
                onTap: () {
                  Navigator.pushNamed(context, '/tagihan');
                },
              ),
              HomeService(
                iconUrl: 'assets/ic_withdraw.png',
                title: 'Transaksi',
                onTap: () {
                  Navigator.pushNamed(context, '/transaksi');
                },
              ),
              HomeService(
                iconUrl: 'assets/ic_more.png',
                title: 'More',
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) => const MoreDialog());
                },
              ),
            ],
          )
        ],
      ),
    );
  }

 Widget buildLatestTransaction() {
    return Container(
      margin: const EdgeInsets.only(
        top: 30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Transaksi Terbaru',
            style: blackTextStyle.copyWith(
              fontSize: 16,
              fontWeight: semiBold,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 14,
            ),
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: whiteColor,
            ),
            child: BlocProvider(
              create: (context) => TransactionBloc()..add(TransactionGet()),
              child: BlocBuilder<TransactionBloc, TransactionState>(
                builder: (context, state) {
                  if (state is TransactionSuccess) {
                    return Column(
                      children: state.data.map((e) {
                        return HomeLatestTransactionItem(transaction: e);
                      }).toList(),
                    );
                  }
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget buildSendAgain() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Send People Again',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          const SizedBox(height: 14),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                HomeUserItems(
                    imageUrl: 'assets/img_friend1.png', username: 'yuanita'),
                HomeUserItems(
                    imageUrl: 'assets/img_friend2.png', username: 'ikram'),
                HomeUserItems(
                    imageUrl: 'assets/img_friend3.png', username: 'ilham'),
                HomeUserItems(
                    imageUrl: 'assets/img_friend4.png', username: 'jihan'),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget buildFriendlyTips() {
    return Container(
        margin: const EdgeInsets.only(top: 30, bottom: 50),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            'Friendly Tips',
            style: blackTextStyle.copyWith(fontSize: 16, fontWeight: semiBold),
          ),
          const SizedBox(height: 14),
          Center(
            child: Wrap(
              spacing: 8,
              runSpacing: 10,
              children: [
                HomeTipsItem(
                    imageUrl: 'assets/img_tips1.png',
                    title: 'Best tips for using a credit card',
                    url: 'https://www.google.com'),
                HomeTipsItem(
                    imageUrl: 'assets/img_tips2.png',
                    title: 'Best tips for using a credit card',
                    url: 'https://www.google.com'),
                HomeTipsItem(
                    imageUrl: 'assets/img_tips3.png',
                    title: 'Best tips for using a credit card',
                    url: 'https://www.google.com'),
                HomeTipsItem(
                    imageUrl: 'assets/img_tips4.png',
                    title: 'Best tips for using a credit card',
                    url: 'https://www.google.com'),
              ],
            ),
          )
        ]));
  }
}

class MoreDialog extends StatelessWidget {
  const MoreDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              Text('Do More With Us',
                  style: blackTextStyle.copyWith(
                    fontSize: 16,
                    fontWeight: semiBold,
                  )),
              const SizedBox(height: 30),
              Wrap(
                spacing: 30,
                runSpacing: 20,
                children: [
                  HomeService(
                    iconUrl: 'assets/ic_product_data.png',
                    title: 'Data',
                    onTap: () {
                      Navigator.pushNamed(context, '/dataprovider');
                    },
                  ),
                  HomeService(
                    iconUrl: 'assets/ic_product_water.png',
                    title: 'Air PAM',
                    onTap: () {
                       Navigator.pushNamed(context, '/tagihan');
                    },
                  ),
                  HomeService(
                    iconUrl: 'assets/ic_product_stream.png',
                    title: 'Stream',
                    onTap: () {},
                  ),
                  HomeService(
                    iconUrl: 'assets/ic_product_movie.png',
                    title: 'Movie',
                    onTap: () {},
                  ),
                  HomeService(
                    iconUrl: 'assets/ic_product_food.png',
                    title: 'Food',
                    onTap: () {},
                  ),
                  HomeService(
                    iconUrl: 'assets/ic_product_travel.png',
                    title: 'Travel',
                    onTap: () {},
                  ),
                ],
              ),
            ],
          )),
    );
  }
}
