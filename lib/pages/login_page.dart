import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskhero/auth.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/pages/home_page.dart';
import 'package:taskhero/services/user_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
      if (mounted) {
        AppParams.userId = FirebaseAuth.instance.currentUser!.uid;
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
      await UserService.createUser(FirebaseAuth.instance.currentUser!.uid);
      AppParams.userId = FirebaseAuth.instance.currentUser!.uid;
      mounted
          ? Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomePage()),
          )
          : null;
    } on FirebaseAuthException catch (e) {
      setState(() {
        errorMessage = e.message;
      });
    }
  }

  Widget _entryField(TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        filled: true,
        fillColor: Colors.grey.withValues(alpha: 0.1),
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
      ),
    );
  }

  Widget _errorMessage() {
    return Text(errorMessage == '' ? '' : 'Humm ?  $errorMessage');
  }

  Widget _submitButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed:
            isLogin
                ? signInWithEmailAndPassword
                : createUserWithEmailAndPassword,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF1976D2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
          isLogin ? 'Login' : 'Register',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  Widget _loginOrRegisterButton() {
    return TextButton(
      onPressed: () {
        setState(() {
          isLogin = !isLogin;
        });
      },
      child: Center(
        child: Text(isLogin ? 'Register instead' : 'Login instead'),
      ),
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
            children: [credentialsInputFields(context)],
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

  Column credentialsInputFields(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.asset('assets/images/loginpage.jpg'),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Email', style: TextStyle(fontSize: 18)),
            _entryField(_controllerEmail),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Password', style: TextStyle(fontSize: 18)),
            _entryField(_controllerPassword),
          ],
        ),
        _errorMessage(),
        _submitButton(context),
        _loginOrRegisterButton(),
        // Google sign in button
        divider(),
        _loginWithGoogleButton(),
      ],
    );
  }

  SizedBox _loginWithGoogleButton() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () async {
          bool isLogged = await Auth().signInWithGoogle();
          await UserService.createUser(FirebaseAuth.instance.currentUser!.uid);
          AppParams.userId = FirebaseAuth.instance.currentUser!.uid;
          if (isLogged) {
            mounted
                ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                )
                : null;
          }
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: const BorderSide(color: AppColors.primaryLight, width: 2),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            SvgPicture.asset('assets/images/google.svg', height: 24, width: 24),
            const Text(
              'Sign in with Google',
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
