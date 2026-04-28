import re

with open('lib/src/shared/src/generic/dynamic_screen_adapter.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("return ref.watch(adapterProvider);", "return ref.watch(adapterProvider as ProviderListenable<AsyncValue<Result<PrimeCareDashboardViewModel>>>);")
content = content.replace("return ref.refresh(adapterProvider.future);", "return ref.refresh((adapterProvider as dynamic).future as Refreshable<FutureOr<void>>);")

with open('lib/src/shared/src/generic/dynamic_screen_adapter.dart', 'w', encoding='utf-8') as f:
    f.write(content)

print("Dynamic Screen Adapter fixed")
