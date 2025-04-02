import 'package:flutter/material.dart';

class MarvelAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MarvelAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Image.asset('assets/marvel.png', height: 36, fit: BoxFit.contain),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
