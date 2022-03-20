import 'dart:ui';

import 'package:chatapp_pushnotification/allModels/popup_choices.dart';
import 'package:chatapp_pushnotification/allProvider/auth_provider.dart';
import 'package:chatapp_pushnotification/constants/color_constants.dart';
import 'package:chatapp_pushnotification/main.dart';
import 'package:chatapp_pushnotification/screens/login_page.dart';
import 'package:chatapp_pushnotification/screens/settings.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GoogleSignIn googleSignIn = GoogleSignIn();
  final ScrollController listScrollController = ScrollController();

  int _limit = 20;
  int _listIncrement = 20;
  String _textSearch = "";
  bool isLoading = false;

  late String currendUserId;
  late AuthProvider authProvider;
//late HomeProvider homeProvider;

  List<PopupChoices> choices = <PopupChoices>[
    PopupChoices(icon: Icons.settings, title: 'Setting'),
    PopupChoices(icon: Icons.exit_to_app, title: 'Sign Out'),
  ];

  Future<void> handleSignOut() async {
    authProvider.handleSignOut();
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const LoginPage()));
  }

  void scrollListener() {
    if (listScrollController.offset >=
            listScrollController.position.maxScrollExtent &&
        !listScrollController.position.outOfRange) {
      setState(() {
        _limit += _listIncrement;
      });
    }
  }

  void onItemMenuPress(PopupChoices choice) {
    if (choice.title == 'Sign Out') {
      handleSignOut();
    } else {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SettingPage()));
    }
  }

  Widget buildPopupMenu() {
    return PopupMenuButton<PopupChoices>(
        icon: const Icon(
          Icons.more_vert,
          color: Colors.green,
        ),
        onSelected: onItemMenuPress,
        itemBuilder: (BuildContext context) {
          return choices.map((PopupChoices choice) {
            return PopupMenuItem<PopupChoices>(
                value: choice,
                child: Row(
                  children: [
                    Icon(choice.icon, color: ColorConstants.primaryColor),
                    Container(
                      width: 10,
                    ),
                    Text(
                      choice.title,
                      style:
                          const TextStyle(color: ColorConstants.primaryColor),
                    ),
                  ],
                ));
          }).toList();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    authProvider = context.read<AuthProvider>();
//homeProvider=context.read<HomeProvider>();
    if (authProvider.getUserFirebaseId()?.isNotEmpty == true) {
      currendUserId = authProvider.getUserFirebaseId()!;
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
    listScrollController.addListener(scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isWhite ? Colors.white : Colors.black,
      appBar: AppBar(
        backgroundColor: isWhite ? Colors.white : Colors.black,
        leading: IconButton(
          onPressed: () => "",
          icon: Switch(
            value: isWhite,
            onChanged: (value) {
              setState(() {
                isWhite = value;
                print(isWhite);
              });
            },
            activeTrackColor: Colors.grey,
            activeColor: Colors.white,
            inactiveTrackColor: Colors.grey,
            inactiveThumbColor: Colors.black54,
          ),
        ),
        actions: [buildPopupMenu()],
      ),
    );
  }
}
