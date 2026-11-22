import {MasterDashboard} from "../../../../packages/primecare_master/web/primecare_ui/web/master-dashboard";
import type {DashboardDialogOptions} from "../../../../packages/primecare_master/web/primecare_ui/web/dashboard-dialog-manager";
import type {ScreenManager,ScreenRegistration} from "../../../../packages/primecare_master/web/primecare_ui/web/screen-manager";
import catalog from "../../../../packages/primecare_master/web/shared/src/tenant-dashboard/catalog.json";

/** Only the existing dashboard configuration; behavior is inherited. */
export class TenantAdminDashboard extends MasterDashboard {
  constructor(root: HTMLElement, manager: ScreenManager, entry: Pick<ScreenRegistration,'id'|'route'>, panels: DashboardDialogOptions) {
    super(root,manager,entry,catalog,panels);
  }
}
