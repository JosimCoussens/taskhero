import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:taskhero/data/auth/auth.dart';
import 'package:taskhero/core/constants.dart';
import 'package:taskhero/data/user_service.dart';
import 'package:taskhero/widget_tree.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: credentialsInputFields(context),
        ),
      ),
    );
  }

  Widget credentialsInputFields(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          spacing: AppParams.generalSpacing / 2,
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
        ),
      ),
    );
  }

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
          MaterialPageRoute(builder: (context) => const WidgetTree()),
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
            MaterialPageRoute(builder: (context) => const WidgetTree()),
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
          style: const TextStyle(fontSize: 18, color: Colors.white),
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

  Row registerText() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Color.fromARGB(255, 150, 150, 150)),
        ),
        Text(" Register"),
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
            // Go to widget tree
            mounted
                ? Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const WidgetTree()),
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
    return const Row(
      children: [
        Expanded(
          child: Divider(color: Colors.black, thickness: 1, endIndent: 10),
        ),
        Text("or", style: TextStyle(fontSize: 16)),
        Expanded(child: Divider(color: Colors.black, thickness: 1, indent: 10)),
      ],
    );
  }
}
