import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import '../stateTest/loginState.dart';

class PageD extends StatelessWidget {
  final String title;
  final String message;

  const PageD({Key? key, required this.title, this.message = ''})
      : super(key: key);

  static final storage = FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(child: Text(message)),
            ElevatedButton(
              child: Text('Log Out'),
              onPressed: () {
                _setLogInfo();
                print('logOut');

                Provider.of<LoginState>(context, listen: false).setLog('login');
              },
            ),
          ],
        ),
      ),
    );
  }

  _setLogInfo() async {
    if (await AuthApi.instance.hasToken()) {
      await UserApi.instance.logout();
      print('kakao 로그아웃 성공, SDK에서 토큰 삭제');
    }

    if (await GoogleSignIn().isSignedIn()) {
      await GoogleSignIn().signOut();
      print('google 로그아웃 성공, SDK에서 토큰 삭제');
    }

    await storage.delete(key: 'isLoggedin');
    await storage.delete(key: 'social');
  }
}
