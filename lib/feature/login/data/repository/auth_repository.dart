import '../datasource/auth_remote_datasource.dart';
import '../model/user_model.dart';

class AuthRepository {
  final _remote = AuthRemoteDataSource();

  Future<UserModel?> loginWithGoogle() async {
    final user = await _remote.signInWithGoogle();
    if (user == null) return null;

    return UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      photo: user.photoURL,
    );
  }

  Future<void> verifyPhone({
    required String phoneNumber,
    required Function(String verificationId) onCodeSent,
  }) async {
    await _remote.verifyPhone(phoneNumber: phoneNumber, onCodeSent: onCodeSent);
  }

  Future<UserModel?> verifyOtp({
    required String verificationId,
    required String otp,
  }) async {
    final user = await _remote.verifyOtp(
      verificationId: verificationId,
      smsCode: otp,
    );

    if (user == null) return null;

    return UserModel(
      uid: user.uid,
      name: user.displayName,
      email: user.email,
      photo: user.photoURL,
    );
  }
}
