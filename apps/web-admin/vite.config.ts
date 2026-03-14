import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
      'prime-care-shared': resolve(__dirname, '../../packages/shared/src/index.ts'),
    },
  },
  server: {
    port: 5173,
    strictPort: true,
  },
  build: {
    chunkSizeWarningLimit: 600,
    sourcemap: false, // Disable source maps in production for smaller bundles
    rollupOptions: {
      output: {
        manualChunks(id) {
          // Vendor: React core
          if (id.includes('node_modules/react') || id.includes('node_modules/react-dom') || id.includes('node_modules/react-router')) {
            return 'vendor-react';
          }
          // Vendor: TanStack Query (heavily used for data fetching)
          if (id.includes('node_modules/@tanstack')) {
            return 'vendor-query';
          }
          // Vendor: Charts & D3
          if (id.includes('node_modules/recharts') || id.includes('node_modules/d3')) {
            return 'vendor-charts';
          }
          // Vendor: Icons (lucide-react is large)
          if (id.includes('node_modules/lucide-react')) {
            return 'vendor-icons';
          }
          // Vendor: i18n
          if (id.includes('node_modules/i18next') || id.includes('node_modules/react-i18next')) {
            return 'vendor-i18n';
          }
          // Shared registries
          if (id.includes('packages/shared/src/registries')) {
            return 'registries';
          }
          // Shared hooks & utilities
          if (id.includes('/shared/hooks/') || id.includes('/shared/utils/') || id.includes('/shared/context/')) {
            return 'shared-core';
          }
          // Role-based route chunks
          if (id.includes('/routes/tenancy/psw/')) return 'role-psw';
          if (id.includes('/routes/tenancy/rn/')) return 'role-rn';
          if (id.includes('/routes/tenancy/client/')) return 'role-client';
          if (id.includes('/routes/tenancy/coordinator/')) return 'role-coordinator';
          if (id.includes('/routes/tenancy/manager/')) return 'role-manager';
          if (id.includes('/routes/tenancy/staff/')) return 'role-staff';
          if (id.includes('/routes/platform/admin/')) return 'role-admin';
          if (id.includes('/routes/platform/scrum-master/')) return 'role-scrum-master';
        },
      },
    },
  },
})
