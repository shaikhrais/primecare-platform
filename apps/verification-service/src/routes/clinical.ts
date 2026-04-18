import { ClinicalService, VitalsInput, IntakeInput } from '@primecare/domain/src/services/ClinicalService';

export function registerClinicalRoutes(app: any) {
    /**
     * POST /v1/clinical/vitals-capture
     * Records patient vital signs.
     */
    app.post('/v1/clinical/vitals-capture', async (c: any) => {
        try {
            const tenantId = c.req.header('x-tenant-id');
            const jwtPayload = c.get('jwtPayload');

            if (!tenantId) {
                return c.json({ success: false, error: 'Missing x-tenant-id header' }, 400);
            }

            const body = await c.req.json();
            
            const input: VitalsInput = {
                tenantId: tenantId as string,
                patientId: body.patientId,
                systolic: body.systolic ? parseFloat(body.systolic) : undefined,
                diastolic: body.diastolic ? parseFloat(body.diastolic) : undefined,
                heartRate: body.heartRate ? parseFloat(body.heartRate) : undefined,
                temperature: body.temperature ? parseFloat(body.temperature) : undefined,
                oxygenSaturation: body.oxygenSaturation ? parseFloat(body.oxygenSaturation) : undefined,
                weight: body.weight ? parseFloat(body.weight) : undefined,
                actorUserId: jwtPayload?.sub || 'SYSTEM'
            };

            if (!input.patientId) {
                return c.json({ success: false, error: 'Missing patientId' }, 400);
            }

            const result = await ClinicalService.captureVitals(input);
            return c.json({ success: true, ...result }, 201);
        } catch (error: any) {
            console.error('Vitals Capture Error:', error);
            return c.json({ success: false, error: error.message }, 500);
        }
    });

    /**
     * POST /v1/clinical/patient-intake
     * Processes new patient registrations.
     */
    app.post('/v1/clinical/patient-intake', async (c: any) => {
        try {
            const tenantId = c.req.header('x-tenant-id');
            const jwtPayload = c.get('jwtPayload');

            if (!tenantId) {
                return c.json({ success: false, error: 'Missing x-tenant-id header' }, 400);
            }

            const body = await c.req.json();
            
            const input: IntakeInput = {
                tenantId: tenantId as string,
                firstName: body.firstName,
                lastName: body.lastName,
                dateOfBirth: new Date(body.dateOfBirth),
                gender: body.gender,
                email: body.email,
                phone: body.phone,
                address: body.address,
                insuranceProvider: body.insuranceProvider,
                insuranceNumber: body.insuranceNumber,
                emergencyContactName: body.emergencyContactName,
                emergencyContactPhone: body.emergencyContactPhone,
                medicalHistory: body.medicalHistory,
                actorUserId: jwtPayload?.sub || 'SYSTEM'
            };

            if (!input.firstName || !input.lastName || isNaN(input.dateOfBirth.getTime())) {
                return c.json({ success: false, error: 'Missing or invalid required fields (firstName, lastName, dateOfBirth)' }, 400);
            }

            const result = await ClinicalService.processPatientIntake(input);
            return c.json({ success: true, ...result }, 201);
        } catch (error: any) {
            console.error('Patient Intake Error:', error);
            return c.json({ success: false, error: error.message }, 500);
        }
    });

    /**
     * GET /v1/clinical/ai-analytics/q3-extrapolations
     * Port of the original analytical route for AI insights.
     */
    app.get('/v1/clinical/ai-analytics/q3-extrapolations', async (c: any) => {
        return c.json({
            success: true,
            insights: [
                { id: '1', title: 'Adherence Trend', value: '+12%', status: 'good' },
                { id: '2', title: 'Risk Score Avg', value: '14.2', status: 'neutral' },
                { id: '3', title: 'Pending Intakes', value: '45', status: 'warning' }
            ]
        });
    });
}
