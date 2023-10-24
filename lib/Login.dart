import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:synkrama/LoginNext.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _username = TextEditingController();
  TextEditingController _password = TextEditingController();

  bool usernameValidator = false, passwordValidator = false;



  bool validateEmail(String email) {
    String pattern = r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(email);
  }

  bool validateSpecialSymbols(String value) {
    String pattern = r'[!@#\$%^&*()_+{}\[\]:;<>,.?\/\\|-]';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          // Text(_usernameValidator.toString()),
          TextField(
            controller: _username,
            decoration: InputDecoration(
              labelText: 'Enter the Value',
              border: UnderlineInputBorder(),
              errorText: usernameValidator ? null : "Not a valid email",
            ),
          ),
          TextFormField(
            controller: _password,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Enter the Value',
              errorText: passwordValidator
                  ? null
                  : "Password should be greater than 6 characters with atleast a special symbol" ,
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              try{
                if (validateEmail(_username.text)) {
                  setState(() {
                    usernameValidator = true;
                  });
                } else {
                  setState(() {
                    usernameValidator = false;
                  });
                }
                if (_password.text.length >= 6 && _password.text.length <= 10 && validateSpecialSymbols(_password.text)) {
                  setState(() {
                    passwordValidator = true;
                  });
                } else {
                  setState(() {
                    passwordValidator = false;
                  });
                }

                if (usernameValidator && passwordValidator) {

                  SharedPreferences prefs = await SharedPreferences.getInstance();

                  prefs.setString("username", _username.text);
                  prefs.setString("password", _password.text);

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginNext()),
                  );

                }
              }catch(e,s){print("eeeeeeeeeee: ${e}");}

            },
            child: Text(usernameValidator && passwordValidator
                ? "Successfully Validated"
                : "Validate"),
          )
        ],
      ),
    );
  }
}
