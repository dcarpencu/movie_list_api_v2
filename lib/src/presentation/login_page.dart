import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:movie_list_api_v2/src/actions/index.dart';
import 'package:movie_list_api_v2/src/actions/login.dart';
import 'package:movie_list_api_v2/src/models/app_state.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final FocusNode _passwordNode = FocusNode();

  void _onNext(BuildContext context) {
    if (!Form.of(context)!.validate()) {
      return;
    }
    StoreProvider.of<AppState>(context).dispatch(
        Login(email: _email.text, password: _password.text, onResult: _onResult),);
  }

  void _onResult(AppAction action) {
    if (action is ErrorAction) {
      final Object error = action.error;
      
      if (error is FirebaseAuthException) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.message ?? '')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$error')));
      }

      if (kDebugMode) {
        print(action.error);
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Builder(
          builder: (BuildContext context) {
            return SafeArea(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
                    TextFormField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: 'email',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        } else if (!value.contains('@')) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      onFieldSubmitted: (String value) {
                        FocusScope.of(context).requestFocus(_passwordNode);
                      },
                    ),
                    TextFormField(
                      controller: _password,
                      focusNode: _passwordNode,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'password',
                      ),
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 6) {
                          return 'Please enter a password longer than 6 characters.';
                        }
                        return null;
                      },
                      onFieldSubmitted: (String value) {
                        _onNext(context);
                      },
                    ),
                    const SizedBox(height: 16),
                    TextButton(
                        onPressed: () => _onNext(context),
                        child: const Text('Login'),)
                  ],),
                ),
              ),);
          },
        ),
      ),
    );
  }
}
