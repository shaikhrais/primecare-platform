import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final GFButtonType type;
  final GFButtonShape shape;
  final bool fullWidth;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.type = GFButtonType.solid,
    this.shape = GFButtonShape.standard,
    this.fullWidth = false,
  });

  @override
  Widget build(BuildContext context) {
    return GFButton(
      onPressed: onPressed,
      text: text,
      type: type,
      shape: shape,
      blockButton: fullWidth,
    );
  }
}

class AppInput extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool obscureText;

  const AppInput({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.labelLarge),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hint,
            border: const OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class AppCard extends StatelessWidget {
  final String title;
  final Widget child;
  final List<Widget>? actions;

  const AppCard({
    super.key,
    required this.title,
    required this.child,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      title: GFListTile(
        title: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
      content: child,
      buttonBar: actions != null ? GFButtonBar(children: actions!) : null,
    );
  }
}

class AppTable extends StatelessWidget {
  final List<String> columns;
  final List<List<dynamic>> rows;

  const AppTable({super.key, required this.columns, required this.rows});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: columns.map((c) => DataColumn(label: Text(c))).toList(),
        rows: rows
            .map(
              (r) => DataRow(
                cells: r
                    .map((cell) => DataCell(Text(cell.toString())))
                    .toList(),
              ),
            )
            .toList(),
      ),
    );
  }
}

class AppLoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool isLoading;

  const AppLoadingOverlay({
    super.key,
    required this.child,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: Colors.black.withValues(alpha: 0.3),
            child: const Center(child: CircularProgressIndicator()),
          ),
      ],
    );
  }
}
