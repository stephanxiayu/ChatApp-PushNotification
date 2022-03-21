import 'dart:io';

import 'package:chatapp_pushnotification/allModels/user_chat.dart';
import 'package:chatapp_pushnotification/allProvider/setting_provider.dart';
import 'package:chatapp_pushnotification/constants/app_constants.dart';
import 'package:chatapp_pushnotification/constants/constants.dart';
import 'package:chatapp_pushnotification/constants/firestore_constants.dart';
import 'package:chatapp_pushnotification/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.green),
        title: const Text(AppConstants.settingsTitle),
        backgroundColor: isWhite ? Colors.white : Colors.black,
      ),
      backgroundColor: isWhite ? Colors.white : Colors.black,
    );
  }
}
