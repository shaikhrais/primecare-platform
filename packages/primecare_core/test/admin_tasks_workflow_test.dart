import 'package:test/test.dart';
import 'package:primecare_core/primecare_core.dart';

class _TasksWorkflow extends BaseAdminWorkflow {
  _TasksWorkflow(super.request);
}
void main() {
  Map<String,dynamic> task() => {'id':'create','titleKey':'task.create.title','descriptionKey':'task.create.description','operation':'accounts.create'};
  Map<String,dynamic> response(List<dynamic> tasks) => {'organization':{'name':'Organization'},'users':<Map<String,dynamic>>[],'assignableRoles':['client'],'total':0,'active':0,'offset':0,'limit':25,'tasks':tasks};
  test('Server task metadata becomes shared immutable task models', () async {
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => response([task()]);
    final workflow=_TasksWorkflow(request);await workflow.load();expect(workflow.error,isNull);expect(workflow.tasks.single,isA<BaseRoleTask>());
    expect(()=>workflow.tasks.clear(),throwsUnsupportedError);
  });
  test('Duplicate and malformed task metadata keep the previous valid workspace', () async {
    List<dynamic> tasks=[task()];
    Future<Map<String,dynamic>> request(String method,String path,{Map<String,dynamic>? body}) async => response(tasks);
    final workflow=_TasksWorkflow(request);await workflow.load();
    for(final invalid in <List<dynamic>>[[task(),task()],[{...task(),'operation':'tenant.delete'}],['invalid']]) {
      tasks=invalid;await workflow.load();expect(workflow.errorCode,'error.invalidResponse');expect(workflow.tasks.single.id,'create');expect(workflow.busy,false);
    }
  });
}
