import os
import re
import subprocess

PROJECT_ROOT = r"C:\Users\Admin2\Documents\GitHub\primecare-platform"

DUAL_FILES = [
    (
        os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "allied", "physiotherapist_assessment_screen.dart"),
        "physiotherapistassessment",
        "assessment"
    ),
    (
        os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "allied", "rmt_treatment_notes_screen.dart"),
        "rmttreatmentnotes",
        "treatmentnotes"
    ),
    (
        os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "rn", "rn_patient_charting_screen.dart"),
        "rnpatientcharting",
        "patientcharting"
    ),
    (
        os.path.join(PROJECT_ROOT, "packages", "primecare_ui", "lib", "src", "screens", "psw", "psw_incident_report_screen.dart"),
        "pswincidentreport",
        "incidentreport"
    )
]

def patch_nested_semantics(filepath, role_key, generic_key):
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()

    # 1. Patch root semantics
    # Find:
    # return Semantics(
    #   label: 'data-cy:role_key-screen data-cy:generic_key-screen',
    #   container: true,
    #   child: Scaffold(
    root_pattern = rf"return\s+Semantics\(\s*label:\s*['\"]data-cy:{role_key}-screen\s+data-cy:{generic_key}-screen['\"],\s*container:\s*true,\s*child:\s*Scaffold\("
    root_replacement = (
        f"return Semantics(\n"
        f"      container: true,\n"
        f"      label: 'data-cy:{role_key}-screen',\n"
        f"      child: Semantics(\n"
        f"        container: true,\n"
        f"        label: 'data-cy:{generic_key}-screen',\n"
        f"        child: Scaffold("
    )
    
    # We must match the closing parenthesis of the nested Semantics as well!
    # Scaffold is closed at the very end of buildScreen, which is just before "    );\n  }\n}" or similar.
    # To avoid matching complex braces, a very robust way is to just replace the return Semantics declaration
    # and then add the closing parenthesis ");" right before ";\n  }\n}" in buildScreen!
    # Let's inspect the end of buildScreen in these files.
    # In these files, it ends with:
    #         ),
    #       ),
    #     );
    #   }
    # }
    # So we can replace the last "      ),\n    );\n  }\n}" with "        ),\n      ),\n    );\n  }\n}" to close the nested Semantics!
    # Let's make sure we find the exact end pattern.
    
    # 2. Patch AppBar title semantics
    title_pattern = rf"title:\s+Semantics\(\s*(?:container:\s*true,\s*)?label:\s*['\"]data-cy:{role_key}-title\s+data-cy:{generic_key}-title['\"],\s*child:\s*Text\("
    title_replacement = (
        f"title: Semantics(\n"
        f"            container: true,\n"
        f"            label: 'data-cy:{role_key}-title',\n"
        f"            child: Semantics(\n"
        f"              container: true,\n"
        f"              label: 'data-cy:{generic_key}-title',\n"
        f"              child: Text("
    )

    # 3. Patch body semantics
    body_pattern = rf"body:\s+Semantics\(\s*label:\s*['\"]data-cy:{role_key}-content\s+data-cy:{generic_key}-content['\"],\s*container:\s*true,\s*child:\s*SingleChildScrollView\("
    body_replacement = (
        f"body: Semantics(\n"
        f"          container: true,\n"
        f"          label: 'data-cy:{role_key}-content',\n"
        f"          child: Semantics(\n"
        f"            container: true,\n"
        f"            label: 'data-cy:{generic_key}-content',\n"
        f"            child: SingleChildScrollView("
    )

    # Let's execute replacements
    new_content = re.sub(root_pattern, root_replacement, content)
    new_content = re.sub(title_pattern, title_replacement, new_content)
    new_content = re.sub(body_pattern, body_replacement, new_content)

    # Close the nested root Semantics at the end of buildScreen
    # Let's find "    );\n  }\n}" and change to "      ),\n    );\n  }\n}"
    end_pattern = r"        \),\n      \),\n    \);\n  \}\n\}"
    # Wait, the Scaffold ends with two closing parens/braces.
    # In the original file, it is:
    #         ),
    #       ),
    #     );
    #   }
    # }
    # Since we added a nested Semantics around Scaffold, we need one more nested paren:
    #           ),
    #         ),
    #       ),
    #     );
    # Let's replace:
    #         ),
    #       ),
    #     );
    #   }
    # }
    # with:
    #           ),
    #         ),
    #       ),
    #     );
    #   }
    # }
    # To be extremely safe, we check if the file ends with this block.
    original_end = "        ),\n      ),\n    );\n  }\n}"
    replacement_end = "          ),\n        ),\n      ),\n    );\n  }\n}"
    if original_end in new_content:
        new_content = new_content.replace(original_end, replacement_end)
    else:
        print(f"[!] Warning: End pattern not found in {os.path.basename(filepath)}")

    # Close the nested body Semantics
    # The body ends with:
    #             ),
    #           ),
    #         ),
    #       ),
    # Since we nested a Semantics around SingleChildScrollView, let's find the closing of the body SingleChildScrollView:
    #           ),
    #         ),
    # And change to:
    #             ),
    #           ),
    #         ),
    # Wait, the body semantics was:
    #         body: Semantics(
    #           label: 'data-cy:role-content...',
    #           container: true,
    #           child: SingleChildScrollView(
    #             child: Column(
    #               ...
    #             ),
    #           ),
    #         ),
    # Since we nested body, we need:
    #         body: Semantics(
    #           container: true,
    #           label: 'data-cy:role-content',
    #           child: Semantics(
    #             container: true,
    #             label: 'data-cy:generic-content',
    #             child: SingleChildScrollView(
    #               child: Column( ... ),
    #             ),
    #           ),
    #         ),
    # So we need to find:
    #             child: Column(
    #               ...
    #             ),
    #           ),
    #         ),
    # Let's find:
    #               ],
    #             ),
    #           ),
    #         ),
    # And replace with:
    #                 ],
    #               ),
    #             ),
    #           ),
    #         ),
    # Actually, we can let "dart format" fix it if we just insert the closing paren.
    # A safe way is to find:
    #               ],
    #             ),
    #           ),
    #         ),
    # And replace it!
    # Wait, let's do this replacement:
    body_end_original = "            ),\n          ),\n        ),"
    body_end_replacement = "              ),\n            ),\n          ),\n        ),"
    if body_end_original in new_content:
         new_content = new_content.replace(body_end_original, body_end_replacement)
    
    # Close the nested AppBar title Semantics
    # The AppBar title ends with:
    #             ),
    #           ),
    #           actions: [
    # Since we nested title, we need:
    #             ),
    #           ),
    # Let's check:
    #             child: Text(
    #               ...
    #             ),
    #           ),
    #           actions: [
    # Since we nested, we need:
    #               child: Text(
    #                 ...
    #               ),
    #             ),
    #           ),
    #           actions: [
    # So let's replace:
    #             ),
    #           ),
    #           actions: [
    # with:
    #               ),
    #             ),
    #           ),
    #           actions: [
    title_end_original = "            ),\n          ),\n          actions: ["
    title_end_replacement = "              ),\n            ),\n          ),\n          actions: ["
    if title_end_original in new_content:
        new_content = new_content.replace(title_end_original, title_end_replacement)

    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(new_content)

    print(f"[+] Successfully patched nested semantics: {os.path.basename(filepath)}")
    return True

def main():
    print("=== STARTING NESTED SEMANTICS PATCHING ===")
    for filepath, role_key, generic_key in DUAL_FILES:
        patch_nested_semantics(filepath, role_key, generic_key)
        
    print("\n[*] Formatting screens...")
    subprocess.run(["dart", "format", "packages/primecare_ui/lib/src/screens/"], cwd=PROJECT_ROOT, shell=True)
    print("[+] Formatting complete!")

if __name__ == '__main__':
    main()
