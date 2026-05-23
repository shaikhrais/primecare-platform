// Governance - Category: service | Purpose: Core implementation file for the Operations platform logic.
import { opsAdminContent } from './ops-admin';
import { opsServicesContent } from './ops-services';
import { opsDailyContent } from './ops-daily';
import { opsClinicalContent } from './ops-clinical';
import { opsFieldContent } from './ops-field';
import { opsCoordinationContent } from './ops-coordination';

export const operationsContent = {
    ...opsAdminContent,
    ...opsServicesContent,
    ...opsDailyContent,
    ...opsClinicalContent,
    ...opsFieldContent,
    ...opsCoordinationContent,
} as const;
