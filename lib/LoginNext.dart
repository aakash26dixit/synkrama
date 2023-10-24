import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synkrama/apiCall.dart';

class LoginNext extends StatefulWidget {
  const LoginNext({Key? key}) : super(key: key);

  @override
  State<LoginNext> createState() => _LoginNextState();
}



class _LoginNextState extends State<LoginNext> {

  String username = '', password = '';

  getDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      username = prefs.getString("username") ?? '';
      password = prefs.getString("password") ?? '';
    });
  }

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await getDetails();
    });

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${username}"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("You have set your password: ${password}", style: TextStyle(fontWeight: FontWeight.w800, fontSize: 22.0),),

          ElevatedButton(onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ApiCall()),
            );
          }, child: Text("Next Assignment"))
        ],
      ),
    );
  }
}
