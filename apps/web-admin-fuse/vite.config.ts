import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import tailwindcss from "@tailwindcss/vite"
import { resolve } from 'path'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [
    react({
      jsxImportSource: '@emotion/react'
    }),
    tailwindcss(),
  ],
  resolve: {
    alias: {
      '@': resolve(__dirname, './src'),
      '@fuse': resolve(__dirname, './src/@fuse'),
      'app/theme-layouts': resolve(__dirname, './src/shared/theme-layouts'),
      'app/configs': resolve(__dirname, './src/configs'),
      'prime-care-shared': resolve(__dirname, '../../packages/shared/src/index.ts'),
    },
  },
  server: {
    port: 5173,
    strictPort: true,
  },
  define: {
    global: 'window'
  }
})

