import 'package:chatapp_pushnotification/allProvider/auth_provider.dart';
import 'package:chatapp_pushnotification/allProvider/setting_provider.dart';
import 'package:chatapp_pushnotification/constants/app_constants.dart';
import 'package:chatapp_pushnotification/screens/splash_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

bool isWhite = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();

  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  final SharedPreferences prefs;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

  MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(
            create: (_) => AuthProvider(
                  firebaseAuth: FirebaseAuth.instance,
                  googleSignIn: GoogleSignIn(),
                  prefs: prefs,
                  firebaseFirestore: firebaseFirestore,
                )),
        Provider<SettingProvider>(
            create: (_) => SettingProvider(
                prefs: prefs,
                firebaseFirestore: firebaseFirestore,
                firebaseStorage: firebaseStorage))
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: AppConstants.appTitle,
          theme: ThemeData.dark(),
          home: const SplashPage()),
    );
  }
}
