import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/pages/transfer_amount_page.dart';
import 'package:air_pam/ui/widget/button.dart';
import 'package:air_pam/ui/widget/form.dart';
import 'package:air_pam/ui/widget/transfer_recent_user_item.dart';
import 'package:air_pam/ui/widget/transfer_result_item.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../blocs/user/user_bloc.dart';
import '../../models/transfer_form_model.dart';
import '../../models/user_model.dart';

class TransferPage extends StatefulWidget {
  const TransferPage({super.key});

  @override
  State<TransferPage> createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  final usernameController = TextEditingController();
  UserModel? selectedUser;

  late UserBloc userBloc;

  @override
  void initState() {
    super.initState();

    userBloc = context.read<UserBloc>()..add(UserGetRecent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transfer'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          const SizedBox(height: 30),
          Text('Search',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              )),
          const SizedBox(height: 14),
          CustomFormField(
            title: 'by username',
            isShowTitle: false,
            controllerText: usernameController,
            onFieldSubmitter: (p0) {
              if (p0.isNotEmpty) {
                userBloc.add(UserGetByUsername(usernameController.text));
              } else {
                selectedUser = null;
                userBloc.add(UserGetRecent());
              }
              setState(() {});
            },
          ),
          usernameController.text.isEmpty ? buildRecentUsers() : buildResult(),
          //buildRecentUsers(),
          //buildResult(),
          const SizedBox(height: 50)
        ],
      ),
      floatingActionButton: selectedUser != null
          ? Container(
              margin: const EdgeInsets.all(20),
              child: CustomFilledButton(
                  title: 'Continue',
                  onPressed: () {
                    Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransferAmountPage(
                        data: TransferFormModel(
                          sendTo: selectedUser!.username,
                        ),
                      ),
                    ),
                  );
                  }),
            )
          : Container(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget buildRecentUsers() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Recent Users',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              )),
          const SizedBox(height: 14),
          BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is UserSuccess) {
                return Column(
                  children: state.users.map((users) {
                    return TransferRecentUserItem(user: users);
                  }).toList(),
                );
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )
        ],
      ),
    );
  }

  Widget buildResult() {
    return Container(
      margin: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Result',
              style: blackTextStyle.copyWith(
                fontSize: 16,
                fontWeight: semiBold,
              )),
          const SizedBox(height: 14),
          Center(
            child: BlocBuilder<UserBloc, UserState>(
              builder: (context, state) {
                if (state is UserSuccess) {
                  return Wrap(
                    spacing: 17,
                    runSpacing: 17,
                    children: state.users.map((e) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedUser = e;
                            print(e.id);
                          });
                        },
                        child: TransferUserResultItem(
                          user: e,
                          isSelected: e.id == selectedUser?.id,
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
        ],
      ),
    );
  }
}
