import 'package:ecom/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'authservice.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: RegistrationPage(),
    );
  }
}

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 32.0),
              ElevatedButton(
                onPressed: () async {
                  // Handle registration logic here
                  String name = _nameController.text;
                  String email = _emailController.text;
                  String password = _passwordController.text;
        
                  // Perform registration or validation
                  print('Name: $name, Email: $email, Password: $password');




                  // Call the AuthService method for registration
                  User? user = await _auth.registerWithEmailAndPassword(email, password);

                  if (user != null) {
                    print('Registration successful: ${user.uid}');
                    // Navigate to another screen or perform additional tasks after registration
                  } else {
                    print('Registration failed');
                    // Handle registration failure
                  }
                },
                child: Text('Register'),
              ),
              SizedBox(height: 30,),

              InkWell(onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },child: Text("Click here to login.",style: TextStyle(color: Colors.blue,fontSize: 20),))

            ],
          ),
        ),
      ),
    );
  }
}
