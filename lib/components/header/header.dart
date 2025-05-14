import 'package:flutter/material.dart';
import 'package:taskhero/constants.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({super.key, this.title = 'Home'});

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    int xp = AppParams.xp;
    String avatarPath = AppParams.avatarPath;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: preferredSize.height,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.filter_list, color: Colors.black),
              Row(
                children: [
                  Text(
                    xp.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    'assets/images/xp_coin.png',
                    height: 20,
                    width: 20,
                  ),
                  const SizedBox(width: 12),
                  CircleAvatar(
                    radius: 18,
                    backgroundImage: AssetImage(avatarPath),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
