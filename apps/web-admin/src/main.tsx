// Sentry must be initialized before any other imports
import './lib/sentry'
import React from 'react'
import ReactDOM from 'react-dom/client'
import App from './App'
import './lib/i18n'
import './index.css'
// NOTE: leaflet CSS removed from global entry — it's now lazy-loaded
// by map components (LogisticsHub, RegionMapping) to avoid 30KB+ CSS
// penalizing users who never visit map pages.

ReactDOM.createRoot(document.getElementById('root') as HTMLElement).render(
  <React.StrictMode>
    <App />
  </React.StrictMode>
)
