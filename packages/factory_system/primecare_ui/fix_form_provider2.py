import re

with open('lib/src/shared/src/registry/primecare_form_provider.dart', 'r', encoding='utf-8') as f:
    content = f.read()

content = content.replace("Provider.family<\n      FutureProvider<Result<PrimeCareDashboardViewModel>>,\n      PrimeCareForm\n    >", "Provider.family<\n      dynamic,\n      PrimeCareForm\n    >")
content = content.replace("Provider.family<FutureProvider<Result<PrimeCareDashboardViewModel>>, PrimeCareForm>", "Provider.family<dynamic, PrimeCareForm>")

with open('lib/src/shared/src/registry/primecare_form_provider.dart', 'w', encoding='utf-8') as f:
    f.write(content)
