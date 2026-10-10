import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_core/primecare_core.dart';
import 'package:primecare_ui/primecare_ui.dart';

void main() {
  testWidgets('Admin creates and updates a user through the shared workflow', (tester) async {
    tester.view.physicalSize = const Size(1200,1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final rows = <Map<String,dynamic>>[];
    final operations = <String>[];
    Future<Map<String,dynamic>> request(String method, String path, {Map<String,dynamic>? body}) async {
      operations.add('$method $path');
      if (method == 'POST') {
        rows.add({'id':'user-1','email':body!['email'],'role':body['role'],'status':'active'});
        return {'user':rows.last};
      }
      if (method == 'PUT') { rows[0] = {'id':'user-1',...body!}; return {'user':rows[0]}; }
      return {'organization':{'name':'QA organization'},'users':rows,'assignableRoles':['client','rmt'],'total':rows.length,'active':rows.where((r) => r['status']=='active').length,'offset':0,'limit':25};
    }
    await tester.pumpWidget(MaterialApp(home: AdminScreen(request: request)));
    await tester.pumpAndSettle();
    expect(find.text('QA organization'),findsOneWidget);
    await tester.tap(find.text('Create user'));await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField,'User email'),'new@example.com');
    await tester.enterText(find.widgetWithText(TextFormField,'Initial password'),'initial-password-123');
    await tester.tap(find.text('Save user'));await tester.pumpAndSettle(const Duration(milliseconds: 400));
    expect(find.text('new@example.com'),findsOneWidget);
    expect(operations,contains('POST /admin/workspace/users'));
    await tester.tap(find.byTooltip('Edit new@example.com'));await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextFormField,'User email'),'updated@example.com');
    await tester.tap(find.text('Save user'));await tester.pumpAndSettle(const Duration(milliseconds: 400));
    expect(find.text('updated@example.com'),findsOneWidget);
    expect(operations,contains('PUT /admin/workspace/users/user-1'));
  });
  testWidgets('API denial is visible and does not enable user creation', (tester) async {
    Future<Map<String,dynamic>> request(String method, String path, {Map<String,dynamic>? body}) async => throw const AuthFailure('Forbidden',status:403);
    await tester.pumpWidget(MaterialApp(home: AdminScreen(request: request)));
    await tester.pumpAndSettle();
    expect(find.text('Forbidden'),findsOneWidget);
    expect(tester.widget<FilledButton>(find.widgetWithText(FilledButton,'Create user')).onPressed,isNull);
  });
}
