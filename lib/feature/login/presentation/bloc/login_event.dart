part of 'login_bloc.dart';

abstract class AuthEvent {}

class GoogleLoginRequested extends AuthEvent {}

class PhoneLoginRequested extends AuthEvent {
  final String phoneNumber;

  PhoneLoginRequested(this.phoneNumber);
}

class OtpSubmitted extends AuthEvent {
  final String verificationId;
  final String otp;

  OtpSubmitted(this.verificationId, this.otp);
}

class LogoutRequested extends AuthEvent {}
