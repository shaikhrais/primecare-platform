import { OpenAPIHono, createRoute, z } from '@hono/zod-openapi';
import { Bindings, Variables } from '@primecare/shared-types';

const sduiModule = new OpenAPIHono<{ Bindings: Bindings; Variables: Variables }>();

// Generates the Home Home layout dynamically based on Authorization
sduiModule.openapi(
  createRoute({
    method: 'get',
    path: '/home',
    tags: ['SDUI'],
    summary: 'Dynamic Server-Driven UI Home Schema',
    responses: { 200: { description: 'Returns the PrimeCare UI schema payload' } },
  }),
  async (c) => {
    // In production, user = c.get('user')
    // Simulating RN Home schema dynamically rendered to the Flutter SDK
    const rnHomeSchema = {
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
          { type: 'Text', text: 'RN Home', color: '#0F172A', bold: true, fontSize: 32 },
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

    return c.json(rnHomeSchema);
  }
);

// Generates an interactive form dynamically without frontend code updates
sduiModule.openapi(
  createRoute({
    method: 'get',
    path: '/forms/{formId}',
    tags: ['SDUI'],
    summary: 'Dynamic Server-Driven Form Schema',
    request: { params: z.object({ formId: z.string() }) },
    responses: { 200: { description: 'Returns an actionable form fields array' } },
  }),
  async (c) => {
    const { formId } = c.req.valid('param');

    // In production, we pull the form schema from Prisma. Mocking the Master Engine here:
    const formSchema = {
      formId: formId,
      title: formId === 'onboarding_101' ? 'Clinical Registration Form' : 'Dynamic Incident Report',
      submitEndpoint: '/v1/system/dynamic-submit',
      fields: [
        { key: 'layout_header_1', type: 'header', label: 'Personal Information' },
        { key: 'firstName', type: 'text', label: 'Legal First Name', required: true },
        { key: 'lastName', type: 'text', label: 'Legal Last Name', required: true },
        { key: 'phoneNumber', type: 'phone', label: 'Contact Number', required: true },
        { key: 'layout_header_2', type: 'header', label: 'Operational Preferences' },
        { key: 'hasVehicle', type: 'boolean', label: 'Do you own a physical dispatch vehicle?' },
        { 
          key: 'preferredRegion', 
          type: 'dropdown', 
          label: 'Primary Dispatch Territory', 
          options: ['North York', 'Etobicoke', 'Downtown', 'Mississauga'] 
        }
      ]
    };

    return c.json(formSchema);
  }
);

export default sduiModule;
