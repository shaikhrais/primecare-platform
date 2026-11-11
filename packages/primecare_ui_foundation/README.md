# PrimeCare UI foundation

The existing PrimeText and PrimeIcon implementations live here once and depend
only on Flutter. flutter_core and primecare_ui both depend on this package, avoiding
the forbidden flutter_core -> primecare_ui -> flutter_core cycle. Existing
primecare_ui imports continue to export the same class identities.

Inherited typography, icon themes, disabled foregrounds, keys, semantics and caller
overrides remain unchanged. Colors are supplied by active theme consumers; this
package defines no palettes. Only its two implementation files may instantiate
Material Text/Icon. Feature files in this package remain subject to the strict
shared-control gate, and literal colors are rejected even in implementations.
