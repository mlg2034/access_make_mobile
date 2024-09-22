import 'dart:developer';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';
@injectable
class BiometrickRepository {
  final LocalAuthentication _localAuthentication = LocalAuthentication();

  Future<bool> authWithBiometric() async {
    try {
      final isAuthenticated = await _localAuthentication.authenticate(
        localizedReason: 'Please authenticate to access this feature',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true, 
        ),
      );
      
      if (!isAuthenticated) {
        log('Biometric authentication failed');
      }
      
      return isAuthenticated;
    } catch (error) {
      log('Biometric error: $error');
      throw Exception('Failed to authenticate using biometrics');
    }
  }
}
