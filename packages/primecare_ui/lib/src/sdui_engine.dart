import 'components/primecare_card.dart';
import 'components/primecare_button.dart';
import 'package:flutter/material.dart';
import 'primecare_ui.dart';

typedef SduiActionCallback =
    void Function(String action, Map<String, dynamic>? payload);

class PrimeCareSduiEngine extends StatelessWidget {
  final Map<String, dynamic> schema;
  final SduiActionCallback? onAction;

  const PrimeCareSduiEngine({super.key, required this.schema, this.onAction});

  @override
  Widget build(BuildContext context) {
    return _renderNode(schema) ?? const SizedBox.shrink();
  }

  Widget? _renderNode(Map<String, dynamic>? node) {
    if (node == null || !node.containsKey('type')) return null;

    final type = node['type'] as String;

    switch (type) {
      case 'Column':
        return Column(
          crossAxisAlignment: _parseCrossAxisAlignment(
            node['crossAxisAlignment'],
          ),
          mainAxisAlignment: _parseMainAxisAlignment(node['mainAxisAlignment']),
          children: _parseChildren(node['children']),
        );
      case 'Row':
        return Row(
          crossAxisAlignment: _parseCrossAxisAlignment(
            node['crossAxisAlignment'],
          ),
          mainAxisAlignment: _parseMainAxisAlignment(node['mainAxisAlignment']),
          children: _parseChildren(node['children']),
        );
      case 'Text':
        return Text(node['text']?.toString() ?? '', overflow: TextOverflow.ellipsis, maxLines: 1, style: TextStyle(
            fontSize: _parseDouble(node['fontSize']),
            color: _parseColor(node['color']),
            fontWeight: node['bold'] == true
                ? FontWeight.bold
                : FontWeight.normal,
          ),
          textAlign: _parseTextAlign(node['textAlign']),
        );
      case 'PrimeCareCard':
        {
          final childWidget = _renderNode(node['child']);
          return PrimeCareCard(
            backgroundColor: _parseColor(node['backgroundColor']),
            padding:
                _parseEdgeInsets(node['padding']) ?? const EdgeInsets.all(24),
            margin: _parseEdgeInsets(node['margin']),
            onTap: () {
              if (onAction != null && node.containsKey('action')) {
                onAction!(node['action'], node['payload']);
              }
            },
            child: childWidget ?? const SizedBox.shrink(),
          );
        }
      case 'PrimeCareButton':
        return PrimeCareButton(
          text: node['text'] ?? '',
          isPrimary: node['isPrimary'] ?? true,
          icon: _parseIcon(node['icon']),
          onPressed: () {
            if (onAction != null && node.containsKey('action')) {
              onAction!(node['action'], node['payload']);
            }
          },
        );
      case 'PrimeCareBadge':
        return PrimeCareBadge(
          text: node['text'] ?? '',
          color: _parseColor(node['color']) ?? Theme.of(context).primaryColor,
        );
      case 'PrimeCareAvatar':
        return PrimeCareAvatar(radius: _parseDouble(node['radius']) ?? 24.0);
      case 'SizedBox':
        return SizedBox(
          width: _parseDouble(node['width']),
          height: _parseDouble(node['height']),
        );
      case 'Expanded':
        {
          final childWidget = _renderNode(node['child']);
          return childWidget != null ? Expanded(child: childWidget) : null;
        }
      case 'Padding':
        {
          final childWidget = _renderNode(node['child']);
          return childWidget != null
              ? Padding(
                  padding: _parseEdgeInsets(node['padding']) ?? EdgeInsets.zero,
                  child: childWidget,
                )
              : null;
        }
      case 'Spacer':
        return const Spacer();

      default:
        return Center(child: Text('Unsupported SDUI Node: \$type'));
    }
  }

  List<Widget> _parseChildren(dynamic childrenNode) {
    if (childrenNode is! List) return [];
    return childrenNode
        .map((c) => _renderNode(c as Map<String, dynamic>))
        .where((w) => w != null)
        .cast<Widget>()
        .toList();
  }

  double? _parseDouble(dynamic value) {
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  Color? _parseColor(dynamic value) {
    if (value is String && value.startsWith('#')) {
      final hexString = value.replaceAll('#', '');
      try {
        if (hexString.length == 6) {
          return Color(int.parse('FF\$hexString', radix: 16));
        } else if (hexString.length == 8) {
          return Color(int.parse(hexString, radix: 16));
        }
      } catch (_) {}
    }
    return null;
  }

  EdgeInsetsGeometry? _parseEdgeInsets(dynamic value) {
    if (value is num) return EdgeInsets.all(value.toDouble());
    if (value is List && value.length == 4) {
      return EdgeInsets.fromLTRB(
        _parseDouble(value[0]) ?? 0,
        _parseDouble(value[1]) ?? 0,
        _parseDouble(value[2]) ?? 0,
        _parseDouble(value[3]) ?? 0,
      );
    }
    return null;
  }

  CrossAxisAlignment _parseCrossAxisAlignment(dynamic value) {
    if (value == 'start') return CrossAxisAlignment.start;
    if (value == 'end') return CrossAxisAlignment.end;
    if (value == 'center') return CrossAxisAlignment.center;
    if (value == 'stretch') return CrossAxisAlignment.stretch;
    return CrossAxisAlignment.start;
  }

  MainAxisAlignment _parseMainAxisAlignment(dynamic value) {
    if (value == 'start') return MainAxisAlignment.start;
    if (value == 'end') return MainAxisAlignment.end;
    if (value == 'center') return MainAxisAlignment.center;
    if (value == 'spaceBetween') return MainAxisAlignment.spaceBetween;
    if (value == 'spaceAround') return MainAxisAlignment.spaceAround;
    return MainAxisAlignment.start;
  }

  TextAlign? _parseTextAlign(dynamic value) {
    if (value == 'center') return TextAlign.center;
    if (value == 'right') return TextAlign.right;
    if (value == 'justify') return TextAlign.justify;
    return TextAlign.left;
  }

  IconData? _parseIcon(dynamic value) {
    switch (value) {
      case 'phone':
        return Icons.phone;
      case 'download':
        return Icons.download_rounded;
      case 'send':
        return Icons.send_rounded;
      case 'check':
        return Icons.check_circle_rounded;
      case 'warning':
        return Icons.warning_rounded;
      case 'groups':
        return Icons.groups_rounded;
      case 'hub':
        return Icons.hub_rounded;
      case 'speed':
        return Icons.speed;
      case 'video':
        return Icons.video_camera_front;
      case 'bug':
        return Icons.bug_report;
    }
    return null;
  }
}
