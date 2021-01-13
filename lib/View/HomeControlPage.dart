import 'package:cqaccount/Controller/LoginController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Home.dart';
import 'LoginPage.dart';
import 'package:cqaccount/Model/User.dart';

class HomeControlPage extends StatefulWidget {
  @override
  _HomeControlPageState createState() => _HomeControlPageState();
}

class _HomeControlPageState extends State<HomeControlPage> {
  final LoginController controller = Get.put(LoginController());

  Future<Widget> goto() async {
    String token = await User.getToken();
    if (token != null) {
      bool refresh = await controller.refresh();
      if (refresh) {
        return HomePage();
      }
    }
    return LoginPage();
  }

  Widget build(BuildContext context) {
    return FutureBuilder(
        future: goto(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: Text('Please wait its loading...'));
          } else {
            return snapshot.data;
          }
        });
  }
}
