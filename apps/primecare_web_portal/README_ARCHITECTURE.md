# PrimeCare Enterprise Web Shell

This project implements a **Dynamic Shell Architecture** designed for enterprise scalability. It decouples the core layout from functional business logic using a **Control Center** pattern.

## 🏗 Architecture Detail

### 1. The Control Center (`src/core/ControlCenter.ts`)
The "Brain" of the application. 
- **Centralized State**: Manages routing, user context, and platform-wide configurations.
- **Observer Pattern**: Components "subscribe" to state changes, ensuring reactive updates without high-level framework overhead.
- **Scalability**: New views or states can be added here without touching component internals.

### 2. Functional Components (`src/components/`)
Each major layout area is a decoupled function:
- **`Sidebar()`**: Handles navigation and branding.
- **`Topbar()`**: Handles context-aware titles and user profile.
- **`Content()`**: The dynamic mounting point for business views.

### 3. The Layout Engine (`src/main.ts`)
Wires the components into the DOM using a **Grid-based Shell**. This ensures visual consistency while allowing the content area to be entirely dynamic.

## 🎨 Design System
- **Corporate Modern**: Uses the PrimeCare Clinical palette.
- **Glassmorphism**: Subtle blur effects for a premium enterprise feel.
- **Micro-animations**: Smooth transitions between views handled by CSS and the state engine.

## 🚀 Future Development
- **Module Federation**: This shell can easily be extended to load external JS bundles (Micro-frontends) into the `Content` area.
- **Middleware**: The `ControlCenter` can support middleware for auth checks, logging, or telemetry before state updates.
