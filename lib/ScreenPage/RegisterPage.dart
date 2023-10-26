import 'package:awatch/ScreenPage/LoginPage.dart';
import 'package:awatch/Utilities/AuthServices.dart';
import 'package:awatch/Utilities/CustomColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'RegisterPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget _emailItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Email'),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: emailController,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.black,
            ),
            decoration: const InputDecoration(
                contentPadding: EdgeInsets.only(top: 14.0),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                hintText: 'Enter your Email',
                hintStyle: TextStyle(
                  color: Colors.black45,
                  fontFamily: 'OpenSans',
                )),
          ),
        )
      ],
    );
  }

  Widget _passwordItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'Password',
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          height: 60.0,
          child: TextField(
            controller: passwordController,
            obscureText: true,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: const InputDecoration(
              contentPadding: EdgeInsets.only(top: 14.0),
              prefixIcon: Icon(
                Icons.lock,
                color: Colors.black,
              ),
              hintText: 'Enter your Password',
              hintStyle: TextStyle(
                color: Colors.black45,
                fontFamily: 'OpenSans',
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _SignupBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          String email = emailController.text;
          String password = passwordController.text;

          AuthService service = AuthService(FirebaseAuth.instance);
          final message =
          await service.signUp(email: email, password: password);

          if (message!.contains('Success')) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
          }

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(message),
            ),
          );
        },
        style: raisedButtonStyle,
        child: const Text(
          'Register',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }
  final ButtonStyle raisedButtonStyle = TextButton.styleFrom(
    padding: EdgeInsets.all(15.0),
    backgroundColor: Colors.deepOrangeAccent,
  );

  Widget _SigninBtn() {
    return GestureDetector(
      onTap: () => {
        Navigator.pop(
            context, MaterialPageRoute(builder: (context) => LoginPage()))
      },
      child: RichText(
        text: const TextSpan(
          children: [
            TextSpan(
              text: 'Already have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Login',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Container(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Expanded(
                flex: 2,
                child: SizedBox(),
              ),
              Expanded(
                flex: 8,
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 21.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          'Register',
                          style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'OpenSans',
                            fontSize: 30.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 30.0),
                        _emailItem(),
                        SizedBox(
                          height: 30.0,
                        ),
                        _passwordItem(),
                        // _ForgotPasswordBtn(),
                        _SignupBtn(),
                        _SigninBtn(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
