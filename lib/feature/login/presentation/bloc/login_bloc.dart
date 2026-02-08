import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import '../../data/model/user_model.dart';
import '../../data/repository/auth_repository.dart';

part 'login_event.dart';

part 'login_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<GoogleLoginRequested>(_onGoogleLogin);
    on<PhoneLoginRequested>(_onPhoneLogin);
    on<OtpSubmitted>(_onOtpSubmit);
    on<LogoutRequested>((event, emit) async {
      await FirebaseAuth.instance.signOut();
      emit(AuthInitial());
    });
  }

  Future<void> _onGoogleLogin(
    GoogleLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      final user = await repository.loginWithGoogle();
      print("usererrerr:$user");
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Login cancelled"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onPhoneLogin(
    PhoneLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      await repository.verifyPhone(
        phoneNumber: event.phoneNumber,
        onCodeSent: (verificationId) {
          emit(OtpSent(verificationId));
        },
      );
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onOtpSubmit(OtpSubmitted event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await repository.verifyOtp(
        verificationId: event.verificationId,
        otp: event.otp,
      );

      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Invalid OTP"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
