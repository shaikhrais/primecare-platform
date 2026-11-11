import 'package:primecare_ui/primecare_ui.dart';

class BrandingSettingsFixture extends StatefulWidget {
 final int mode;
 final TextEditingController controller;
 final bool selected;
 final VoidCallback onTap;
 const BrandingSettingsFixture({super.key,required this.mode,required this.controller,required this.selected,required this.onTap});
 @override State<BrandingSettingsFixture> createState()=>_BrandingSettingsFixtureState();
}
class _BrandingSettingsFixtureState extends State<BrandingSettingsFixture> {
 @override Widget build(BuildContext context)=>switch(widget.mode) {
  0=>_buildSectionCard(title:'Section',subtitle:'Description',child:const Text('Body')),
  1=>_buildColorTextField(label:'Primary color',controller:widget.controller,previewColor:PrimeThemeColor.tryParseHex(widget.controller.text) ?? context.theme.colors.primary),
  _=>_buildLayoutCard(title:'Layout',icon:Icons.dashboard,isSelected:widget.selected,onTap:widget.onTap),
 };
  Widget _buildSectionCard({
    required String title,
    required String subtitle,
    required Widget child,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: context.theme.colors.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.theme.typography.h4.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(subtitle, style: context.theme.typography.bodySmall.copyWith(color: context.theme.colors.onSurfaceVariant)),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }

  Widget _buildColorTextField({
    required String label,
    required TextEditingController controller,
    required Color previewColor,
  }) {
    final theme = context.theme;

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: theme.typography.bodyMedium.copyWith(color: theme.colors.textSecondary),
        hintText: '#HEXCODE',
        hintStyle: TextStyle(color: context.theme.colors.onSurfaceVariant),
        prefixIcon: Container(
          width: 24,
          height: 24,
          margin: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: previewColor,
            border: Border.all(color: context.theme.colors.outlineVariant),
          ),
        ),
        filled: true,
        fillColor: context.theme.colors.background,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: context.theme.colors.outlineVariant),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.primary, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.error),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: theme.colors.error, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (val) {
        if (val != null && val.trim().isNotEmpty) {
          final clean = val.replaceAll('#', '').trim();
          if (clean.length != 6 && clean.length != 8) {
            return 'Enter a valid 6 or 8 character HEX color.';
          }
          final hexRegex = RegExp(r'^[0-9a-fA-F]+$');
          if (!hexRegex.hasMatch(clean)) {
            return 'Enter valid hex characters (0-9, A-F).';
          }
        }
        return null;
      },
      onChanged: (_) {
        setState(() {}); // Triggers preview update
      },
    );
  }

  Widget _buildLayoutCard({
    required String title,
    required IconData icon,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final theme = context.theme;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isSelected ? theme.colors.primary : context.theme.colors.outlineVariant,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12),
          child: Column(
            children: [
              Icon(
                icon,
                color: isSelected ? theme.colors.primary : context.theme.colors.onSurfaceVariant,
                size: 24,
              ),
              const SizedBox(height: 8),
              Text(
                title,
                textAlign: TextAlign.center,
                style: theme.typography.bodySmall.copyWith(
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  color: isSelected ? theme.colors.primary : null,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
