import 'dart:math';

import 'package:air_pam/blocs/auth_bloc.dart';
import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:air_pam/ui/widget/profile_menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightBackgroundColor,
      appBar: AppBar(
        backgroundColor: lightBackgroundColor,
        elevation: 0,
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailed) {
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthInitial) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/sign-in', (route) => false);
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is AuthSuccess) {
            return ListView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              children: [
                Center(
                  child: Text(
                    'My Profile',
                    style: blackTextStyle.copyWith(
                        fontSize: 22, fontWeight: semiBold),
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                  decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    children: [
                      Container(
                          height: 120,
                          width: 120,
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
                                    height: 28,
                                    width: 28,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: whiteColor),
                                    child: Center(
                                      child: Icon(
                                        Icons.check_circle,
                                        color: greenColor,
                                        size: 24,
                                      ),
                                    ),
                                  ))
                              : null),
                      const SizedBox(height: 16),
                      Text(
                        state.user.name.toString().toUpperCase(),
                        style: blackTextStyle.copyWith(
                          fontWeight: medium,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 40),
                      ProfileMenuItem(
                          iconUrl: "assets/ic_user.png",
                          title: "Edit Profile",
                          onTap: () async {
                            // ignore: use_build_context_synchronously
                            if (await Navigator.pushNamed(
                                    context, '/pin-page') ==
                                true) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(
                                  context, '/profile-edit-page');
                            }
                          }),
                      ProfileMenuItem(
                          iconUrl: "assets/ic_mypin.png",
                          title: "My PIN",
                          onTap: () async {
                            // ignore: use_build_context_synchronously
                            if (await Navigator.pushNamed(
                                    context, '/pin-page') ==
                                true) {
                              // ignore: use_build_context_synchronously
                              Navigator.pushNamed(context, '/edit-pin-page');
                            }
                          }),
                      ProfileMenuItem(
                          iconUrl: "assets/ic_wallet.png",
                          title: "Wallet Settings",
                          onTap: () {}),
                      ProfileMenuItem(
                          iconUrl: "assets/ic_myreward.png",
                          title: "My Rewards"),
                      ProfileMenuItem(
                          iconUrl: "assets/ic_help.png", title: "Help Center"),
                      ProfileMenuItem(
                        iconUrl: "assets/ic_logout.png",
                        title: "Log Out",
                        margin: EdgeInsets.zero,
                        onTap: () {
                          context.read<AuthBloc>().add(AuthLogout());
                        },
                      ),
                      SizedBox(
                        height: 30,
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 87),
                CustomTextWidget(title: 'Report a Problem', onPressed: () {})
              ],
            );
          }

          return Container();
        },
      ),
    );
  }
}
