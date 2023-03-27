import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// import '../comm/http.dart' as http;
import '../home.dart';
import '../loading.dart';
import '../stateTest/loginState.dart';
import '../comm/nw_comm.dart';

import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart' as kakao;
import 'package:google_sign_in/google_sign_in.dart';

import 'comm/nw_auth.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LoginPage();
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final idCtrl = TextEditingController();
  final pwCtrl = TextEditingController();

  static final storage = FlutterSecureStorage();

  bool _isLoading = true;
  bool _isDisabled = false;

  @override
  void initState() {
    super.initState();

    _getLogInfo();
  }

  Future<String> _getLogInfo() async {
    await Future.delayed(Duration(seconds: 1));
    var userInfo = await storage.read(key: 'isLoggedin');

    var type = (userInfo == null) ? 'login' : 'home';
    Provider.of<LoginState>(context, listen: false).setLog(type);
    _isLoading = false;
    return "log";
  }

  _setLogInfo(status, social) async {
    idCtrl.text = "";
    pwCtrl.text = "";

    await storage.write(
      key: 'isLoggedin',
      value: status,
    );

    await storage.write(
      key: 'social',
      value: social,
    );
  }

  _setDisabled(status) {
    setState(() {
      _isDisabled = status;
    });
  }

  Future<void> _changePage(social, data) async {
    // 서비스 회원가입여부 확인 통신 필요
    // 회원가입 있으면 홈화면으로 이동
    // 아니면 회원가입페이지 푸시
    var result = (idCtrl.text == '1') ? true : false;

    if (result) {
      _setLogInfo('1', social);
      await Provider.of<LoginState>(context, listen: false).setLog('home');
    } else {
      await Nw().showAlert(context, '연결된 회원정보가 없어 회원가입 페이지로 이동합니다.');

      Navigator.pushNamed(context, '/signin', arguments: data);

      if (await kakao.AuthApi.instance.hasToken()) {
        await kakao.UserApi.instance.logout();
        print('kakao 로그아웃 성공, SDK에서 토큰 삭제');
      }

      if (await GoogleSignIn().isSignedIn()) {
        await GoogleSignIn().signOut();
        print('google 로그아웃 성공, SDK에서 토큰 삭제');
      }
    }
  }

  //회원가입
  Future<void> _signIn() async {
    Navigator.pushNamed(context, '/signin');
  }

  //일반 로그인
  Future<void> _signInWithPublic() async {
    _setDisabled(true);
    Map data = {
      'id': 'id Test',
      'pw': 'pw Test',
      'email': 'email Test',
    };
    await Future.delayed(Duration(seconds: 1), () {
      _changePage('none', data);
    });
    _setDisabled(false);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _getLogInfo(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        var result;
        if (_isLoading) {
          result = Loading();
        } else {
          switch (Provider.of<LoginState>(context).log) {
            case 'home':
              result = Home();
              break;
            default:
              result = LoginPage();
              break;
          }
        }
        return result;
      },
    );
  }

  Widget _idField() {
    return TextFormField(
      enabled: !_isDisabled,
      controller: idCtrl,
      decoration: InputDecoration(
        labelText: 'ID',
      ),
    );
  }

  Widget _pwField() {
    return TextFormField(
      enabled: !_isDisabled,
      controller: pwCtrl,
      obscureText: true,
      decoration: InputDecoration(
        labelText: 'PASSWORD',
      ),
    );
  }

  Widget LoginPage() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // appBar: AppBar(title: const Text('Login')),
        body: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Column(
                      children: [
                        _idField(),
                        _pwField(),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: _isDisabled ? null : _signIn,
                    child: const Text(
                      'Sign in',
                      style: TextStyle(decoration: TextDecoration.underline),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _isDisabled ? null : _signInWithPublic,
                    child: const Text('Login'),
                  ),
                  ElevatedButton(
                    onPressed: _isDisabled
                        ? null
                        : () {
                            _setDisabled(true);
                            NwAuthSocial().signInWithGoogle().then((value) {
                              if (value != null) {
                                Map data = {
                                  'id': 'google id Test',
                                  'pw': 'google pw Test',
                                  'email': value.email,
                                };
                                _changePage('google', data);
                              }
                            }).catchError((err) {
                              print('error');
                            }).whenComplete(() {
                              _setDisabled(false);
                            });
                          },
                    child: const Text('Log in with Google'),
                  ),
                  ElevatedButton(
                    onPressed: _isDisabled
                        ? null
                        : () {
                            _setDisabled(true);
                            NwAuthSocial().signInWithKaKao().then((value) {
                              if (value != null) {
                                Map data = {
                                  'id': 'kakao id Test',
                                  'pw': 'kakao pw Test',
                                  'email': value.kakaoAccount?.email,
                                };
                                _changePage('kakao', data);
                              }
                            }).catchError((err) {
                              print('error');
                            }).whenComplete(() {
                              _setDisabled(false);
                            });
                          },
                    child: const Text('Log in with KaKao'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
