import { ButtonRegistry, ButtonDef } from './ButtonRegistry';
import { LinkRegistry, LinkDef } from './LinkRegistry';
import { InteractionARegistry, InteractionADef } from './InteractionARegistry';

export type { ButtonDef, LinkDef, InteractionADef };
export { ButtonRegistry, LinkRegistry, InteractionARegistry };

export const UnifiedInteractiveRegistry = {
    buttons: ButtonRegistry,
    links: LinkRegistry,
    interactions: InteractionARegistry
};
