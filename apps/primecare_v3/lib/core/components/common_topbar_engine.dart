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
          
          // Care Profile Menu Popup
          PopupMenuButton<int>(
            offset: const Offset(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 8,
            color: Colors.white,
            position: PopupMenuPosition.under,
            tooltip: 'Care Profile',
            itemBuilder: (context) => [
              PopupMenuItem<int>(
                value: 0,
                enabled: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundColor: Color(0xFF3B82F6),
                        backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text('Amanda Higgins', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Color(0xFF0F172A))),
                          Text('Care Coordinator', style: TextStyle(fontSize: 13, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 1,
                child: Row(
                  children: const [
                    Icon(Icons.person_outline, size: 20, color: Color(0xFF0F172A)),
                    SizedBox(width: 12),
                    Text('My Profile', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                  ],
                ),
              ),
              PopupMenuItem<int>(
                value: 2,
                child: Row(
                  children: const [
                    Icon(Icons.settings_outlined, size: 20, color: Color(0xFF0F172A)),
                    SizedBox(width: 12),
                    Text('Account Settings', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0F172A))),
                  ],
                ),
              ),
              const PopupMenuDivider(),
              PopupMenuItem<int>(
                value: 3,
                child: Row(
                  children: const [
                    Icon(Icons.logout_rounded, size: 20, color: Colors.redAccent),
                    SizedBox(width: 12),
                    Text('Sign Out', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.redAccent)),
                  ],
                ),
              ),
            ],
            onSelected: (value) {
              if (value == 3) {
                 ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Signing out securely...')));
                 // Navigator.pushReplacementNamed(context, '/login');
              }
            },
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade200),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, offset: const Offset(0, 2))
                ]
              ),
              child: Row(
                children: const [
                  CircleAvatar(
                    backgroundColor: Color(0xFF3B82F6),
                    radius: 16,
                    backgroundImage: NetworkImage('https://i.pravatar.cc/150?img=5'),
                  ),
                  SizedBox(width: 8),
                  Text('Amanda', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Color(0xFF0F172A))),
                  SizedBox(width: 4),
                  Icon(Icons.keyboard_arrow_down, size: 18, color: Colors.black54),
                  SizedBox(width: 4),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
