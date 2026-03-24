import 'package:primecare_mobile/l10n/app_localizations.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../core/colors.dart';

import '../../core/api_client.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:primecare_ui/primecare_ui.dart';

class PswProfileScreen extends StatefulWidget {
  const PswProfileScreen({super.key});

  @override
  State<PswProfileScreen> createState() => _PswProfileScreenState();
}

class _PswProfileScreenState extends State<PswProfileScreen> {
  bool _isLoading = true;
  bool _isSaving = false;
  Uint8List? _profileImageBytes;
  final ImagePicker _picker = ImagePicker();

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  void _loadProfile() async {
    try {
      final response = await apiClient.get('/v1/user/profile');
      final profile = response['profile'];
      if (mounted && profile != null) {
        setState(() {
          _firstNameController.text = profile['firstName'] ?? '';
          _lastNameController.text = profile['lastName'] ?? '';
          _phoneController.text = profile['phoneNumber'] ?? '';
          // Avatar load skipped for brevity unless already cached
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null && mounted) {
        final bytes = await pickedFile.readAsBytes();
        setState(() => _profileImageBytes = bytes);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: PrimeCareText(AppLocalizations.of(context)!.avatarStagedForUpload), backgroundColor: PrimeCareColors.emerald),
        );
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: PrimeCareText('Could not open gallery: $e'), backgroundColor: PrimeCareColors.rose));
    }
  }

  void _handleLogout(BuildContext context) async {
    await apiClient.logout();
    if (context.mounted) context.go('/login');
  }

  Future<void> _handleSaveForm() async {
      setState(() => _isSaving = true);
      try {
        String? base64Image;
        if (_profileImageBytes != null) {
          base64Image = base64Encode(_profileImageBytes!);
        }

        final payload = {
          'firstName': _firstNameController.text,
          'lastName': _lastNameController.text,
          'phoneNumber': _phoneController.text,
        };

        if (base64Image != null) {
          payload['avatarBase64'] = base64Image;
        }

        final response = await apiClient.put('/v1/user/profile', payload);
        
        if (mounted) {
          if (response != null && response['avatarUrl'] != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_avatar', response['avatarUrl']);
          }

          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: PrimeCareText(AppLocalizations.of(context)!.profileSynchronizedWithPrimecareNetworksSafely),
              backgroundColor: PrimeCareColors.emerald,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          setState(() => _isSaving = false);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: PrimeCareText('Error updating profile: $e'), backgroundColor: PrimeCareColors.rose),
          );
        }
      }
  }

  void _showChangePasswordDialog() {
    final curController = TextEditingController();
    final newController = TextEditingController();
    bool isChanging = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
              title: Row(
                children: [
                  Icon(Icons.lock_reset_rounded, color: PrimeCareColors.rose),
                  const SizedBox(width: 8),
                  PrimeCareText(AppLocalizations.of(context)!.changePassword, style: const TextStyle(fontWeight: FontWeight.bold)),
                ]
              ),
              content: PrimeCareColumn(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: curController, obscureText: true, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.currentPassword, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                  const SizedBox(height: 16),
                  TextField(controller: newController, obscureText: true, decoration: InputDecoration(labelText: AppLocalizations.of(context)!.newPassword, border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
                ],
              ),
              actions: [
                PrimeCareButton(type: PrimeCareButtonType.text, 
                  onPressed: isChanging ? null : () => Navigator.of(dialogContext).pop(),
                  child: PrimeCareText(AppLocalizations.of(context)!.cancel),
                ),
                PrimeCareButton(type: PrimeCareButtonType.primary, 
                  onPressed: isChanging ? null : () async {
                    setDialogState(() => isChanging = true);
                    try {
                      await apiClient.post('/v1/user/change-password', {
                        'currentPassword': curController.text,
                        'newPassword': newController.text,
                      });
                      if (context.mounted) {
                        Navigator.of(dialogContext).pop();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: PrimeCareText(AppLocalizations.of(context)!.passwordProtectedSuccessfully), backgroundColor: PrimeCareColors.emerald));
                      }
                    } catch (e) {
                      if (context.mounted) {
                        setDialogState(() => isChanging = false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: PrimeCareText(e.toString()), backgroundColor: PrimeCareColors.rose));
                      }
                    }
                  },
                  child: isChanging ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : PrimeCareText(AppLocalizations.of(context)!.update),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PrimeCareScaffold(
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : DesktopPaneWrapper(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: PrimeCareColumn(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              // 1. Avatar Section
              PrimeCareCenter(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: PrimeCareStack(
                    alignment: Alignment.bottomRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(color: Theme.of(context).primaryColor.withValues(alpha: 0.3), blurRadius: 20, spreadRadius: 5)
                          ]
                        ),
                        child: CircleAvatar(
                          radius: 64,
                          backgroundColor: Theme.of(context).colorScheme.primary.withValues(alpha: 0.1),
                          backgroundImage: _profileImageBytes != null ? MemoryImage(_profileImageBytes!) : null,
                          child: _profileImageBytes == null 
                              ? PrimeCareIcon(Icons.person_pin_rounded, size: 64, color: Theme.of(context).colorScheme.primary)
                              : null,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle, boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4)]),
                        child: PrimeCareIcon(Icons.camera_alt_rounded, size: 24, color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              // 2. Personal Information Shaded Block
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 15, offset: const Offset(0, 8), spreadRadius: 2)
                  ]
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.fingerprint_rounded, color: Theme.of(context).primaryColor, size: 28),
                        const SizedBox(width: 12),
                        const Text('Personal Identity', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 24),
                    _buildShadowedTextField(label: 'First Name', controller: _firstNameController, icon: Icons.badge_outlined),
                    const SizedBox(height: 16),
                    _buildShadowedTextField(label: 'Last Name', controller: _lastNameController, icon: Icons.badge_outlined),
                    const SizedBox(height: 16),
                    _buildShadowedTextField(label: 'Direct Phone Line', controller: _phoneController, icon: Icons.phone_android_rounded),
                    
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: _isSaving ? null : _handleSaveForm,
                        icon: _isSaving ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Icon(Icons.cloud_upload_rounded, color: Colors.white),
                        label: const Text('Synchronize Profile', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          elevation: 6,
                          shadowColor: Theme.of(context).primaryColor.withValues(alpha: 0.5)
                        ),
                      )
                    )
                  ]
                ),
              ),

              const SizedBox(height: 24),
              // 3. Security Subsystem Shaded Block
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: PrimeCareColors.rose.withValues(alpha: 0.05),
                  border: Border.all(color: PrimeCareColors.rose.withValues(alpha: 0.2), width: 2),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.security_rounded, color: PrimeCareColors.rose, size: 28),
                        const SizedBox(width: 12),
                        Text('Security Architecture', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: PrimeCareColors.rose)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('Restrict access protocols and manage persistent authentication lifecycles globally below.', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: _showChangePasswordDialog,
                        icon: Icon(Icons.key_rounded, color: PrimeCareColors.rose),
                        label: Text('Rotate Cipher Access Key', style: TextStyle(fontWeight: FontWeight.bold, color: PrimeCareColors.rose)),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: PrimeCareColors.rose.withValues(alpha: 0.5)),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                        )
                      )
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => _handleLogout(context),
                        icon: const Icon(Icons.exit_to_app_rounded, color: Colors.white),
                        label: const Text('Execute System Wipe & Logout', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: PrimeCareColors.rose,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))
                        )
                      )
                    )
                  ]
                ),
              ),
              const SizedBox(height: 64), // Scroll padding
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShadowedTextField({required String label, required TextEditingController controller, required IconData icon}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
           BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 6, offset: const Offset(0, 2))
        ]
      ),
      child: TextField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Theme.of(context).primaryColor),
          labelText: label,
          labelStyle: TextStyle(color: Colors.grey[500], fontWeight: FontWeight.bold),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
          filled: true,
          fillColor: Colors.transparent,
        ),
      ),
    );
  }
}
