import 'package:chatapp_pushnotification/allProvider/auth_provider.dart';
import 'package:chatapp_pushnotification/screens/home_page.dart';
import 'package:chatapp_pushnotification/widgets/loading_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);
    switch (authProvider.status) {
      case Status.authenticateError:
        Fluttertoast.showToast(msg: 'problemmeeeeee');
        break;
      case Status.authenticateCanceled:
        Fluttertoast.showToast(msg: 'abjebrochen');
        break;
      case Status.authenticated:
        Fluttertoast.showToast(msg: 'bämmmm!');
        break;
      default:
        break;
    }
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(28),
            child: Image.asset('images/back.png'),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
              padding: const EdgeInsets.all(28),
              child: GestureDetector(
                onTap: () async {
                  bool isSuccess = await authProvider.handleSignIn();
                  if (isSuccess) {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomePage()));
                  }
                },
                child: Image.asset('images/google_login.jpg'),
              )),
          Positioned(
              child: authProvider.status == Status.authenticating
                  ? const LoadingView()
                  : const SizedBox.shrink())
        ],
      ),
    );
  }
}
