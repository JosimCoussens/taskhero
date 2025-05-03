import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:taskhero/components/bottom_app_bar/bottom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: header(),
      body: content(),
      bottomNavigationBar: bottomAppBar(context),
    );
  }

  SafeArea content() {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/knight.png', height: 300),
            const SizedBox(height: 20),
            const Text(
              'What do you want to do today?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
            const Text(
              'Tap + to add your tasks',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Future<dynamic> showTimepicker(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Set task date',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SfDateRangePicker(
                view: DateRangePickerView.month,
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                  // Save selected date: args.value
                },
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.pop(context),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Choose Time'),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

AppBar header() {
  return AppBar(
    automaticallyImplyLeading: false, // Do not show back arrow
    backgroundColor: Colors.white,
    elevation: 0,
    toolbarHeight: 64,
    title: Stack(
      alignment: Alignment.center,
      children: [
        // Centered Title
        const Text(
          'Home',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),

        // Left & Right Widgets
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.filter_list, color: Colors.black),
            Row(
              children: [
                const Text(
                  '112',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 4),
                Image.asset('assets/images/xp_coin.png', height: 20, width: 20),
                const SizedBox(width: 12),
                const CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
