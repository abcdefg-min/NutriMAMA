import 'package:flutter/material.dart';
import 'package:flutter_nutrimama/nutriMAMAScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void _loginSc() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NutriMAMAScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: 300.0,
          child: Column(
          mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 30.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Логин',
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 30.0),
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Пароль',
              border: OutlineInputBorder()
            ),
          ),
          SizedBox(height: 50.0),
          Center(
                  child: ElevatedButton(
                    onPressed: _loginSc,
                    child: const Text("Войти"),
                    style: ElevatedButton.styleFrom(
                      textStyle: TextStyle(fontSize: 20),
                      backgroundColor: const Color.fromARGB(255, 184, 137, 189),
                      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
                      padding: EdgeInsets.all(15),
                      elevation: 5,
                      minimumSize: Size(200, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadiusGeometry.circular(10),
                      ),
                    ),
                  ),
                ),
        ],
          ),
          
        ),
        
      ),
    );
  }
}