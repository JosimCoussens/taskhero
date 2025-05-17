import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskhero/auth.dart';
import 'package:taskhero/constants.dart';
import 'package:taskhero/pages/login_page.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({super.key, this.title = 'Home'});

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _AppHeaderState extends State<AppHeader> {
  final User? user = Auth().currentUser;
  OverlayEntry? _overlayEntry;

  void _toggleUserMenu(BuildContext context) {
    if (_overlayEntry != null) {
      _removeOverlay();
    } else {
      _showOverlay(context);
    }
  }

  void _showOverlay(BuildContext context) {
    final renderBox = context.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);

    _overlayEntry = OverlayEntry(
      builder:
          (context) => Stack(
            children: [
              GestureDetector(
                onTap: _removeOverlay,
                behavior: HitTestBehavior.translucent,
                child: Container(color: Colors.transparent),
              ),
              Positioned(
                top: offset.dy + widget.preferredSize.height,
                right: 16,
                child: Material(
                  elevation: 8,
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    width: 220,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user?.email ?? 'User Email',
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            _removeOverlay();
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginPage(),
                              ),
                            );
                            await Auth().signOut();
                          },
                          child: const Text('Sign Out'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String avatarPath = AppParams.avatarPath;

    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: widget.preferredSize.height,
      title: Stack(
        alignment: Alignment.center,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: AppParams.xp,
                    builder: (context, xp, _) {
                      return Text(
                        AppParams.xp.value.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  Image.asset(
                    'assets/images/xp_coin.png',
                    height: 20,
                    width: 20,
                  ),
                ],
              ),
              GestureDetector(
                onTap: () => _toggleUserMenu(context),
                child: CircleAvatar(
                  radius: 18,
                  backgroundImage: AssetImage(avatarPath),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
