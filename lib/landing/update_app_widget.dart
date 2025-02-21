import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:proventi/global/style.dart';
import 'package:url_launcher/url_launcher.dart';

import '../environment_config.dart';

class UpdateAppWidget extends StatelessWidget {
  final String appVersion;

  UpdateAppWidget({required this.appVersion});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: blackDir,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/logo.png',
            width: MediaQuery.of(context).size.width / 3,
          ),
          Text('v. $version_app', style: TextStyle(fontSize: 11, color: Colors.grey.shade200, fontWeight: FontWeight.w100),),
          SizedBox(height: 30),
          Text('Gentile utente, scarica la nuova versione $appVersion per utilizzare PRO20', style: TextStyle(fontSize: 11, color: Colors.grey.shade200, fontWeight: FontWeight.w100),),
          SizedBox(height: 100),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (Platform.isIOS)
                Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        _launchURL('https://apps.apple.com/it/app/proventi/id6738126437?l=en-GB');
                      },
                      icon: Icon(
                        FontAwesomeIcons.apple,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                    Text('Accedi ad app store', style: TextStyle(fontSize: 5, color: Colors.grey),)
                  ],
                ),
              if (Platform.isAndroid)
                IconButton(
                  onPressed: () {
                    // Add the URL for the Android app store here
                  },
                  icon: const Icon(
                    FontAwesomeIcons.android,
                    color: Colors.green,
                    size: 40,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}