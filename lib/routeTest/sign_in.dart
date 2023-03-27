import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final _formKey = GlobalKey<FormState>();
  final idCtrl = TextEditingController();
  final pwCtrl = TextEditingController();
  final emailCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<dynamic, dynamic>?;
    if (args != null) {
      idCtrl.text = args['id'];
      pwCtrl.text = args['pw'];
      emailCtrl.text = args['email'];
    }

    return Scaffold(
        appBar: AppBar(title: Text('회원가입')),
        body: Center(
            child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Column(children: [
                    TextFormField(
                      controller: idCtrl,
                      decoration: InputDecoration(
                        labelText: 'ID',
                      ),
                    ),
                    TextFormField(
                      controller: pwCtrl,
                      decoration: InputDecoration(
                        labelText: 'PW',
                      ),
                    ),
                    TextFormField(
                      controller: emailCtrl,
                      decoration: InputDecoration(
                        labelText: 'EMAIL',
                      ),
                    ),
                  ]),
                )))));
  }
}
