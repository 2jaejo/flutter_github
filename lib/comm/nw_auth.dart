import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

enum _SupportState {
  unknown,
  supported,
  unsupported,
}

class NwAuth extends StatefulWidget {
  const NwAuth({super.key});

  @override
  State<NwAuth> createState() => _NwAuthState();
}

class _NwAuthState extends State<NwAuth> {
  final LocalAuthentication auth = LocalAuthentication();
  _SupportState _supportState = _SupportState.unknown;
  String _authorized = '인증 실패';
  bool _isAuthenticating = false;

  @override
  void initState() {
    super.initState();
    getBiometrics();
    auth.isDeviceSupported().then(
          (bool isSupported) => setState(() => _supportState = isSupported
              ? _SupportState.supported
              : _SupportState.unsupported),
        );
  }

  _setAuthState(state, auth) {
    setState(() {
      _isAuthenticating = state;
      var str;
      switch (auth) {
        case '1':
          str = '인증 완료';
          break;
        case '0':
          str = '인증 실패';
          break;
        default:
          str = '인증 진행중';
          break;
      }
      _authorized = str;
    });
  }

  Future<List<BiometricType>> getBiometrics() async {
    try {
      return await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e);
      return <BiometricType>[];
    }
  }

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      _setAuthState(true, '3');
      authenticated = await auth.authenticate(
        localizedReason: '생체인증을 진행하세요.',
        options: const AuthenticationOptions(
          biometricOnly: true,
          useErrorDialogs: false,
        ),
        authMessages: const <AuthMessages>[
          AndroidAuthMessages(
            signInTitle: '생체인증',
            biometricHint: '',
            cancelButton: '취소',
          ),
          IOSAuthMessages(
            cancelButton: '취소',
          ),
        ],
      );
    } on PlatformException catch (e) {
      print(e);
    }
    if (!mounted) {
      return;
    }

    _setAuthState(false, authenticated ? '1' : '0');
  }

  Future<void> _cancelAuthentication() async {
    await auth.stopAuthentication();
    _setAuthState(false, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        (_supportState == _SupportState.supported)
            ? const Text('This device is supported')
            : const Text('This device is not supported'),
        const Divider(height: 100),
        Text('Current State: $_authorized\n'),
        Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: _cancelAuthentication,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text('Cancel Authentication'),
                  Icon(Icons.cancel),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: _authenticate,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const <Widget>[
                  Text('Authenticate'),
                  Icon(Icons.fingerprint),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class NwAuthSocial {
  //구글 로그인
  Future<GoogleSignInAccount?> signInWithGoogle() async {
    // Trigger the Google authentication flow
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);

      if (googleUser != null) {
        print('name = ${googleUser.displayName}');
        print('email = ${googleUser.email}');
        print('id = ${googleUser.id}');
        print('photoUrl = ${googleUser.photoUrl}');
        print('serverAuthCode = ${googleUser.serverAuthCode}');

        print('구글계정으로 로그인 성공');
      }
      return googleUser;
    } catch (error) {
      print('구글계정으로 로그인 실패 $error');

      return null;
    }
  }

  //카카오 로그인
  Future<kakao.User?> signInWithKaKao() async {
    var result;
    try {
      kakao.OAuthToken token;
      token = await kakao.UserApi.instance.loginWithKakaoAccount();

      kakao.User user = await kakao.UserApi.instance.me();
      print(token);
      print(user);
      print(user.id);
      print(user.kakaoAccount?.email);
      print('카카오계정으로 로그인 성공');
      result = user;
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
      result = null;
    }

    return result;
  }
}
