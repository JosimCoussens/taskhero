import 'package:flutter/material.dart';

class LearnFlutterPage extends StatefulWidget {
  const LearnFlutterPage({super.key});

  @override
  State<LearnFlutterPage> createState() => _LearnFlutterPageState();
}

class _LearnFlutterPageState extends State<LearnFlutterPage> {
  bool isSwitch = false;
  bool? isCheckBox = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn Flutter'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(
              context,
            ).pop(); //.pop -> remove page we're currently in
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        actions: [
          IconButton(
            onPressed: () {
              debugPrint('Actions');
            },
            icon: Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('images/einstein.jpg', height: 300),
            SizedBox(height: 10),
            Divider(color: Colors.black),
            Container(
              margin: EdgeInsets.all(10.0),
              padding: EdgeInsets.all(10.0),
              color: Colors.blueGrey,
              width: double.infinity,
              child: Center(
                child: Text(
                  'this is a text widget',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: isSwitch ? Colors.green : Colors.blue,
              ),
              onPressed: () {
                debugPrint('Elevated button');
              },
              child: Text('Elevated button'),
            ),
            OutlinedButton(
              onPressed: () {
                debugPrint('Outlined button');
              },
              child: Text('Outlined button'),
            ),
            TextButton(
              onPressed: () {
                debugPrint('Text button');
              },
              child: Text('Text button'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque, // Click anywhere on the row
              onTap: () {
                debugPrint('This is the row');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.local_fire_department, color: Colors.blue),
                  Text('Row widget'),
                  Icon(Icons.local_fire_department, color: Colors.blue),
                ],
              ),
            ),
            Switch(
              value: isSwitch,
              onChanged: (bool newBool) {
                setState(() {
                  isSwitch = newBool;
                });
              },
            ),
            Checkbox(
              value: isCheckBox,
              onChanged: (bool? newBool) {
                setState(() {
                  isCheckBox = newBool;
                });
              },
            ),
            Image.network(
              'https://media.s-bol.com/k0qYPZ5lqBlr/QW59pM9/550x824.jpg',
              height: 300,
            ),
          ],
        ),
      ),
    );
  }
}
