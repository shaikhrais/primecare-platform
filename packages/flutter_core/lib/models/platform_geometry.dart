/// A pure-Dart replacement for [ui.Size] to enable shared models 
/// between UI (Flutter) and Backend (Shelf/Workers) subsystems.
class PlatformSize {
  final double width;
  final double height;

  const PlatformSize(this.width, this.height);

  @override
  String toString() => 'PlatformSize(${width.toInt()}x${height.toInt()})';
}
