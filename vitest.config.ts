import { defineConfig } from 'vitest/config';
import path from 'path';

export default defineConfig({
  resolve: {
    alias: {
      '@primecare/database': path.resolve(__dirname, './packages/database/generated/client/index.js'),
    },
  },
  test: {
    globals: true,
  },
});
