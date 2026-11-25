import 'package:flutter_test/flutter_test.dart';
import 'package:primecare_execution_gate/primecare_execution_gate.dart';
import 'package:primecare_intelligence/primecare_intelligence.dart';
import 'package:primecare_models/primecare_models.dart';
void main(){test('existing rules accept empty metrics',() async {final service=IntelligenceService(ExecutionGateService());final metrics=DashboardMetrics(kpis:{},insights:[],charts:[],recentActivity:[]);expect((await service.generateInsights('fixture',metrics)).getOrThrow(),isA<List<IntelligenceInsight>>());});}
