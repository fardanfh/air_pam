import 'package:air_pam/blocs/auth_bloc.dart';
import 'package:air_pam/blocs/user/user_bloc.dart';
import 'package:air_pam/shared/theme.dart';
import 'package:air_pam/ui/pages/data_package_page.dart';
import 'package:air_pam/ui/pages/data_provider_page.dart';
import 'package:air_pam/ui/pages/data_success_page.dart';
import 'package:air_pam/ui/pages/home_page.dart';
import 'package:air_pam/ui/pages/onboarding_page.dart';
import 'package:air_pam/ui/pages/pin_page.dart';
import 'package:air_pam/ui/pages/profile_edit_page.dart';
import 'package:air_pam/ui/pages/profile_edit_pin.dart';
import 'package:air_pam/ui/pages/profile_edit_success.dart';
import 'package:air_pam/ui/pages/profile_page.dart';
import 'package:air_pam/ui/pages/sign_in_page.dart';
import 'package:air_pam/ui/pages/sign_up_page.dart';
import 'package:air_pam/ui/pages/sign_up_set_ktp_page.dart';
import 'package:air_pam/ui/pages/sign_up_success_page.dart';
import 'package:air_pam/ui/pages/sign_up_upload_profile_page.dart';
import 'package:air_pam/ui/pages/splash_page.dart';
import 'package:air_pam/ui/pages/tagihan_gagal_page.dart';
import 'package:air_pam/ui/pages/tagihan_page.dart';
import 'package:air_pam/ui/pages/topup_amount_page.dart';
import 'package:air_pam/ui/pages/topup_page.dart';
import 'package:air_pam/ui/pages/topup_success.dart';
import 'package:air_pam/ui/pages/transaction_page.dart';
import 'package:air_pam/ui/pages/transfer_amount_page.dart';
import 'package:air_pam/ui/pages/transfer_page.dart';
import 'package:air_pam/ui/pages/transfer_success_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => AuthBloc()..add(AuthGetCurrent())),
          BlocProvider(create: (context) => UserBloc()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: lightBackgroundColor,
              appBarTheme: AppBarTheme(
                  backgroundColor: lightBackgroundColor,
                  elevation: 0,
                  centerTitle: true,
                  iconTheme: IconThemeData(color: blackColor),
                  titleTextStyle: blackTextStyle.copyWith(
                      fontSize: 20, fontWeight: semiBold))),
          routes: {
            '/': (context) => const SplashPage(),
            '/onboarding': (context) => const OnboardingPage(),
            '/sign-in': (context) => const SignInPage(),
            '/sign-up': (context) => const SignUpPage(),
            '/sign-up-success': (context) => const SignUpSuccessPage(),
            '/home-page': (context) => const HomePage(),
            '/profile-page': (context) => const ProfilePage(),
            '/pin-page': (context) => const PinPage(),
            '/profile-edit-page': (context) => const ProfileEditPage(),
            '/edit-pin-page': (context) => const ProfileEditPinPage(),
            '/profile-edit-success': (context) => const ProfileEditSuccess(),
            '/topup': (context) => const TopupPage(),
            '/topupsuccess': (context) => const TopUpSuccessPage(),
            '/transfer': (context) => const TransferPage(),
            '/transfersuccess': (context) => const TransferSuccessPage(),
            '/dataprovider': (context) => const DataProviderPage(),
            '/datapackage': (context) => const DataPackagePage(),
            '/datasuccess': (context) => const DataSuccessPage(),
            '/tagihan': (context) => const TagihanPage(),
            '/tagihansuccess': (context) => const DataSuccessPage(),
            '/transaksi': (context) => const TransactionPage(),
            '/tagihangagal': (context) => const TagihanGagalPage(),
          },
        ));
  }
}
