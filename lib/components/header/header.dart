import 'package:flutter/material.dart';

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
