import os
import re

def recovery_v11():
    view_path = 'lib/src/features/features_view.dart'
    with open(view_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Fix AuthInputDecoration
    new_auth_dec = """
class AuthInputDecoration extends InputDecoration {
  AuthInputDecoration({
    String? labelText,
    TextStyle? labelStyle,
    InputBorder? border,
    String? hintText,
    bool? filled,
    Color? fillColor,
    Widget? prefixIcon,
    Widget? suffixIcon,
    bool? alignLabelWithHint,
  }) : super(
    labelText: labelText,
    labelStyle: labelStyle,
    border: border,
    hintText: hintText,
    filled: filled,
    fillColor: fillColor,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    alignLabelWithHint: alignLabelWithHint,
  );
  
  static InputDecoration get(String label, dynamic icon, {String? hintText}) {
    return InputDecoration(
      labelText: label,
      hintText: hintText,
    );
  }
}
"""
    content = re.sub(r'class AuthInputDecoration \{.*?\}', new_auth_dec, content, flags=re.DOTALL)

    # Fix PrimeCareCard if it's broken
    # I'll just add a robust constructor to it
    prime_card_fix = """
class PrimeCareCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width;
  final double? height;
  final Color? color;
  const PrimeCareCard({required this.child, this.padding, this.width, this.height, this.color, Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) => Container(padding: padding, width: width, height: height, color: color, child: child);
}
"""
    if 'class PrimeCareCard' in content:
        content = re.sub(r'class PrimeCareCard extends StatelessWidget \{.*?\}', prime_card_fix, content, flags=re.DOTALL)

    with open(view_path, 'w', encoding='utf-8') as f:
        f.write(content)

recovery_v11()
print("V11 Widget Recovery Complete")
