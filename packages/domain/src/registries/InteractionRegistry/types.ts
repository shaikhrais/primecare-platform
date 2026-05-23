// Governance - Category: service | Purpose: Core implementation file for the Types platform logic.
import { RouteRegistry } from '../../apps/web-admin/RouteRegistry';
import { ApiRegistry } from '../ApiRegistry';

export type InteractionType = 'button' | 'link' | 'submit' | 'tab' | 'nav_item';

export interface InteractionDef {
    id: string;
    label: string;
    type: InteractionType;
    icon?: string;
    route?: string;
    apiEndpoint?: string | ((...args: any[]) => string);
    permission?: string;
    module: 'ADMIN' | 'MANAGER' | 'STAFF' | 'PSW' | 'CLIENT' | 'RN' | 'SCRUM_MASTER' | 'MARKETING' | 'HR' | 'COORDINATOR';
    purpose: string;
}
