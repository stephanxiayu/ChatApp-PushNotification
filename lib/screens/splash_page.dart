import 'package:chatapp_pushnotification/allProvider/auth_provider.dart';
import 'package:chatapp_pushnotification/screens/home_page.dart';
import 'package:chatapp_pushnotification/screens/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(const Duration(seconds: 3), (() {
      checkSignIn();
    }));
  }

  void checkSignIn() async {
    AuthProvider authProvider = context.read<AuthProvider>();
    bool isLoggedIn = await authProvider.isLoggedIn();
    if (isLoggedIn) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
      return;
    }
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('images/splash.png'),
          const SizedBox(
            height: 20,
          ),
          Container(
            height: 20,
            width: 20,
            child: const CircularProgressIndicator(
              color: Colors.red,
            ),
          )
        ],
      )),
    );
  }
}
