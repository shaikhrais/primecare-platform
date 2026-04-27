import { PrismaClient } from '@primecare/database';

export class SystemController {
  static async getMissingPlans(c: any) {
    const prisma = c.get('prisma') as PrismaClient;
    if (!prisma) return c.json({ success: false, error: 'DB unavailable' }, 500);

    try {
      const missingScreens = await prisma.platformScreen.findMany({
        where: { status: { in: ['unimplemented', 'pending'] } },
        select: { id: true, name: true, route: true, status: true, role: { select: { name: true } } }
      });

      const missingFunctions = await prisma.screenFunctionality.findMany({
        where: { status: { in: ['unimplemented', 'pending'] } },
        select: { id: true, title: true, status: true, screen: { select: { name: true, role: { select: { name: true } } } } }
      });

      return c.json({
        success: true,
        missingScreensCount: missingScreens.length,
        missingFunctionsCount: missingFunctions.length,
        missingScreens,
        missingFunctions,
        timestamp: new Date().toISOString()
      });
    } catch (error: any) {
      return c.json({ success: false, error: error.message }, 500);
    }
  }

  static async crossValidate(c: any) {
    const prisma = c.get('prisma') as PrismaClient;
    if (!prisma) return c.json({ success: false, error: 'DB unavailable' }, 500);

    try {
      const events = await prisma.implementationEvent.findMany({
        where: { status: 'deployed' },
        orderBy: { createdAt: 'desc' }
      });
      
      let anomalies = 0;
      const totalModels = await prisma.platformScreen.count().catch(() => 0);
      
      if (totalModels === 0 && events.length > 0) anomalies++;

      return c.json({ 
        success: true, 
        message: 'Cross validation completed',
        eventsScanned: events.length,
        anomalyCount: anomalies,
        timestamp: new Date().toISOString() 
      });
    } catch (error: any) {
      return c.json({ success: false, error: error.message }, 500);
    }
  }

  static async getDatabaseReport(c: any) {
    const prisma = c.get('prisma') as PrismaClient;
    if (!prisma) return c.json({ success: false, error: 'DB unavailable' }, 500);

    try {
      const dbreport = await (prisma as any).$queryRawUnsafe(`
        SELECT 
          relname AS "tableName", 
          n_live_tup AS "rowCount" 
        FROM pg_stat_user_tables 
        ORDER BY n_live_tup DESC;
      `).catch(() => []);

      const normalizedReport = (dbreport as any[]).map(t => ({
        tableName: t.tableName,
        rowCount: typeof t.rowCount === 'bigint' ? Number(t.rowCount) : Number(t.rowCount || 0)
      }));

      const totalRows = normalizedReport.reduce((sum, t) => sum + t.rowCount, 0);

      return c.json({
        success: true,
        totalTables: normalizedReport.length,
        totalRowsAggregated: totalRows,
        report: normalizedReport,
        timestamp: new Date().toISOString()
      });
    } catch (error: any) {
      return c.json({ success: false, error: error.message }, 500);
    }
  }

  static async recordImplementation(c: any) {
    const body = await c.req.json();
    const prisma = c.get('prisma') as PrismaClient;
    
    if (prisma) {
      const event = await prisma.implementationEvent.create({
        data: {
          featureName: body.featureName || 'unknown_feature',
          version: body.version || '1.0.0',
          status: body.status || 'deployed',
          payload: body.payload || {}
        }
      });
      return c.json({ success: true, message: 'Implementation event recorded', data: event }, 201);
    }

    return c.json({ success: false, message: 'Database context not available' }, 500);
  }

  static async preFlightCheck(c: any) {
    const payload = await c.req.json();
    const isSafe = payload?.featureName !== undefined;
    
    return c.json({ 
      success: true, 
      verified: isSafe, 
      issues: isSafe ? [] : ['Missing required featureName for telemetry propagation.'] 
    });
  }

  static async getPurposeReport(c: any) {
    const prisma = c.get('prisma') as PrismaClient;
    if (!prisma) return c.json({ success: false, error: 'DB unavailable' }, 500);

    try {
      const [structuralLayers, screens, domains] = await Promise.all([
        prisma.architecturalLayer.findMany({ include: { componentPurposes: true } }),
        prisma.platformScreen.findMany({ include: { functions: true, componentPurposes: true } }),
        prisma.systemDomain.findMany({ include: { systems: { include: { components: true } } } })
      ]);

      const missingImplementedConcerns = screens.flatMap((s: any) => 
        s.functions.map((f: any) => ({ ...f, screenName: s.name, route: s.route }))
      ).filter((f: any) => f.status === 'unimplemented' || !f.apiEndpoint);

      const missingC4Components = domains.flatMap((d: any) =>
        d.systems.flatMap((sys: any) => 
          sys.components.filter((c: any) => c.status === 'unimplemented').map((c: any) => ({
            id: c.id,
            title: `[C4 Component] ${c.name}`,
            screenName: `[System] ${sys.name}`,
            route: c.repoPath || 'N/A',
            justification: `Language: ${c.language || 'Unknown'}`
          }))
        )
      );

      const allMissingAnomalies = [
        ...missingImplementedConcerns.map((m: any) => ({
          id: m.id,
          title: m.title,
          screenName: m.screenName,
          route: m.route,
          justification: m.justification || 'No justification provided'
        })),
        ...missingC4Components
      ];

      return c.json({
        success: true,
        dbLinkedLayers: structuralLayers.map((l: any) => ({
          id: l.id,
          name: l.name,
          componentsGoverned: l.componentPurposes.length
        })),
        c4Topology: domains.map((d: any) => ({
          id: d.id,
          name: d.name,
          description: d.description || '',
          systems: d.systems.map((sys: any) => ({
            id: sys.id,
            name: sys.name,
            componentsCount: sys.components.length,
            components: sys.components.map((c: any) => ({
              id: c.id,
              name: c.name,
              status: c.status,
              repoPath: c.repoPath
            }))
          }))
        })),
        layerStatus: {
          flaggedFunctionsWithoutAPIs: allMissingAnomalies.length,
          missingComponents: allMissingAnomalies
        },
        timestamp: new Date().toISOString()
      });
    } catch (error: any) {
      return c.json({ success: false, error: error.message }, 500);
    }
  }

  static async auditPurpose(c: any) {
    const body = await c.req.json();
    const prisma = c.get('prisma') as PrismaClient;
    if (!prisma) return c.json({ success: false, error: 'DB unavailable' }, 500);

    try {
      const layer = await prisma.architecturalLayer.upsert({
        where: { name: body.layer || 'Unassigned' },
        create: { name: body.layer || 'Unassigned', description: 'Auto-generated via API audit' },
        update: {}
      });

      const purposeEvent = await prisma.componentPurpose.create({
        data: {
          layerId: layer.id,
          screenId: body.screenId || null,
          functionalityId: body.functionalityId || null,
          targetFile: body.component || null,
          description: body.purpose || 'No purpose supplied',
          implementedWell: body.implementedWell !== false
        }
      });

      return c.json({ success: true, message: 'Code purpose formalized into DB schema', purposeId: purposeEvent.id }, 201);
    } catch (error: any) {
      return c.json({ success: false, error: error.message }, 500);
    }
  }
}
