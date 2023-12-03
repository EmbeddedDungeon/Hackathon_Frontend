import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'ListOfCampaignsScreen.dart';
import 'main.dart';

class AuthenticationScreen extends StatefulWidget {
  @override
  _AuthenticationScreenState createState() => _AuthenticationScreenState();
}

class _AuthenticationScreenState extends State<AuthenticationScreen> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  String? _errorMessage;

  Future<void> initializeFirebase() async {
    try {
      await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      );
    } catch (e) {
      print("Firebase initialisation error: $e");
    }
  }

  @override
  void initState() {
    initializeFirebase();
    super.initState();
  }

  Future<void> signInWithFirebase(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "user1@example.com", password: "user1@example.com",
        //email: email,
        //password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        //send in DB this user.uid; fjr db check it in firebase fron firebase admin

        //if (user.email == 'user1@example.com') {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => ListOfCompaignsScreen(),
        ));
        //}
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Non-existent user name or password ';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Authentication"),
        backgroundColor: Color.fromRGBO(220, 220, 220, 1.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Image.asset(
                'assets/images/logo.png',
                width: 100,
              ),
            ),
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),

            SizedBox(height: 20), // space between elements

            TextField(
              controller: _usernameController,
              cursorColor: Colors.lightGreen,
              decoration: InputDecoration(
                labelText: 'Username',
                labelStyle: TextStyle(
                  color: Colors.grey, // caption
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            TextField(
              controller: _passwordController,
              cursorColor: Colors.lightGreen,
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(
                  color: Colors.grey, // caption
                ),
                border: OutlineInputBorder(),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.lightGreen,
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final username = _usernameController.text;
                final password = _passwordController.text;
                signInWithFirebase(username, password);
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue,
                // Цвет кнопки
                onPrimary: Colors.white,
                // Цвет текста кнопки
                minimumSize: Size(double.infinity, 50),
                // Ширина кнопки на весь экран
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                elevation: 3, // shadow
              ),
              child: Text('Sign in', style: TextStyle(fontSize: 20)),
            ),
          ],
        ),
      ),
    );
  }
}
