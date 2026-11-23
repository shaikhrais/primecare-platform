import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_core/workspace.dart';
class SidebarMemory implements WorkspacePreferences {
 String? source;
 @override Future<String?> read(String key)async=>source;
 @override Future<void> write(String key,String value)async{source=value;}
}
void main(){
 WorkspaceScope scope()=>WorkspaceScope(tenant:'fixture',user:'fixture',role:'fixture');
 test('new host width is 280 while generic v1 defaults stay compatible',(){
  final legacy=WorkspaceController(scope:scope(),panelIds:[]);addTearDown(legacy.dispose);
  final host=WorkspaceController(scope:scope(),panelIds:[],defaultNavigationWidth:280);addTearDown(host.dispose);
  expect(legacy.current.navigationWidth,248);expect(host.current.navigationWidth,280);
  expect(host.current.toJson()['version'],1);
 });
 for(final width in [248,64,333])test('saved $width is preserved over new host default',()async{
  final prefs=SidebarMemory()..source=WorkspaceLayout.defaults([]).patch({'navigationWidth':width}).exportJson();
  final c=WorkspaceController(scope:scope(),panelIds:[],defaultNavigationWidth:280,preferences:prefs);addTearDown(c.dispose);
  expect(await c.load(),true);expect(c.current.navigationWidth,width);
  await c.save();expect(WorkspaceLayout.parse(prefs.source!,[]).navigationWidth,width);
  c.reset();expect(c.current.navigationWidth,280);
 });
 test('legacy position and collapsed mode survive the host default',(){
  for(final style in ['verticalRight','horizontal','collapsed']){
   final c=WorkspaceController(scope:scope(),panelIds:[],defaultNavigationWidth:280,legacyLayoutStyle:style);addTearDown(c.dispose);
   expect(c.current.navigation,style=='verticalRight'?'right':style=='horizontal'?'top':'left');
   expect(c.current.navigationWidth,style=='collapsed'?64:280);
  }
 });
 test('invalid host width is rejected without widening the v1 contract',(){
  expect(()=>WorkspaceController(scope:scope(),panelIds:[],defaultNavigationWidth:900),throwsFormatException);
 });
 test('fold and unfold preserve the current customized width in this session',(){
  final c=WorkspaceController(scope:scope(),panelIds:[],defaultNavigationWidth:280);addTearDown(c.dispose);
  c.patch({'navigationWidth':333});c.patch({'navigationWidth':64});expect(c.expandedNavigationWidth,333);
  c.patch({'navigationWidth':c.expandedNavigationWidth});expect(c.current.navigationWidth,333);
 });
 test('legacy collapsed workspace still unfolds to legacy default',(){
  final c=WorkspaceController(scope:scope(),panelIds:[],legacyLayoutStyle:'collapsed');addTearDown(c.dispose);
  expect(c.expandedNavigationWidth,248);
 });

}
