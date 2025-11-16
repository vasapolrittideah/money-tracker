import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared/shared.dart';

abstract class IOAuthRepository {
  Future<Either<Failure, Unit>> signInWithFacebook();
  Future<Either<Failure, Unit>> signInWithGoogle();
}

class OAuthRepository implements IOAuthRepository {
  OAuthRepository() {
    _initializeGoogleSignIn();
  }

  final _googleSignIn = GoogleSignIn.instance;
  bool _isGoogleSignInInitialized = false;

  @override
  Future<Either<Failure, Unit>> signInWithFacebook() => ErrorHandler.handle(() async {
    final result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);

    if (result.status == LoginStatus.success) {
      final accessToken = result.accessToken;

      // TODO: Commuinicate with backend server with Facebook access token
      print('Access token: ${accessToken?.tokenString}');
    } else if (result.status == LoginStatus.cancelled) {
      throw FacebookSignInException('Facebook sign-in was cancelled by the user.');
    } else {
      throw FacebookSignInException('Facebook sign-in failed: ${result.message}');
    }

    return unit;
  });

  @override
  Future<Either<Failure, Unit>> signInWithGoogle() => ErrorHandler.handle(() async {
    if (!_isGoogleSignInInitialized) {
      await _initializeGoogleSignIn();
    }

    final GoogleSignInAccount account = await _googleSignIn.authenticate(scopeHint: ['email']);

    // TODO: Commuinicate with backend server with Google ID token
    print('Google account auth: ${account.toString()}');

    return unit;
  });

  Future<void> _initializeGoogleSignIn() async {
    await _googleSignIn.initialize();
    _isGoogleSignInInitialized = true;
  }
}
