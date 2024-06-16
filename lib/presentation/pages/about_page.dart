import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../utils/assets.dart';
import '../utils/theme/themes.dart';

class AboutPage extends StatefulWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  State<AboutPage> createState() => _AboutPageState();
}

class _AboutPageState extends State<AboutPage> {
  @override
  void initState() {
    super.initState();
    _getPackageInfo();
  }

  PackageInfo _packageInfo = PackageInfo(
    appName: 'Dartking',
    packageName: 'DartMusic',
    version: 'Unknown',
    buildNumber: 'Unknown',
  );

  Future<void> _getPackageInfo() async {
    final PackageInfo info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Themes.getTheme().secondaryColor,
        appBar: AppBar(
          backgroundColor: Themes.getTheme().primaryColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(
              Icons.arrow_back_ios_rounded,
            ),
          ),
          title: const Text(
            'About',
          ),
        ),
        // package info

        body: Ink(
          padding: const EdgeInsets.fromLTRB(
            32,
            16,
            32,
            16,
          ),
          decoration: BoxDecoration(
            gradient: Themes.getTheme().linearGradient,
          ),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // logo
              Center(
                child: Hero(
                  tag: 'logo',
                  child: Image.asset(
                    'assets/images/icon1.png',
                    width: 140,
                    height: 140,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              Center(
                child: const Text(
                  'DartMusic',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Divider(
                height: 20,
              ),

              const Row(children: <Widget>[
                Icon(Icons.star),
                SizedBox(
                  width: 10,
                ),
                Text(
                  'About',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              Text(
                'This was my First Music app, build for local storage sounds and songs. ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),

              Divider(
                height: 20,
              ),

              Row(children: [
                // github
                const Text(
                  'Source Code',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              TextButton(
                onPressed: () {
                  launchUrlString(Links.sourceCode);
                },
                child: const Text("Github"),
              ),

              Divider(
                height: 20,
              ),
              Row(children: [
                const Text(
                  'LinkeIn',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              TextButton(
                onPressed: () {
                  launchUrlString(Links.linkedInAccount);
                },
                child: const Text("LinkedIn"),
              ),

              Divider(
                height: 20,
              ),
              Row(children: [
                const Text(
                  'Contact',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ]),
              TextButton(
                onPressed: () {
                  launchUrlString('mailto:saurabhkatkar24@gmail.com');
                },
                child: const Text("Email"),
              ),
            ]),
          ),
        ));
  }
}
