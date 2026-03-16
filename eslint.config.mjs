import js from '@eslint/js';
import tseslint from 'typescript-eslint';
import reactHooks from 'eslint-plugin-react-hooks';

export default tseslint.config(
  // ── Global ignores ──────────────────────────────────
  {
    ignores: [
      'node_modules/**',
      'dist/**',
      'build/**',
      '_dev/**',
      'coverage/**',
      '**/*.config.*',
      '**/generated/**',
      'scripts/**',
      'cypress/**',
      'apps/cypress-test/**',
    ],
  },

  // ── Base JS recommended ─────────────────────────────
  js.configs.recommended,

  // ── TypeScript recommended ──────────────────────────
  ...tseslint.configs.recommended,

  // ── TypeScript rule overrides (start lenient) ───────
  {
    rules: {
      '@typescript-eslint/no-unused-vars': [
        'warn',
        { argsIgnorePattern: '^_', varsIgnorePattern: '^_' },
      ],
      '@typescript-eslint/no-explicit-any': 'off',
      '@typescript-eslint/no-empty-object-type': 'off',
      '@typescript-eslint/no-require-imports': 'off',
      'no-empty-pattern': 'warn',
      'no-empty': 'warn',
      'prefer-const': 'warn',
    },
  },

  // ── React Hooks (web-admin only) ────────────────────
  {
    files: ['apps/web-admin/src/**/*.{ts,tsx}'],
    plugins: { 'react-hooks': reactHooks },
    rules: {
      'react-hooks/rules-of-hooks': 'error',
      'react-hooks/exhaustive-deps': 'warn',
    },
  },
);
