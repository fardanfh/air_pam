import 'package:air_pam/shared/shared_methods.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/auth_bloc.dart';
import '../widget/button.dart';
import '../widget/form.dart';

class ProfileEditPinPage extends StatefulWidget {
  const ProfileEditPinPage({super.key});

  @override
  State<ProfileEditPinPage> createState() => _ProfileEditPinPageState();
}

class _ProfileEditPinPageState extends State<ProfileEditPinPage> {
  final oldPinController = TextEditingController(text: '');
  final newPinController = TextEditingController(text: '');

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
            
          if(state is AuthFailed){
            showCustomSnackbar(context, state.e);
          }

          if (state is AuthSuccess) {
            Navigator.pushNamedAndRemoveUntil(
                context, '/profile-edit-success', (route) => false);
          }

        },
        builder: (context, state) {

          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            children: [
              Center(
                child: Text(
                  'Edit Pin',
                  style: blackTextStyle.copyWith(
                      fontSize: 22, fontWeight: semiBold),
                ),
              ),
              const SizedBox(height: 40),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 22),
                decoration: BoxDecoration(
                    color: whiteColor, borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    CustomFormField(
                      title: 'Old Pin',
                      obscureText: true,
                      controllerText: oldPinController,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    CustomFormField(
                      title: 'New Pin',
                      obscureText: true,
                      controllerText: newPinController,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    CustomFilledButton(
                        title: 'Update Now',
                        onPressed: () {
                          context.read<AuthBloc>()
                          .add(AuthUpdatePin(oldPinController.text, newPinController.text));
                        })
                  ],
                ),
              ),
              const SizedBox(height: 87),
            ],
          );
        },
      ),
    );
  }
}
