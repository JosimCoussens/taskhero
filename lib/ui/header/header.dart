import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taskhero/data/auth/auth.dart';
import 'package:taskhero/data/user_service.dart';
import 'package:taskhero/ui/header/progressbar.dart';
import 'package:taskhero/ui/header/user_overlay.dart';
import 'package:taskhero/core/constants.dart';

class AppHeader extends StatefulWidget implements PreferredSizeWidget {
  final String title;

  const AppHeader({super.key, this.title = 'Home'});

  @override
  State<AppHeader> createState() => _AppHeaderState();

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class _AppHeaderState extends State<AppHeader> {
  final User user = Auth().currentUser!;
  OverlayEntry? _overlayEntry;

  @override
  void dispose() {
    _removeOverlay();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,
      toolbarHeight: widget.preferredSize.height,
      title: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              _PageTitle(widget: widget),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [_userLevel(), _userAvatar(context)],
              ),
            ],
          ),
          ProgressBar(),
        ],
      ),
    );
  }

  GestureDetector _userAvatar(BuildContext context) {
    return GestureDetector(
      onTap: () => _toggleUserMenu(context),
      // Make sure picture fits the circle
      child: CircleAvatar(
        radius: 18,
        backgroundImage:
            UserService.loggedInWithGoogle()
                ? NetworkImage(AppParams.googleProfileImage!)
                : AssetImage(AppParams.defaultProfileImage),
      ),
    );
  }

  Row _userLevel() {
    return Row(
      children: [
        ValueListenableBuilder(
          valueListenable: AppParams.level,
          builder: (context, xp, _) {
            return Text(
              AppParams.level.value.toString(),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
        const SizedBox(width: 4),
        Image.asset(AppParams.coinPath, height: 20, width: 20),
      ],
    );
  }

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

    _overlayEntry = userOverlay(
      offset,
      () => _removeOverlay(),
      widget,
      user.email ?? '',
    );
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }
}

class _PageTitle extends StatelessWidget {
  const _PageTitle({required this.widget});

  final AppHeader widget;

  @override
  Widget build(BuildContext context) {
    return Text(
      widget.title,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
