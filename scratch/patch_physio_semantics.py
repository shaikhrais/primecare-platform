import os

filepath = r"c:\Users\Admin2\Documents\GitHub\primecare-platform\packages\primecare_ui\lib\src\screens\allied\physiotherapist_assessment_screen.dart"

with open(filepath, 'r', encoding='utf-8') as f:
    content = f.read()

# 1. Replace the Scaffold return and Title Text
old_scaffold = """    return Scaffold(
      key: const Key('physiotherapistassessment-screen'),
      backgroundColor: theme.colors.background,
      appBar: AppBar(
        backgroundColor: theme.colors.surface,
        elevation: 0,
        title: Text(
          key: const Key('physiotherapistassessment-title'),
          state.title,
          style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
        ),"""

new_scaffold = """    return Semantics(
      label: 'data-cy:physiotherapistassessment-screen',
      container: true,
      child: Semantics(
        label: 'data-cy:assessment-screen',
        container: true,
        child: Scaffold(
          key: const Key('physiotherapistassessment-screen'),
          backgroundColor: theme.colors.background,
          appBar: AppBar(
            backgroundColor: theme.colors.surface,
            elevation: 0,
            title: Semantics(
              label: 'data-cy:physiotherapistassessment-title',
              child: Semantics(
                label: 'data-cy:assessment-title',
                child: Text(
                  key: const Key('physiotherapistassessment-title'),
                  state.title,
                  style: theme.typography.h3.copyWith(color: theme.colors.onSurface),
                ),
              ),
            ),"""

# 2. Replace the body Semantics
old_body = """      body: Semantics(
        label: 'data-cy:physiotherapistassessment-screen',
        child: SingleChildScrollView(
        key: const Key('physiotherapistassessment-content'),
        padding: const EdgeInsets.all(24.0),
        child: Column("""

new_body = """          body: Semantics(
            label: 'data-cy:physiotherapistassessment-content',
            container: true,
            child: Semantics(
              label: 'data-cy:assessment-content',
              container: true,
              child: SingleChildScrollView(
                key: const Key('physiotherapistassessment-content'),
                padding: const EdgeInsets.all(24.0),
                child: Column("""

# 3. Replace the end closing bracket sequence
old_end = """          ],
        ),),
    ),
    );
  }
}"""

new_end = """                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  ),
);
  }
}"""

if old_scaffold in content:
    content = content.replace(old_scaffold, new_scaffold)
    print("Scaffold replaced.")
else:
    print("Error: old_scaffold not found!")

if old_body in content:
    content = content.replace(old_body, new_body)
    print("Body replaced.")
else:
    print("Error: old_body not found!")

if old_end in content:
    content = content.replace(old_end, new_end)
    print("End replaced.")
else:
    print("Error: old_end not found!")

with open(filepath, 'w', encoding='utf-8') as f:
    f.write(content)
print("Saved.")
