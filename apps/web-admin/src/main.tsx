import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import { AuthProvider } from './shared/context/AuthContext'
import { ThemeProvider } from './shared/context/ThemeContext'
import { initGlobalErrorCapture } from './shared/utils/globalErrorCapture'
import './lib/i18n'
import './index.css'
import 'leaflet/dist/leaflet.css'

// Initialize global error capture before React mounts
initGlobalErrorCapture();

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <AuthProvider>
      <ThemeProvider>
        <App />
      </ThemeProvider>
    </AuthProvider>
  </React.StrictMode>
)
