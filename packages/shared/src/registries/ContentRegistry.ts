import { baseContent } from './content/base';
import { dashboardsContent } from './content/dashboards';
import { operationsContent } from './content/operations';
import { wizardsContent } from './content/wizards';
import { systemContent } from './content/system';
import { navContent } from './content/nav';

export const ContentRegistry = {
    ...baseContent,
    ...dashboardsContent,
    ...operationsContent,
    ...wizardsContent,
    ...systemContent,
    ...navContent,
} as const;
