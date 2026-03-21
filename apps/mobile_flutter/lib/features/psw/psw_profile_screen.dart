import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../core/api_client.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../shared/layouts/desktop_pane_wrapper.dart';
import 'package:primecare_ui/primecare_ui.dart';
import '../shared/sdui_form_builder.dart';

class PswProfileScreen extends StatefulWidget {
  const PswProfileScreen({super.key});

  @override
  State<PswProfileScreen> createState() => _PswProfileScreenState();
}

class _PswProfileScreenState extends State<PswProfileScreen> {
  Map<String, dynamic>? _profileCache;
  String _preferredShift = "Flex Time (Any)";
  bool _isLoading = true;
  Uint8List? _profileImageBytes;
  final ImagePicker _picker = ImagePicker();

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
          _profileCache = profile;
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
          const SnackBar(content: Text('Avatar staged for upload!'), backgroundColor: Color(0xFF10B981)),
        );
      }
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Could not open gallery: $e'), backgroundColor: const Color(0xFFE11D48)));
    }
  }

  void _handleLogout(BuildContext context) async {
    await apiClient.logout();
    if (context.mounted) context.go('/login');
  }

  Future<void> _handleSaveForm(Map<String, dynamic> formData) async {
      try {
        String? base64Image;
        if (_profileImageBytes != null) {
          base64Image = base64Encode(_profileImageBytes!);
        }

        final payload = {
          'firstName': formData['firstName'],
          'lastName': formData['lastName'],
          'phoneNumber': formData['phoneNumber'],
        };

        if (base64Image != null) {
          payload['avatarBase64'] = base64Image;
        }

        final response = await apiClient.put('/v1/user/profile', payload);
        
        if (mounted) {
          // If the server returns final URL, we sync it
          if (response['avatarUrl'] != null) {
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user_avatar', response['avatarUrl']);
          }

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile synchronized with PrimeCare networks safely.'),
              backgroundColor: Color(0xFF10B981),
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error updating profile: $e'), backgroundColor: const Color(0xFFE11D48)),
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
              title: const Text('Change Password'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(controller: curController, obscureText: true, decoration: const InputDecoration(labelText: 'Current Password')),
                  const SizedBox(height: 16),
                  TextField(controller: newController, obscureText: true, decoration: const InputDecoration(labelText: 'New Password')),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isChanging ? null : () => Navigator.of(dialogContext).pop(),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isChanging ? null : () async {
                    setDialogState(() => isChanging = true);
                    try {
                      await apiClient.post('/v1/user/change-password', {
                        'currentPassword': curController.text,
                        'newPassword': newController.text,
                      });
                      if (context.mounted) {
                        Navigator.of(dialogContext).pop();
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password protected successfully.'), backgroundColor: Color(0xFF10B981)));
                      }
                    } catch (e) {
                      if (context.mounted) {
                        setDialogState(() => isChanging = false);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()), backgroundColor: const Color(0xFFE11D48)));
                      }
                    }
                  },
                  child: isChanging ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Update'),
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
    return Scaffold(
      body: DesktopPaneWrapper(
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Avatar Section
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 56,
                        backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(20),
                        backgroundImage: _profileImageBytes != null ? MemoryImage(_profileImageBytes!) : null,
                        child: _profileImageBytes == null 
                            ? Icon(Icons.badge, size: 48, color: Theme.of(context).colorScheme.primary)
                            : null,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primary,
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(8),
                        child: const Icon(Icons.camera_alt, size: 16, color: Colors.white),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              const SizedBox(height: 32),
              
              if (_profileCache != null)
                PrimeCareDynamicFormBuilder(
                  formId: 'psw_profile_onboarding_v1',
                  onSubmitted: () {
                    // SDUI handles the DB POST. We just refresh the visual UI organically.
                    setState(() => _isLoading = true);
                    _loadProfile();
                  },
                ),
                
              const SizedBox(height: 16),
              
              PrimeCareButton(
                onPressed: _showChangePasswordDialog,
                text: 'Change Security Password',
                isPrimary: false,
                icon: Icons.security,
              ),
              const SizedBox(height: 16),
              PrimeCareButton(
                onPressed: () => _handleLogout(context),
                text: 'Sign Out of Application',
                isPrimary: false,
                icon: Icons.logout,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
