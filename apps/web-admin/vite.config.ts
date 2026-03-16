import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import viteCompression from 'vite-plugin-compression'
import { sentryVitePlugin } from '@sentry/vite-plugin'

import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react(),
    // Brotli pre-compression (~60-70% size reduction)
    viteCompression({
      algorithm: 'brotliCompress',
      ext: '.br',
      threshold: 1024, // Only compress files > 1KB
    }),
    // Gzip fallback for older clients
    viteCompression({
      algorithm: 'gzip',
      ext: '.gz',
      threshold: 1024,
    }),
    // Sentry source map upload (only during production build with auth token)
    sentryVitePlugin({
      org: process.env.SENTRY_ORG || '',
      project: process.env.SENTRY_PROJECT || 'web-admin',
      authToken: process.env.SENTRY_AUTH_TOKEN || '',
      disable: !process.env.SENTRY_AUTH_TOKEN,
    }),
  ],
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
    chunkSizeWarningLimit: 400, // Stricter to catch regressions
    sourcemap: 'hidden',  // Generates source maps for Sentry but doesn't expose them
    cssCodeSplit: true,
    minify: 'esbuild',
    target: 'es2020',
    rollupOptions: {
      output: {
        manualChunks(id) {
          // ── Vendor: React core (react + react-dom + react-router) ──
          if (id.includes('node_modules/react/') || id.includes('node_modules/react-dom/') || id.includes('node_modules/scheduler/')) {
            return 'vendor-react-core';
          }
          if (id.includes('node_modules/react-router')) {
            return 'vendor-router';
          }

          // ── Vendor: TanStack Query ──
          if (id.includes('node_modules/@tanstack')) {
            return 'vendor-query';
          }

          // ── Vendor: Charts (lazy-loaded only on chart pages) ──
          if (id.includes('node_modules/recharts') || id.includes('node_modules/d3-') || id.includes('node_modules/victory')) {
            return 'vendor-charts';
          }

          // ── Vendor: Maps (lazy-loaded only on map pages) ──
          if (id.includes('node_modules/leaflet') || id.includes('node_modules/react-leaflet')) {
            return 'vendor-maps';
          }

          // ── Vendor: Calendar (lazy-loaded only on scheduling pages) ──
          if (id.includes('node_modules/react-big-calendar') || id.includes('node_modules/rrule')) {
            return 'vendor-calendar';
          }

          // ── Vendor: Markdown renderer ──
          if (id.includes('node_modules/react-markdown') || id.includes('node_modules/remark') || id.includes('node_modules/rehype') || id.includes('node_modules/unified') || id.includes('node_modules/micromark')) {
            return 'vendor-markdown';
          }

          // ── Vendor: Icons ──
          if (id.includes('node_modules/lucide-react')) {
            return 'vendor-icons';
          }

          // ── Vendor: i18n ──
          if (id.includes('node_modules/i18next') || id.includes('node_modules/react-i18next')) {
            return 'vendor-i18n';
          }

          // ── Vendor: Auth (Google OAuth) ──
          if (id.includes('node_modules/@react-oauth')) {
            return 'vendor-auth';
          }

          // ── Vendor: Date utilities ──
          if (id.includes('node_modules/date-fns')) {
            return 'vendor-dates';
          }

          // ── Vendor: Zod validation ──
          if (id.includes('node_modules/zod')) {
            return 'vendor-zod';
          }

          // ── Shared: Registries (loaded per-role) ──
          if (id.includes('packages/shared/src/registries')) {
            return 'registries';
          }

          // ── Shared: Core hooks, utils, context ──
          if (id.includes('/shared/hooks/') || id.includes('/shared/utils/') || id.includes('/shared/context/') || id.includes('/shared/api/')) {
            return 'shared-core';
          }

          // ── Shared: Design system components ──
          if (id.includes('/shared/components/design-system/')) {
            return 'shared-design-system';
          }

          // ── Role chunks (each role is a separate lazy chunk) ──
          if (id.includes('/routes/tenancy/psw/')) return 'role-psw';
          if (id.includes('/routes/tenancy/rn/')) return 'role-rn';
          if (id.includes('/routes/tenancy/client/')) return 'role-client';
          if (id.includes('/routes/tenancy/coordinator/')) return 'role-coordinator';
          if (id.includes('/routes/tenancy/manager/')) return 'role-manager';
          if (id.includes('/routes/tenancy/staff/')) return 'role-staff';
          if (id.includes('/routes/platform/scrum-master/')) {
            if (id.includes('/audit/') || id.includes('Audit') || id.includes('Integrity')) return 'scrum-audit';
            if (id.includes('/developer') || id.includes('/dev-kb')) return 'scrum-developer';
            return 'role-scrum-master';
          }

          // ── Admin: Split into sub-domains for granular lazy loading ──
          if (id.includes('/routes/platform/admin/')) {
            if (id.includes('/finance/') || id.includes('Finance') || id.includes('Ledger') || id.includes('Invoice')) return 'admin-finance';
            if (id.includes('/compliance/') || id.includes('Compliance') || id.includes('Audit')) return 'admin-compliance';
            if (id.includes('/analytics/') || id.includes('Analytics') || id.includes('Dashboard') || id.includes('Stats')) return 'admin-analytics';
            if (id.includes('/security/') || id.includes('Security') || id.includes('Forensic') || id.includes('Cors') || id.includes('Permission') || id.includes('Session') || id.includes('Threat') || id.includes('Integrity')) return 'admin-security';
            if (id.includes('/setup/') || id.includes('Wizard') || id.includes('Onboarding')) return 'admin-setup';
            if (id.includes('/ai/') || id.includes('/insights/') || id.includes('Clinical')) return 'admin-ai';
            if (id.includes('/erp/') || id.includes('/telehealth/') || id.includes('/rcm/') || id.includes('/pharmacy/') || id.includes('/evv/')) return 'admin-healthcare';
            if (id.includes('/ops/') || id.includes('/authorizations/') || id.includes('/consent/') || id.includes('/referrals/') || id.includes('/claims/') || id.includes('/webhooks/')) return 'admin-operations';
            return 'admin-core';
          }
        },
      },
    },
  },
})
