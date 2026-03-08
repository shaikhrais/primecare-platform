import { opsAdminContent } from './ops-admin';
import { opsDailyContent } from './ops-daily';
import { opsClinicalContent } from './ops-clinical';
import { opsFieldContent } from './ops-field';

export const operationsContent = {
    ...opsAdminContent,
    ...opsDailyContent,
    ...opsClinicalContent,
    ...opsFieldContent,
} as const;
