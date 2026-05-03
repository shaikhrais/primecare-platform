import 'dart:io';
import 'package:primecare_ui/primecare_ui.dart';
import '../../../governance/services/ast_patch_engine.dart';
import '../models/proposal_intake.dart';
import 'stitch_bridge_service.dart';

/// [FlowRunnerService] - Executes the deployment phase of a proposal.
/// Injects metadata into the platform registries and triggers UI generation.
class FlowRunnerService {
  final Ref ref;
  final ASTPatchEngine _patchEngine;

  FlowRunnerService(this.ref) : _patchEngine = ASTPatchEngine('c:/Users/Admin2/Documents/GitHub/primecare-platform');

  /// Deploys a proposal to the platform.
  Future<bool> deployProposal(ProposalIntake proposal) async {
    final telemetry = ref.read(executionGateProvider);
    
    try {
      telemetry.track(ExecutionGateCategory.governance, 'Starting deployment for ${proposal.screenId}');
      
      // 1. Determine the target registry
      final registryDetails = _getRegistryDetails(proposal.department);
      
      // 2. Inject into the registry
      final success = await _patchEngine.injectScreenConstant(
        registryPath: registryDetails['path']!,
        className: registryDetails['className']!,
        screenId: proposal.screenId,
        metadata: {
          'id': proposal.screenId,
          'featureName': proposal.title,
          'routePath': proposal.routePath,
          'title': proposal.title,
          'description': proposal.description,
          'office': proposal.department,
          'role': proposal.role,
          'lifecycleStatus': 'LifecycleStatus.inDevelopment',
          'icon': 'Icons.auto_fix_high',
        },
      );

      if (!success) {
        telemetry.failGate(ExecutionGateCategory.governance, 'AST Injection failed for ${proposal.screenId}');
        return false;
      }

      // 3. Verify Deployment (Wait a moment for FS sync)
      final registryPath = registryDetails['path']!;
      final verificationSuccess = await _verifyDeployment(registryPath, proposal.screenId);
      if (!verificationSuccess) {
        telemetry.failGate(ExecutionGateCategory.governance, 'Post-injection verification failed for ${proposal.screenId}');
        return false;
      }

      // 4. Trigger Stitch UI Engine
      telemetry.track(ExecutionGateCategory.auraEngine, 'Triggering Stitch UI Generation for ${proposal.screenId}');
      final stitch = ref.read(stitchBridgeServiceProvider);
      await stitch.generateScreen(proposal);

      telemetry.passGate(ExecutionGateCategory.governance, 'Deployment successful for ${proposal.screenId}');
      return true;
    } catch (e) {
      telemetry.failGate(ExecutionGateCategory.governance, 'Deployment failed for ${proposal.screenId}', error: e);
      debugPrint('[FlowRunner Error]: $e');
      return false;
    }
  }

  Future<bool> _verifyDeployment(String relativePath, String screenId) async {
    try {
      final absolutePath = 'c:/Users/Admin2/Documents/GitHub/primecare-platform/$relativePath';
      final file = File(absolutePath);
      if (!await file.exists()) return false;
      final content = await file.readAsString();
      return content.contains(screenId);
    } catch (e) {
      return false;
    }
  }

  Map<String, String> _getRegistryDetails(String? department) {
    switch (department) {
      case 'Clinical':
        return {
          'path': 'apps/primecare_governance/lib/core/governance/registries/clinical_registry.dart',
          'className': 'ClinicalRegistry',
        };
      case 'Finance':
      case 'Corporate':
        return {
          'path': 'apps/primecare_governance/lib/core/governance/registries/corporate_registry.dart',
          'className': 'CorporateRegistry',
        };
      default:
        return {
          'path': 'apps/primecare_governance/lib/core/governance/registries/operational_registry.dart',
          'className': 'OperationalRegistry',
        };
    }
  }
}

final flowRunnerServiceProvider = Provider((ref) => FlowRunnerService(ref));
