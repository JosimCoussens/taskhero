import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskhero/auth.dart';
import 'package:taskhero/pages/home_page.dart';

class CredentialsPage extends StatefulWidget {
  const CredentialsPage({super.key});

  @override
  State<CredentialsPage> createState() => _CredentialsPageState();
}

class _CredentialsPageState extends State<CredentialsPage> {
  String? errorMessage = '';
  bool isLogin = true;
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      }
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
        email: _controllerEmail.text,
        password: _controllerPassword.text,
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(String title, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(labelText: title),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ?  $errorMessage');
  }

  Widget _submitButton() {
    return ElevatedButton(
      onPressed:
          isLogin ? signInWithEmailAndPassword : createUserWithEmailAndPassword,
      child: Text(isLogin ? 'Login' : 'Register'),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Text(isLogin ? 'Register instead' : 'Login instead'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const Center(
              //   child: Text(
              //     'Login',
              //     style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
              //   ),
              // ),
              credentialsInputFields(context),
              // divider(),
              // Column(
              //   children: [
              //     googleLogin(),
              //     const SizedBox(height: 10),
              //     appleLogin(),
              //     const SizedBox(height: 10),
              //     registerText(),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }

  Row registerText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Color.fromARGB(255, 150, 150, 150)),
        ),
        Text(" Register"),
      ],
    );
  }

  SizedBox appleLogin() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 100, 186, 251),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/apple.svg', height: 25),
            const SizedBox(width: 10),
            const Text(
              'Login with Apple',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox googleLogin() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color.fromARGB(255, 100, 186, 251),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/google.svg', height: 25),
            const SizedBox(width: 10),
            const Text(
              'Login with Google',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SizedBox loginButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: const Text(
          'LOGIN',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Column credentialsInputFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _entryField('email', _controllerEmail),
        _entryField('password', _controllerPassword),
        _errorMessage(),
        _submitButton(),
        _loginOrRegisterButton(),
        // const Text('Username', style: TextStyle(fontSize: 18)),
        // const SizedBox(height: 10),
        // SizedBox(
        //   height: 60,
        //   child: TextField(
        //     decoration: InputDecoration(
        //       border: const OutlineInputBorder(),
        //       hintText: 'Enter Username',
        //       filled: true,
        //       fillColor: Colors.grey[200],
        //       enabledBorder: const OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.grey, width: 1),
        //       ),
        //       focusedBorder: const OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.blue, width: 3),
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 20),
        // const Text('Password', style: TextStyle(fontSize: 18)),
        // const SizedBox(height: 10),
        // SizedBox(
        //   height: 60,
        //   child: TextField(
        //     obscureText: true,
        //     decoration: InputDecoration(
        //       border: const OutlineInputBorder(),
        //       hintText: 'Enter Password',
        //       filled: true,
        //       fillColor: Colors.grey[200],
        //       enabledBorder: const OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.grey, width: 1),
        //       ),
        //       focusedBorder: const OutlineInputBorder(
        //         borderSide: BorderSide(color: Colors.blue, width: 3),
        //       ),
        //     ),
        //   ),
        // ),
        // const SizedBox(height: 20),
        // loginButton(context),
      ],
    );
  }

  Row divider() {
    return Row(
      children: const [
        Expanded(
          child: Divider(color: Colors.black, thickness: 1, endIndent: 10),
        ),
        Text("or", style: TextStyle(fontSize: 16)),
        Expanded(child: Divider(color: Colors.black, thickness: 1, indent: 10)),
      ],
    );
  }
}
