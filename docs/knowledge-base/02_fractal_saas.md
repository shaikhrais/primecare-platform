# Understanding the Fractal SaaS Architecture

Traditional SaaS platforms operate on a simple 1-to-many relationship. A company builds an app, and thousands of users log into that app. The relationship is direct and linear.

PrimeCare completely abandons this linear model. We operate on a **"Fractal" relationship**.

## The Architecture of Infinite Recursion
In a fractal, every part, regardless of how deeply you zoom in, looks exactly like the whole. 

The PrimeCare platform acts as the "root" of the fractal. However, the platform does not sell directly to end-users. Instead, the platform spawns **"Master Agencies" (Root Tenants)**. 

These Master Agencies are granted massive, God-mode administrative powers. Not only can they operate their own businesses on the software, but they are granted the power to mathematically spawn their own **"Sub-Agencies" (Child Tenants)** underneath them.

## The Illusion of Ownership
At every level of the fractal, the experience remains visually customized and perfectly isolated. 
*   When a Nurse logs into a Sub-Agency portal, she sees the Sub-Agency's logo and color scheme. She believes the Sub-Agency built the software.
*   When the Sub-Agency owner logs into their management dashboard, they see the Master Agency's branding. They believe the Master Agency provided the software.
*   The Master Agency is the only entity that knows they are using PrimeCare's software, but to the outside world, it looks entirely like their own brand.

## Centralized Algorithms, Decentralized Growth
This is the genius of the Fractal SaaS. While the branding and operational growth are completely decentralized (passed down to the Master and Child tenants), the underlying compliance rules, algorithms, and payment rails remain strictly unified at the Platform HQ.

Whether an agency is Level 1 or Level 10 deep in the fractal tree, when they request an auto-pilot dispatch, the centralized HQ algorithm executes the routing. When a shift settles, the centralized Stripe Connect API splits the funds. This allows HQ to maintain world-class security and enforce complex interoperability standards (like FHIR/HL7) universally, regardless of how deep the franchise tree goes.