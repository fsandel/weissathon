import 'package:flutter/material.dart';
import 'package:weiss/main.dart';
import 'package:weiss/widgets/custom_popup.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar(
      {Key? key,
      this.showIcon = true,
      this.customTitle = "Dashboard",
      this.popupmenu = false})
      : super(key: key);

  final bool showIcon;
  final String customTitle;
  final bool popupmenu;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 224, 224, 224),
      toolbarHeight: kToolbarHeight, // Set the toolbar height explicitly
      leading: showIcon
          ? IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MyApp()),
              ),
            )
          : null,
      title: Padding(
        padding: EdgeInsets.only(
            right: showIcon
                ? 40.0
                : 0.0), // Apply left padding when showIcon is true
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 40,
            ),
            const SizedBox(
              width: 5,
            ),
            if (customTitle.isNotEmpty)
              Text(
                customTitle,
                style: const TextStyle(color: Color.fromARGB(255, 49, 56, 59)),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
