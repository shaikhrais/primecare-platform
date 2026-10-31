import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/workspace.dart';

class StatefulSlot extends StatefulWidget {
  final String id;
  const StatefulSlot(this.id, {super.key});
  @override State<StatefulSlot> createState() => StatefulSlotState();
}
class StatefulSlotState extends State<StatefulSlot> {
  @override Widget build(BuildContext context) => TextField(key: ValueKey('${widget.id}-field'));
}
WorkspaceController createController([String actor = 'a']) => WorkspaceController(
  scope: WorkspaceScope(tenant: 'tenant', user: actor, role: 'staff'), panelIds: ['note']);
Future<void> mount(WidgetTester tester, WorkspaceController c, {double width = 1500, double height = 960}) async {
  tester.view.physicalSize = Size(width, height);tester.view.devicePixelRatio = 1;
  await tester.pumpWidget(MaterialApp(home: Scaffold(body: PrimeWorkspaceLayout(
    controller: c, navigation: const ColoredBox(color: Colors.blue, child: Text('Authorized navigation')),
    toolbar: const Text('Existing toolbar'), footer: const Text('Existing footer'),
    main: const StatefulSlot('main'), panels: const {'note': StatefulSlot('note')},
    handleLabels: const {'note': WorkspaceHandleLabels(move: 'Move panel', resize: 'Resize panel', instructions: 'Arrows move; Shift resizes; Control docks.')},
  ))));await tester.pump();
}
void main() {
  testWidgets('60 shell configurations retain live state and never overflow', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    final c = createController();addTearDown(c.dispose);await mount(tester, c);
    await tester.enterText(find.byKey(const ValueKey('main-field')), 'Unfinished main form');
    await tester.enterText(find.byKey(const ValueKey('note-field')), 'Unfinished panel form');
    final main = tester.state<StatefulSlotState>(find.byType(StatefulSlot).at(0));
    final panel = tester.state<StatefulSlotState>(find.byType(StatefulSlot).at(1));
    for (final nav in ['left', 'right', 'top', 'bottom', 'hidden']) {
      for (final container in ['fullwidth', 'boxed', 'content']) {
        for (final toolbar in ['top', 'bottom']) {
          for (final scroll in ['page', 'content']) {
            c.patch({'navigation': nav, 'container': container, 'toolbar': toolbar, 'scroll': scroll, 'maxWidth': 960});
            await tester.pump();expect(tester.takeException(), isNull);
            expect(find.text('Unfinished main form'), findsOneWidget);expect(find.text('Unfinished panel form'), findsOneWidget);
          }
        }
      }
    }
    expect(tester.state<StatefulSlotState>(find.byWidgetPredicate((w) => w is StatefulSlot && w.id == 'main')), same(main));
    expect(tester.state<StatefulSlotState>(find.byWidgetPredicate((w) => w is StatefulSlot && w.id == 'note')), same(panel));
    for (final dock in WorkspaceLayout.docks) {
      c.dock('note', dock);await tester.pump();expect(tester.takeException(), isNull);
      expect(find.byKey(const ValueKey('note-field'), skipOffstage: false), findsOneWidget);
    }
    c.dock('note', 'right');await tester.pump();expect(find.text('Unfinished panel form'), findsOneWidget);
    c.patch({'footer': 'hidden'});await tester.pump();expect(find.text('Existing footer'), findsNothing);
    c.patch({'footer': 'sticky', 'toolbarStyle': 'static'});await tester.pump();expect(tester.takeException(), isNull);
  });
  testWidgets('keyboard and pointer move resize dock and cancel as single history entries', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    final c = createController();addTearDown(c.dispose);await mount(tester, c);
    final move = find.byKey(const ValueKey('workspace-layout-move-note'));
    Focus.of(tester.element(move)).requestFocus();await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.arrowLeft);await tester.pump();expect(c.current.panels['note']!.dock, 'floating');
    final width = c.current.panels['note']!.width;
    await tester.sendKeyDownEvent(LogicalKeyboardKey.shiftLeft);await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);await tester.sendKeyUpEvent(LogicalKeyboardKey.shiftLeft);
    expect(c.current.panels['note']!.width, width + 16);
    await tester.sendKeyDownEvent(LogicalKeyboardKey.controlLeft);await tester.sendKeyEvent(LogicalKeyboardKey.arrowRight);await tester.sendKeyUpEvent(LogicalKeyboardKey.controlLeft);await tester.pump();expect(c.current.panels['note']!.dock, 'right');
    final before = c.exportJson();await tester.drag(move, const Offset(80, 24));await tester.pump();expect(c.current.panels['note']!.dock, 'floating');c.undo();await tester.pump();expect(c.exportJson(), before);
    final gesture = await tester.startGesture(tester.getCenter(move));await gesture.moveBy(const Offset(60, 20));await tester.pump();expect(c.inGesture, true);
    await tester.sendKeyEvent(LogicalKeyboardKey.escape);await gesture.cancel();await tester.pump();expect(c.exportJson(), before);
    final resize = find.byKey(const ValueKey('workspace-layout-resize-note'));
    await tester.drag(resize, const Offset(32, 32));await tester.pump();expect(c.current.panels['note']!.height, 392);
    expect(tester.takeException(), isNull);
  });
  testWidgets('phone reflow safe areas and account replacement do not resurrect old state', (tester) async {
    addTearDown(tester.view.resetPhysicalSize);addTearDown(tester.view.resetDevicePixelRatio);
    final a = createController();addTearDown(a.dispose);await mount(tester, a);
    await tester.enterText(find.byKey(const ValueKey('note-field')), 'Actor A private draft');
    a.change(a.current.panel('note', {'dock': 'floating', 'x': 10000, 'y': 10000}));await tester.pump();
    final rect = tester.getRect(find.byKey(const ValueKey('note-field')));expect(rect.right, lessThanOrEqualTo(1500));expect(rect.bottom, lessThanOrEqualTo(960));
    tester.view.padding = const FakeViewPadding(top: 24, bottom: 16);addTearDown(tester.view.resetPadding);
    await mount(tester, a, width: 390, height: 844);expect(tester.takeException(), isNull);
    expect(a.current.panels['note']!.dock, 'floating');
    expect(find.byType(Positioned), findsOneWidget); // Only the shell; floats stack on phones.
    final handle = find.byKey(const ValueKey('workspace-layout-move-note'));
    expect(Focus.of(tester.element(handle)).canRequestFocus, false);
    final b = createController('b');addTearDown(b.dispose);await mount(tester, b, width: 390, height: 844);
    expect(find.text('Actor A private draft', skipOffstage: false), findsNothing);expect(tester.takeException(), isNull);
  });
  testWidgets('a removed or unregistered supplied panel fails closed', (tester) async {
    final c = createController();addTearDown(c.dispose);
    await tester.pumpWidget(MaterialApp(home: PrimeWorkspaceLayout(controller: c,
      navigation: const SizedBox(), toolbar: const SizedBox(), main: const SizedBox(), panels: const {})));
    expect(tester.takeException(), isStateError);
  });
}
