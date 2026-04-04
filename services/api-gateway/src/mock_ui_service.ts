import { Context } from 'hono';

/**
 * Dynamically intercepts and generates valid JSON structures for unhandled UI endpoints.
 * This prevents the frontend from throwing 'Failed to load' or Type errors.
 */
export async function handleMockUIEndpoint(c: Context) {
  const path = new URL(c.req.url).pathname;
  console.log(`[MockUIService] Intercepting missing endpoint: ${path}`);

  // E.g. '/v1/client/bd/deals' -> 'deals'
  const pathSegments = path.split('/').filter(p => p.length > 0);
  const resourceIdentifier = pathSegments[pathSegments.length - 1] ?? 'data';
  
  // Clean query params or dashes if necessary
  const safeIdentifier = resourceIdentifier.replace(/-+/g, '_');

  // If path ends with a numeric/UUID id (e.g. PUT /deals/123), it's likely an update 
  // Return success true instead of array.
  if (pathSegments.length > 0 && /^[0-9a-fA-F-]+$/.test(pathSegments[pathSegments.length - 1])) {
    return c.json({ success: true, mocked: true, message: 'Resource successfully updated (mocked).' });
  }

  // Common stub array generators for UI rendering components
  const mockPayload = generateMockDataArray(safeIdentifier);

  const responseObj: Record<string, any> = {
    _meta: { source: 'api-gateway:mock_ui_service', timestamp: Date.now() },
  };

  // The UI expects `response.body[key] as List<dynamic>`.
  responseObj[safeIdentifier] = mockPayload;

  return c.json(responseObj);
}

function generateMockDataArray(key: string): any[] {
  // If it's plural or known, return at least 3 dummy records.
  return [
    {
      id: 'mock-uuid-001',
      name: `Dummy ${key.toUpperCase()} Alpha`,
      title: 'Sample Record 1',
      status: 'Active',
      stage: 'Discovery', // For BD pipelines
      amount: 1500000,
      facilityTarget: 'General Hospital',
      dealName: 'Corp Expansion',
      repName: 'John Doe',
      date: new Date().toISOString(),
      value: 100
    },
    {
      id: 'mock-uuid-002',
      name: `Dummy ${key.toUpperCase()} Beta`,
      title: 'Sample Record 2',
      status: 'Pending',
      stage: 'Evaluation',
      amount: 500000,
      facilityTarget: 'Community Clinic',
      dealName: 'Local Branch setup',
      repName: 'Jane Smith',
      date: new Date(Date.now() - 86400000).toISOString(),
      value: 85
    },
    {
      id: 'mock-uuid-003',
      name: `Dummy ${key.toUpperCase()} Gamma`,
      title: 'Sample Record 3',
      status: 'Completed',
      stage: 'Closed Won',
      amount: 2500000,
      facilityTarget: 'Private Care Org',
      dealName: 'Enterprise Rollout',
      repName: 'John Doe',
      date: new Date(Date.now() - 86400000 * 2).toISOString(),
      value: 99
    }
  ];
}
