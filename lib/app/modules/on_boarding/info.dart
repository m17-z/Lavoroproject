// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, deprecated_member_use, avoid_print, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InfoPageBody(),
    );
  }
}

class InfoPageBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return body(context);
  }

  Widget body(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return CustomScrollView(
      physics: const NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          snap: false,
          floating: false,
          elevation: 0,
          backgroundColor: isDarkMode
              ? const Color.fromARGB(255, 0, 0, 0)
              : const Color.fromARGB(255, 251, 250, 251),
          iconTheme: const IconThemeData(color: Colors.black),
          expandedHeight: height * 0.44,
          flexibleSpace: FlexibleSpaceBar(
            background: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Container(
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(80),
                      bottomRight: Radius.circular(80),
                    ),
                    image: DecorationImage(
                      image: AssetImage('assets/logo/about.gif'),
                     
                    ),
                  ),
                ),
              ),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
            ),
            tooltip: 'Go back',
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          centerTitle: true,
        ),
        SliverList(
          delegate: SliverChildListDelegate([
            Column(
              children: [
                 contactAddresses(
                  title: 'Email',
                  subtitle: 'lavoro@emil.com',
                  logo: 'assets/logo/gmail.gif',
                  url: 'https://web.whatsapp.com/',
                  color: Color.fromARGB(255, 253, 57, 3),
                ),
                
                contactAddresses(
                  title: 'WhatsApp',
                  subtitle: '0789042711',
                  logo: 'assets/logo/whatsapp_logo.gif',
                  url: 'https://web.whatsapp.com/',
                  color: Colors.green,
                ),
               contactAddresses(
                  title: 'Facebook',
                  subtitle: 'lavoro',
                  logo: 'assets/logo/facebook_logo.gif',
                  url:
                      'https://web.facebook.com/profile.php?id=100030479496261',
                  color: const Color(0xFF3a449d),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(height: 60),
          ]),
        ),
      ],
    );
  }

  Widget contactAddresses({
    required String title,
    required String subtitle,
    required String logo,
    required String url,
    required Color color,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
      child: MaterialButton(
        color: color,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          leading: Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(logo),
              ),
            ),
          ),
          subtitle:
              Text("  $subtitle", style: const TextStyle(color: Colors.white)),
          trailing: SizedBox(
            width: 55,
            height: 55,
            child: Transform.rotate(
              angle: 3.1,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/logo/arrow.gif"),
                  ),
                ),
              ),
            ),
          ),
        ),
        onPressed: () {
          Fluttertoast.showToast(msg: title);
          SystemHelper.makelink(url);
        },
      ),
    );
  }
}

class SystemHelper {
  static void makeCall(String phoneNumber) {
    openUrl("tel://+962789042711");
  }

  static void makelink(String link) {
    openUrl(link);
  }

  static void closeKeyboard() => FocusManager.instance.primaryFocus?.unfocus();

  static void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }
}
