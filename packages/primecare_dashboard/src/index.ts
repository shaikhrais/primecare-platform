/** Narrow dashboard facade over the canonical rendering and layout contracts.
 * Existing implementations and type identity are preserved during migration.
 */
export {PrimeDashboardWidgets} from '../../primecare_ui/web/dashboard-widgets';
export {validateChart,chartGeometry,validateRegistry,validateDashboard,parseDashboard,activeViewport,packDashboard,editDashboard} from '../../domain/src/dashboard_widgets';
export type {ChartKind,ChartData,ViewportSpec,WidgetSpec,Placement,DashboardLayout} from '../../domain/src/dashboard_widgets';
