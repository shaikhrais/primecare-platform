import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '../bindings';

const sduiModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Generates the Home Dashboard layout dynamically based on Authorization
sduiModule.openapi(
  createRoute({
    method: 'get',
    path: '/dashboard',
    tags: ['SDUI'],
    summary: 'Dynamic Server-Driven UI Dashboard Schema',
    responses: { 200: { description: 'Returns the PrimeCare UI schema payload' } },
  }),
  async (c) => {
    // In production, user = c.get('user')
    // Simulating RN Dashboard schema dynamically rendered to the Flutter SDK
    const rnDashboardSchema = {
      type: 'Padding',
      padding: 24,
      child: {
        type: 'Column',
        crossAxisAlignment: 'start',
        children: [
          {
            type: 'Row',
            mainAxisAlignment: 'spaceBetween',
            children: [
              { type: 'Text', text: 'CLINICAL HUB', color: '#94A3B8', bold: true, fontSize: 12 },
              { type: 'PrimeCareBadge', text: '4 Active Incidents', color: '#EF4444' }
            ]
          },
          { type: 'SizedBox', height: 8 },
          { type: 'Text', text: 'RN Dashboard', color: '#0F172A', bold: true, fontSize: 32 },
          { type: 'SizedBox', height: 24 },
          {
            type: 'PrimeCareCard',
            backgroundColor: '#FFFFFF',
            padding: 24,
            child: {
              type: 'Column',
              crossAxisAlignment: 'start',
              children: [
                { type: 'Text', text: 'Recent Incidents', bold: true, fontSize: 18, color: '#0F172A' },
                { type: 'SizedBox', height: 16 },
                {
                  type: 'PrimeCareButton',
                  text: 'FILE NEW REPORT',
                  isPrimary: true,
                  icon: 'warning',
                  action: 'navigate:/rn/incident/new',
                }
              ]
            }
          }
        ]
      }
    };

    return c.json(rnDashboardSchema);
  }
);

export default sduiModule;
