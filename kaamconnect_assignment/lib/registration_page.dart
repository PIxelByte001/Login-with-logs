import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_logs/flutter_logs.dart';

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({Key? key}) : super(key: key);
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool _isEmailValid = false;
  bool _isPasswordValid = false;
  String? _emailError;
  String? _passwordError;

  void _validateEmail(String email) {
    setState((){
      final RegExp emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if (email.isEmpty) {
        _isEmailValid = false;
        _emailError = 'Email address is required';
      } else if (!emailRegExp.hasMatch(email)) {
        if (!email.contains('@')) {
          _isEmailValid = false;
          _emailError = "Email must contain '@' symbol";
          FlutterLogs.logWarn('KaamConnect Assignment', 'Email Validation', 'Invalid email entered (@ missing): $email');
        } else {
          _isEmailValid = false;
          _emailError = "Invalid email";
          FlutterLogs.logWarn('KaamConnect Assignment', 'Email Validation', 'Invalid email entered: $email');
        }
      } else {
        _isEmailValid = true;
        _emailError = null;
        FlutterLogs.logInfo('KaamConnect Assignment', 'Email Validation', 'Valid email entered: $email');
      }

    });
  }

  void _validatePassword(String password) {
    setState(() {
      final RegExp passwordRegExp = RegExp(
      r'^(?=.*?[A-Z].*?[A-Z])(?=.*?[a-z])(?=.*?[!@#$&~^]).{8,50}$'
      );

      if (password.isEmpty) {
        _isPasswordValid = false;
        _passwordError = 'Password is required';
      } else if (!passwordRegExp.hasMatch(password)) {
        _isPasswordValid = false;
        if (password.length < 8 || password.length > 50) {
          _passwordError = 'Password must be between 8 and 50 characters long';
          FlutterLogs.logWarn('KaamConnect Assignment', 'Password Validation', 'Invalid password entered');
        } else if (!RegExp(r'[A-Z].*[A-Z]').hasMatch(password)) {
          _passwordError = 'Password must contain at least two capital letters';
          FlutterLogs.logWarn('KaamConnect Assignment', 'Password Validation', 'Invalid password entered');
        } else if (!RegExp(r'[a-z]').hasMatch(password)) {
          _passwordError = 'Password must contain at least one small letter';
          FlutterLogs.logWarn('KaamConnect Assignment', 'Password Validation', 'Invalid password entered');
        } else if (!RegExp(r'[!@#$&~^]').hasMatch(password)) {
          _passwordError = 'Password must contain at least one special\ncharacter (except *)';
          FlutterLogs.logWarn('KaamConnect Assignment', 'Password Validation', 'Invalid password entered');
        } else {
          _passwordError = 'Invalid password';
          FlutterLogs.logWarn('KaamConnect Assignment', 'Password Validation', 'Invalid password entered');
        }
      } else {
        _isPasswordValid = true;
        _passwordError = null;
        FlutterLogs.logInfo('KaamConnect Assignment', 'Password Validation', 'Valid password entered');
      }
    });
  }

  void _register() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Registration Successful')));
    FlutterLogs.logInfo('KaamConnect Assignment', 'Registration', 'New user registerd : $_email');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      TextFormField(
          keyboardType: TextInputType.emailAddress,
          style: TextStyle(fontSize: 16),
          controller: _email,
          cursorColor: Color(0xFF6F35A5),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 0),
            hintText: "Enter your email",
            errorText: _emailError,
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Icon(Icons.person, size: 20,),
            ),
          ),
          onChanged: (value) async{
            setState(() {
              _isEmailValid = false;
            });
              await Future.delayed(Duration(seconds: 1));
              _validateEmail(value);
            },
        ),
        SizedBox(height: 16 ,),
        TextFormField(
          style: TextStyle(fontSize: 16),
          obscureText: true,
          cursorColor: Color(0xFF6F35A5),
          controller: _password,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(0, 14, 0, 0),
            hintText: "Your password",
            errorText: _passwordError,
            prefixIcon: Padding(
              padding: EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
              child: Icon(Icons.lock, size: 20,),
            ),
          ),
          onChanged: (value) async{
            setState(() {
              _isPasswordValid = false;
            });
            await Future.delayed(Duration(seconds: 1));
            _validatePassword(value);
          },
        ),
        SizedBox(height: 36),
        Material(
          color: (_isEmailValid && _isPasswordValid) ? Color(0xFF6F35A5) : Colors.grey,
          borderRadius: BorderRadius.circular(10),
          child: InkWell(
            onTap: (_isEmailValid && _isPasswordValid) ? _register : null,
            child: Padding(
              padding: EdgeInsets.fromLTRB(32, 8, 32, 8),
                child: Text("Sign Up", style: TextStyle(
                    color: Colors.white,
                    fontSize: 13
                    ),),
            )

          ),
        )
      ],
    );
  }
}
