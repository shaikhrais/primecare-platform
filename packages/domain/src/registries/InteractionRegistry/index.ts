export * from './types';
import { CLINICAL } from './clinical';
import { FINANCE_DOMAINS } from './finance';
import { OPS } from './ops';
import { BASE } from './base';

export const InteractionRegistry = {
    ...CLINICAL,
    ...FINANCE_DOMAINS,
    ...OPS,
    ...BASE
} as const;
