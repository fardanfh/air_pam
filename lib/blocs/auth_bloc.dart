// ignore_for_file: depend_on_referenced_packages

import 'package:air_pam/models/sign_in_form_model.dart';
import 'package:air_pam/models/sign_up_form_model.dart';
import 'package:air_pam/models/user_model.dart';
import 'package:air_pam/services/user_service.dart';
import 'package:air_pam/services/wallet_service.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../services/auth_service.dart';
import '../models/user_edit_form_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is AuthCheckEmail) {
        try {
          emit(AuthLoading());
          final res = await AuthService().checkEmail(event.email);
          if (res == false) {
            emit(AuthCheckEmailSuccesss());
          } else {
            emit(const AuthFailed('Email Sudah Terpakai'));
          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

    if (event is AuthRegister) {
        try {
          print('auth form register');

          emit(AuthLoading());

          final res = await AuthService().register(event.data);

          emit(AuthSuccess(res));
        } catch (e) {
          print(e.toString());
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthLogin) {
        try {
          print('auth login');

          emit(AuthLoading());

          final res = await AuthService().login(event.data);

          emit(AuthSuccess(res));
        } catch (e) {
          print(e.toString());
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthGetCurrent) {
        try {
          emit(AuthLoading());

          final SignInFormModel res =
              await AuthService().getCredentialFromLocal();

          final UserModel user = await AuthService().login(res);

          emit(AuthSuccess(user));
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateUser) {
        try {
          if (state is AuthSuccess) {
            

            final updatedUser = (state as AuthSuccess).user.copyWith(
              name: event.data.name,
              username: event.data.username,
              email: event.data.email,
              password: event.data.password
            );

            emit(AuthLoading());

            await UserService().updateUser(event.data);

            emit(AuthSuccess(updatedUser));

          }
        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdatePin) {
        try {
          if (state is AuthSuccess) {

            final updatedPin = (state as AuthSuccess).user.copyWith(
              pin: event.newPin
            );

            emit(AuthLoading());

            await WalletService().updatePin(event.oldPin, event.newPin);

            emit(AuthSuccess(updatedPin));
          }
        } catch (e) {}
      }

      if (event is AuthLogout) {
        try {
          
          emit(AuthLoading());

          await AuthService().logout();

          emit(AuthInitial());

        } catch (e) {
          emit(AuthFailed(e.toString()));
        }
      }

      if (event is AuthUpdateBalance) {
        if (state is AuthSuccess) {
          final currentUser = (state as AuthSuccess).user;
          final updateUser = currentUser.copyWith(
            balance: currentUser.balance! + event.amount,
          );

          emit(AuthSuccess(updateUser));
          
        }
      }

    });
  }
}
