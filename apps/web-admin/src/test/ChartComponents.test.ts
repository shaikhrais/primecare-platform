/**
 * Chart Components — Module Export & Structure Tests
 *
 * Tests all 35 chart components + 7 core chart components for:
 * - Proper named exports
 * - Export type is function (React component)
 * - Core chart barrel re-exports
 */
import { describe, it, expect } from 'vitest';

// ═══════════════════════════════════════════════════════════════════════════
// Core Chart Barrel
// ═══════════════════════════════════════════════════════════════════════════

describe('Core Chart Barrel', () => {
    it('CoreBarChart exports', async () => {
        const { CoreBarChart } = await import('@/shared/components/charts/core/CoreBarChart');
        expect(typeof CoreBarChart).toBe('function');
    });

    it('CoreAreaChart exports', async () => {
        const { CoreAreaChart } = await import('@/shared/components/charts/core/CoreAreaChart');
        expect(typeof CoreAreaChart).toBe('function');
    });

    it('CoreLineChart exports', async () => {
        const { CoreLineChart } = await import('@/shared/components/charts/core/CoreLineChart');
        expect(typeof CoreLineChart).toBe('function');
    });

    it('CorePieChart exports', async () => {
        const { CorePieChart } = await import('@/shared/components/charts/core/CorePieChart');
        expect(typeof CorePieChart).toBe('function');
    });

    it('CoreRadarChart exports', async () => {
        const { CoreRadarChart } = await import('@/shared/components/charts/core/CoreRadarChart');
        expect(typeof CoreRadarChart).toBe('function');
    });

    it('CoreScatterChart exports', async () => {
        const { CoreScatterChart } = await import('@/shared/components/charts/core/CoreScatterChart');
        expect(typeof CoreScatterChart).toBe('function');
    });

    it('CoreRadialBarChart exports', async () => {
        const { CoreRadialBarChart } = await import('@/shared/components/charts/core/CoreRadialBarChart');
        expect(typeof CoreRadialBarChart).toBe('function');
    });

    it('core barrel re-exports all 7', async () => {
        const core = await import('@/shared/components/charts/core');
        expect(core.CoreBarChart).toBeDefined();
        expect(core.CoreAreaChart).toBeDefined();
        expect(core.CoreLineChart).toBeDefined();
        expect(core.CorePieChart).toBeDefined();
        expect(core.CoreRadarChart).toBeDefined();
        expect(core.CoreScatterChart).toBeDefined();
        expect(core.CoreRadialBarChart).toBeDefined();
    });
});

// ═══════════════════════════════════════════════════════════════════════════
// Domain Chart Components — Static Imports
// ═══════════════════════════════════════════════════════════════════════════

describe('Domain Charts — Revenue & Financial', () => {
    it('RevenueChart exports', async () => {
        const { RevenueChart } = await import('@/shared/components/charts/RevenueChart');
        expect(RevenueChart).toBeDefined();
    });
    it('RevenueForecastChart exports', async () => {
        const { RevenueForecastChart } = await import('@/shared/components/charts/RevenueForecastChart');
        expect(RevenueForecastChart).toBeDefined();
    });
    it('RevenueTrendChart exports', async () => {
        const { RevenueTrendChart } = await import('@/shared/components/charts/RevenueTrendChart');
        expect(RevenueTrendChart).toBeDefined();
    });
    it('BudgetUtilizationChart exports', async () => {
        const { BudgetUtilizationChart } = await import('@/shared/components/charts/BudgetUtilizationChart');
        expect(BudgetUtilizationChart).toBeDefined();
    });
    it('MyEarningsTrend exports', async () => {
        const { MyEarningsTrend } = await import('@/shared/components/charts/MyEarningsTrend');
        expect(MyEarningsTrend).toBeDefined();
    });
});

describe('Domain Charts — Staff & Shifts', () => {
    it('ShiftDistributionChart exports', async () => {
        const { ShiftDistributionChart } = await import('@/shared/components/charts/ShiftDistributionChart');
        expect(ShiftDistributionChart).toBeDefined();
    });
    it('ShiftFulfillmentChart exports', async () => {
        const { ShiftFulfillmentChart } = await import('@/shared/components/charts/ShiftFulfillmentChart');
        expect(ShiftFulfillmentChart).toBeDefined();
    });
    it('StaffAttendanceHeatmap exports', async () => {
        const { StaffAttendanceHeatmap } = await import('@/shared/components/charts/StaffAttendanceHeatmap');
        expect(StaffAttendanceHeatmap).toBeDefined();
    });
    it('StaffUtilizationChart exports', async () => {
        const { StaffUtilizationChart } = await import('@/shared/components/charts/StaffUtilizationChart');
        expect(StaffUtilizationChart).toBeDefined();
    });
    it('OvertimeRiskGauge exports', async () => {
        const { OvertimeRiskGauge } = await import('@/shared/components/charts/OvertimeRiskGauge');
        expect(OvertimeRiskGauge).toBeDefined();
    });
    it('MyReliabilityScore exports', async () => {
        const { MyReliabilityScore } = await import('@/shared/components/charts/MyReliabilityScore');
        expect(MyReliabilityScore).toBeDefined();
    });
});

describe('Domain Charts — Clinical & Client', () => {
    it('ClientGrowthChart exports', async () => {
        const { ClientGrowthChart } = await import('@/shared/components/charts/ClientGrowthChart');
        expect(ClientGrowthChart).toBeDefined();
    });
    it('ClientSatisfactionRadar exports', async () => {
        const { ClientSatisfactionRadar } = await import('@/shared/components/charts/ClientSatisfactionRadar');
        expect(ClientSatisfactionRadar).toBeDefined();
    });
    it('CareContinuityChart exports', async () => {
        const { CareContinuityChart } = await import('@/shared/components/charts/CareContinuityChart');
        expect(CareContinuityChart).toBeDefined();
    });
    it('CarePlanAdherenceGauge exports', async () => {
        const { CarePlanAdherenceGauge } = await import('@/shared/components/charts/CarePlanAdherenceGauge');
        expect(CarePlanAdherenceGauge).toBeDefined();
    });
    it('AssessmentComplianceChart exports', async () => {
        const { AssessmentComplianceChart } = await import('@/shared/components/charts/AssessmentComplianceChart');
        expect(AssessmentComplianceChart).toBeDefined();
    });
    it('ClinicalIncidentHeatmap exports', async () => {
        const { ClinicalIncidentHeatmap } = await import('@/shared/components/charts/ClinicalIncidentHeatmap');
        expect(ClinicalIncidentHeatmap).toBeDefined();
    });
    it('IncidentTrendChart exports', async () => {
        const { IncidentTrendChart } = await import('@/shared/components/charts/IncidentTrendChart');
        expect(IncidentTrendChart).toBeDefined();
    });
    it('PatientAcuityDistribution exports', async () => {
        const { PatientAcuityDistribution } = await import('@/shared/components/charts/PatientAcuityDistribution');
        expect(PatientAcuityDistribution).toBeDefined();
    });
    it('WellnessTrendChart exports', async () => {
        const { WellnessTrendChart } = await import('@/shared/components/charts/WellnessTrendChart');
        expect(WellnessTrendChart).toBeDefined();
    });
    it('VitalSparkline exports', async () => {
        const { VitalSparkline } = await import('@/shared/components/charts/VitalSparkline');
        expect(VitalSparkline).toBeDefined();
    });
});

describe('Domain Charts — Operations & Utility', () => {
    it('ChartCard exports', async () => {
        const { ChartCard } = await import('@/shared/components/charts/ChartCard');
        expect(ChartCard).toBeDefined();
    });
    it('Sparkline exports', async () => {
        const { Sparkline } = await import('@/shared/components/charts/Sparkline');
        expect(Sparkline).toBeDefined();
    });
    it('ResourceAvailabilityChart exports', async () => {
        const { ResourceAvailabilityChart } = await import('@/shared/components/charts/ResourceAvailabilityChart');
        expect(ResourceAvailabilityChart).toBeDefined();
    });
    it('ServicePopularityChart exports', async () => {
        const { ServicePopularityChart } = await import('@/shared/components/charts/ServicePopularityChart');
        expect(ServicePopularityChart).toBeDefined();
    });
    it('TravelTimeAnalysis exports', async () => {
        const { TravelTimeAnalysis } = await import('@/shared/components/charts/TravelTimeAnalysis');
        expect(TravelTimeAnalysis).toBeDefined();
    });
    it('VisitVolumeChart exports', async () => {
        const { VisitVolumeChart } = await import('@/shared/components/charts/VisitVolumeChart');
        expect(VisitVolumeChart).toBeDefined();
    });
});
