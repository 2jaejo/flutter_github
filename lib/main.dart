import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

import 'package:provider/provider.dart';
import '../stateTest/loginState.dart';
import '../pageTest/nw_page.dart';

import '../login.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  KakaoSdk.init(nativeAppKey: '86e05cc1a1c54bcb917833c1f5d9f61b');

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (_) => LoginState()),
  ], child: const Index()));
}

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _Index();
}

class _Index extends State<Index> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // if it's a RTL language
      ],
      supportedLocales: [
        Locale('ko', ''),
        Locale('en', ''),
      ],
      debugShowCheckedModeBanner: false,
      routes: {
        '/a': (context) => NwPage().set('pageA'),
        '/b': (context) => NwPage().set('pageB'),
        '/c': (context) => NwPage().set('pageC'),
        '/signin': (context) => NwPage().set('signin'),
        '/alert': (context) => NwPage().set('alert'),
        '/http': (context) => NwPage().set('http'),
        '/image': (context) => NwPage().set('image'),
        '/picker': (context) => NwPage().set('picker'),
        '/cupertino': (context) => NwPage().set('cupertino'),
        '/regexp': (context) => NwPage().set('regexp'),
        '/localauth': (context) => NwPage().set('localauth'),
        '/foreground': (context) => NwPage().set('foreground'),
      },
      home: Login(),
    );
  }
}
