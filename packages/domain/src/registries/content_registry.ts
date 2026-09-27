// Governance - Category: service | Purpose: Core implementation file for the Content Registry platform logic.
import { baseContent } from './content/base';
import { homesContent } from './content/homes';
import { operationsContent } from './content/operations';
import { wizardsContent } from './content/wizards';
import { systemContent } from './content/system';
import { navContent } from './content/nav';
import { domainFeaturesContent } from './content/domain_features';

export const ContentRegistry = {
    ...baseContent,
    ...homesContent,
    ...operationsContent,
    ...wizardsContent,
    ...systemContent,
    ...navContent,
    ...domainFeaturesContent,
} as const;
