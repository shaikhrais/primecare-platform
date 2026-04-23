import { PrismaClient } from '../generated/client';

const prisma = new PrismaClient();

export async function seedAgentBlueprints() {
  console.log('🤖 Seeding AI Agent Blueprints...');

  const blueprints = [
    {
      screenRoute: '/psw/live-visit',
      description: 'The primary operational surface for Personal Support Workers during a live clinical visit.',
      reasoning: 'Optimized for high-stress environments. Prioritizes the Aura HUD for real-time vitals and the Clinical Summary for immediate context.',
      requiredComponents: [
        { label: 'Aura HUD', intent: 'clinical_vitals', importance: 'critical' },
        { label: 'Clinical Summary', intent: 'patient_context', importance: 'high' },
        { label: 'Care Plan Checklist', intent: 'visit_execution', importance: 'critical' },
        { label: 'Incident Quick-Report', intent: 'risk_mitigation', importance: 'high' },
      ]
    },
    {
      screenRoute: '/office/billing/dashboard',
      description: 'Central command for revenue cycle management and billing administration.',
      reasoning: 'Focused on financial throughput. Highlights discrepancies and pending invoices to minimize aging accounts.',
      requiredComponents: [
        { label: 'Aging Accounts Grid', intent: 'financial_health', importance: 'critical' },
        { label: 'Pending Claims Queue', intent: 'revenue_ops', importance: 'high' },
        { label: 'Remittance Breakdown', intent: 'cash_flow', importance: 'medium' },
      ]
    },
    {
      screenRoute: '/office/compliance/audits',
      description: 'Regulatory oversight and platform integrity dashboard.',
      reasoning: 'Designed for auditability. Surface-level indicators of platform health coupled with deep-dive anomaly reports.',
      requiredComponents: [
        { label: 'Registry Integrity Score', intent: 'governance_audit', importance: 'critical' },
        { label: 'Anomaly Heatmap', intent: 'risk_assessment', importance: 'high' },
        { label: 'Execution Gate Logs', intent: 'telemetry_oversight', importance: 'medium' },
      ]
    },
    {
      screenRoute: '/ceo/strategic-overview',
      description: 'Executive vision and high-level platform performance.',
      reasoning: 'Aggregates multi-tenant data into actionable KPIs. Minimalistic design to focus on trajectory rather than granular transactions.',
      requiredComponents: [
        { label: 'Growth Trajectory KPI', intent: 'strategic_vision', importance: 'critical' },
        { label: 'Regional Expansion Map', intent: 'market_intelligence', importance: 'high' },
        { label: 'System Maturity Index', intent: 'platform_governance', importance: 'high' },
      ]
    }
  ];

  for (const bp of blueprints) {
    const blueprint = await prisma.agentScreenBlueprint.upsert({
      where: { screenRoute: bp.screenRoute },
      update: {
        description: bp.description,
        reasoning: bp.reasoning,
      },
      create: {
        screenRoute: bp.screenRoute,
        description: bp.description,
        reasoning: bp.reasoning,
      },
    });

    for (const comp of bp.requiredComponents) {
      const existing = await prisma.blueprintComponent.findFirst({
        where: { blueprintId: blueprint.id, label: comp.label }
      });

      if (!existing) {
        await prisma.blueprintComponent.create({
          data: {
            blueprintId: blueprint.id,
            label: comp.label,
            intent: comp.intent,
            importance: comp.importance,
          }
        });
      } else {
        await prisma.blueprintComponent.update({
          where: { id: existing.id },
          data: {
            intent: comp.intent,
            importance: comp.importance,
          }
        });
      }
    }
  }

  console.log('✅ AI Agent Blueprints seeded.');
}
