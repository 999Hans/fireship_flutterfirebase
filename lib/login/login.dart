import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/services/auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              FlutterLogo(
                size: 150,
              ),
              Flexible(
                child: LoginButton(
                    text: 'Continue as Guest',
                    color: Colors.deepPurple,
                    icon: FontAwesomeIcons.userNinja,
                    loginMethod: AuthService().anonLogin),
              ),
              LoginButton(
                  text: 'Sign in with Google',
                  color: Colors.blue,
                  icon: FontAwesomeIcons.google,
                  loginMethod: AuthService().googleLogin),
              FutureBuilder<Object>(
                future: SignInWithApple.isAvailable(),
                builder: (context, snapshot) {
                  if (snapshot.data == true) {
                    return SignInWithAppleButton(
                      onPressed: () {
                        AuthService().signInWithApple();
                      },
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ]),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final String text;
  final Color color;
  final IconData icon;
  final Function loginMethod;

  const LoginButton({
    Key? key,
    required this.text,
    required this.color,
    required this.icon,
    required this.loginMethod,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () => loginMethod(),
        label: Text(text),
      ),
    );
  }
}
