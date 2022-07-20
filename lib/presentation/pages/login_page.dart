import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kopelindo/core/utils/utils.dart';

import 'pages.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  var username;
  var password;
  _showMsg(msg) {
    final snackBar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Login'),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                    ),
                    validator: (usernameValue) {
                      if (usernameValue!.isEmpty) {
                        return 'Please enter username';
                      }
                      username = usernameValue;
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  TextFormField(
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                    ),
                    validator: (passwordValue) {
                      if (passwordValue!.isEmpty) {
                        return 'Please enter password';
                      }
                      password = passwordValue;
                      return null;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _login();
                      }
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _login() async{
    setState(() {
      _isLoading = true;
    });

    var data = {
      'username' : username,
      'password' : password
    };

    var res = await Network().login(data, '/login');
    if(res.statusCode == 200){
      Navigator.pushReplacement<void, void>(
        context,
        MaterialPageRoute<void>(
          builder: (BuildContext context) => const HomePage(),
        ),
      );
    }else{
      _showMsg('Login gagal');
    }

    setState(() {
      _isLoading = false;
    });
  }
}
