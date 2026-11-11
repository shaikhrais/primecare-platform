# Success profile palette batch

33 fixed colors in four shared success-profile sections. Use inherited surfaces, outlines and text roles. Pair header verification with success surface/foreground, identity avatar and role badge with primary container/foreground, and sign-out affordance with readable error foreground. Portal categories use primary/secondary accents rather than assigning warning/error meaning to normal workspaces. Resolve portal icons against their actual composited tints.

Preserve all role-to-portal mappings, privilege checks, launch URLs, disabled unauthorized onTap branches, descriptions and logout callbacks. Native regression must instantiate all four actual sections with controlled auth state, checking authorized and locked portals, readable theme colors, text scales and logout callback. Publish shared utility/validation then two sets of two source files, directly on current main. No baseline exemptions.

Validation: 259 combined migration tests pass. All four files reverse to exact original input hashes, reapply exactly, and produce no changes on a second pass. Source callback/policy invariants, dynamic const scopes, native delimiters and workflow YAML pass. Native execution is pending GitHub CI.
