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
      // UNCOMMENT
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        // // COMMENT
        // email: "user1@example.com", password: "user1@example.com",
        email: email,
        password: password,
      );

      final user = userCredential.user;
      // ...

      // // COMMENT
      // final user = "test-user";

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
        backgroundColor: Color.fromRGBO(237, 243, 255, 1.0),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'lib/assets/images/back.png', // Replace with your image path
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Image.asset(
                    'lib/assets/images/logo.png',
                    width: 200,
                  ),
                ),
                if (_errorMessage != null)
                  Text(
                    _errorMessage!,
                    style: TextStyle(color: Colors.red),
                  ),
                SizedBox(height: 20),
                Card(
                  elevation: 3,
                  color: Color.fromRGBO(252, 252, 252, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _usernameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        border: InputBorder.none, // Remove the border
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Card(
                  elevation: 3,
                  color: Color.fromRGBO(252, 252, 252, 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextField(
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: TextStyle(
                          color: Colors.black54,
                        ),
                        border: InputBorder.none, // Remove the border
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
                    primary: Color.fromRGBO(255, 249, 236, 1.0),
                    onPrimary: Colors.black,
                    minimumSize: Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 3,
                  ),
                  child: Text('Sign in', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
