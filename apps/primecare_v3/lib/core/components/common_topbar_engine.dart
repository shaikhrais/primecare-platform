import 'package:flutter/material.dart';

class CommonTopbarEngine extends StatelessWidget {
  final String screenTitle;
  final VoidCallback onLanguageToggle;
  final VoidCallback onNotificationsTap;

  const CommonTopbarEngine({
    super.key,
    required this.screenTitle,
    required this.onLanguageToggle,
    required this.onNotificationsTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          // Breadcrumb / Title Area
          Text(
            screenTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          
          const Spacer(),
          
          // Language Switcher
          Container(
            height: 36,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(18),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: onLanguageToggle,
              child: const Row(
                children: [
                  Icon(Icons.language, size: 16, color: Colors.black54),
                  SizedBox(width: 6),
                  Text('EN/FR', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87)),
                ],
              ),
            ),
          ),
          
          const SizedBox(width: 16),
          
          // Notifications
          IconButton(
            icon: const Icon(Icons.notifications_outlined, color: Colors.black54),
            onPressed: onNotificationsTap,
          ),
          
          const SizedBox(width: 16),
          
          // Profile Avatar
          const CircleAvatar(
            backgroundColor: Color(0xFF3B82F6),
            radius: 18,
            child: Text('HO', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 13)),
          )
        ],
      ),
    );
  }
}
