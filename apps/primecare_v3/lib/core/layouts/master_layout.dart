import 'package:flutter/material.dart';

class MasterLayout extends StatelessWidget {
  final Widget? sidebar;
  final Widget? topbar;
  final Widget content;
  
  const MasterLayout({
    super.key,
    this.sidebar,
    this.topbar,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topbar != null ? PreferredSize(
        preferredSize: const Size.fromHeight(70),
        child: topbar!,
      ) : null,
      drawer: MediaQuery.of(context).size.width < 800 ? Drawer(child: sidebar) : null,
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (MediaQuery.of(context).size.width >= 800 && sidebar != null)
            SizedBox(
              width: 280,
              child: sidebar,
            ),
          Expanded(
            child: SafeArea(
              child: Container(
                color: const Color(0xFFF1F5F9), // Slate 50 background
                child: content,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
