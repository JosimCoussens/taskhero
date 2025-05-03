import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:taskhero/pages/home_page.dart';

class CredentialsPage extends StatelessWidget {
  const CredentialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment:
                CrossAxisAlignment.start, // Align left by default
            children: [
              Center(
                child: Text(
                  'Login',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
              ),
              credentialsInputFields(context),
              divider(),
              Column(
                spacing: 20,
                children: [googleLogin(), appleLogin(), registerText()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row registerText() {
    return Row(
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

  SizedBox appleLogin() {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 100, 186, 251),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/apple.svg', height: 25),
            SizedBox(width: 10),
            Text(
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
          backgroundColor: Color.fromARGB(255, 100, 186, 251),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/images/google.svg', height: 25),
            SizedBox(width: 10),
            Text(
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
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1976D2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(
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
        Text('Username', style: TextStyle(fontSize: 18)),
        SizedBox(
          height: 60,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Username',
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        Text('Password', style: TextStyle(fontSize: 18)),
        SizedBox(
          height: 60,
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter Password',
              filled: true,
              fillColor: Colors.grey[200],
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.blue, width: 3),
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        loginButton(context),
      ],
    );
  }

  Row divider() {
    return Row(
      children: [
        const Expanded(
          child: Divider(color: Colors.black, thickness: 1, endIndent: 10),
        ),
        const Text("or", style: TextStyle(fontSize: 16)),
        const Expanded(
          child: Divider(color: Colors.black, thickness: 1, indent: 10),
        ),
      ],
    );
  }
}
