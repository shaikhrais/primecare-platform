# Understanding the Fractal SaaS Architecture

Traditional SaaS platforms operate on a 1-to-many relationship (The App -> The Users). 

PrimeCare operates on a **"Fractal" relationship**. 

The platform spawns "Master Agencies" (Root Tenants). 
These Master Agencies have the God-mode power to spawn their own "Sub-Agencies" (Child Tenants).

## The Core Mechanics
At every level of the fractal, the experience remains visually customized and perfectly isolated. The Sub-Agency thinks they are using the Master Agency's proprietary software. The Master Agency knows they are using PrimeCare's software, but to the outside world, it looks entirely like their own brand.

However, across all levels of the fractal, the underlying compliance rules, algorithms (like the Clinical Auto-Pilot), and payment rails remain unified at the Platform HQ. This allows HQ to maintain security and enforce interoperability standards (like FHIR/HL7) regardless of how deep the franchise tree goes.

---

## Visual Reference & Application Route

**UI Home Link:** [Access the Growth Strategy Home Here](/admin/growth-strategy)

_Visualize the full architecture of the Fractal SaaS network in your admin portal._

![Growth Strategy Home Screenshot](https://placehold.co/800x400/F3F4F6/1E293B?text=Fractal+SaaS+Architecture)
