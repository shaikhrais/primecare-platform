// Governance - Category: service | Purpose: Core implementation file for the Wizards platform logic.
export const wizardsContent = {
    SETUP_WIZARD: {
        TITLE: 'Business Setup Wizard',
        SUBTITLE: 'Complete these 3 steps to launch your care business.',
        STEPS: {
            SERVICES: 'Define Services',
            STAFF: 'Onboard Staff',
            CLIENTS: 'Admit Clients',
            FINISH: 'Ready to Go!'
        },
        PROGRESS: {
            TITLE: 'Overall Readiness',
            SUBTITLE: 'Completing all wizards unlocks full automation.',
        },
        HEADERS: {
            STEP_1: 'Step 1: Define Your Care Services',
            STEP_2: 'Step 2: Onboard Your First Healthcare Worker',
            STEP_3: 'Step 3: Admit Your First Client',
        },
        BUTTONS: {
            NEXT: 'Next Step',
            BACK: 'Back',
            FINISH: 'Launch My Business',
            SKIP: 'Skip for now'
        },
        SUCCESS: {
            TITLE: 'Congratulations!',
            MESSAGE: 'Your business setup is complete. You can now start scheduling visits.'
        }
    },
    WIZARD_HUB: {
        TITLE: 'Operational Wizard Hub',
        SUBTITLE: 'Streamline your daily administrative workflows.',
        STAFF: {
            TITLE: 'Staff Compliance',
            DESC: 'Verify credentials and complete HR onboarding.',
            ACTION: 'Start Onboarding'
        },
        CLIENT: {
            TITLE: 'Care Planning',
            DESC: 'Build digital care plans and medical protocols.',
            ACTION: 'Create Care Plan'
        },
        FINANCE: {
            TITLE: 'Revenue Setup',
            DESC: 'Configure billing cycles and service rates.',
            ACTION: 'Manage Revenue'
        },
        STRATEGY: {
            TITLE: 'Business Strategy',
            DESC: 'Define margins, tax IDs, and brand identity.',
            ACTION: 'Setup Strategy'
        }
    },
    STRATEGY_WIZARD: {
        TITLE: 'Business Strategy Wizard',
        SUBTITLE: 'Define your core business parameters and margins.',
        STEPS: {
            BRANDING: 'Branding & Identity',
            COMPLIANCE: 'Tax & Legal Compliance',
            MARGIN: 'Profit Margin Strategy',
        },
        BRANDING: {
            EMAIL_LABEL: 'Public Support Email',
            EMAIL_PLACEHOLDER: 'support@yourcare.com',
            LOGO_UPLOAD: 'Upload Business Logo',
            LOGO_UPLOADING: 'Uploading...',
            LOGO_CHANGE: 'Change Logo',
            LOGO_HINT: 'PNG or SVG, Max 2MB',
            LOGO_ERROR_SIZE: 'Logo must be smaller than 2MB',
        },
        COMPLIANCE: {
            BN_LABEL: 'Business Registration Number (BN)',
            BN_PLACEHOLDER: 'e.g. 12345 6789 RT0001',
            TAX_LABEL: 'Automatically apply HST/GST to invoices',
            TAX_DESC: 'Based on your primary business location settings.',
        },
        MARGIN: {
            DESC: 'Set your target gross margin. This helps calculate what you pay providers versus what you charge clients.',
            LABEL: 'TARGET MARGIN',
            LOW: 'Lean (10%)',
            MID: 'Industry Standard (30%)',
            HIGH: 'Premium (60%)',
        },
        BUTTONS: {
            SAVE_CONTINUE: 'Save & Continue',
            COMPLETE: 'Complete Setup',
            BACK: 'Back',
            CANCEL: 'Cancel',
            PROCESSING: 'Processing...',
        },
        MESSAGES: {
            SUCCESS_LOGO: 'Logo uploaded successfully!',
            ERROR_LOGO: 'Failed to upload logo',
            SUCCESS_SAVE: 'Business Strategy saved!',
            ERROR_SAVE: 'Failed to save settings',
            ERROR_SERVER: 'Error connecting to server',
        }
    },
    BUSINESS_STATUS: {
        TITLE: 'Business Command Center',
        SUBTITLE: 'Monitor your setup progress and perform rapid data entry.',
        INITIALIZING: 'Initializing Command Center...',
        FOOTER: {
            TITLE: 'Need to add something specific?',
            VIEW_STAFF: '→ View All Staff',
            MANAGE_LEADS: '→ Manage Leads',
            DISPATCH_SHIFTS: '→ Dispatch Shifts',
        },
        DOMAINS: {
            STRATEGY: 'Business Model',
            SERVICES: 'Care Services',
            STAFF: 'Provider Network',
            CLIENTS: 'Client Roster',
            FINANCE: 'Financial Ops'
        }
    },
    STAFF_WIZARD: {
        TITLE: 'Staff Registry & Compliance',
        SUBTITLE: 'Onboard new care providers and verify clinical credentials.',
        STEPS: ['Profile', 'Compliance', 'Documents'],
        FORM: {
            NAME_LABEL: 'Full Legal Name',
            NAME_PLACEHOLDER: 'e.g. John Doe',
            EMAIL_LABEL: 'Professional Email',
            EMAIL_PLACEHOLDER: 'john@example.com',
            ROLE_LABEL: 'Professional Role',
            SIN_LABEL: 'Tax ID / SIN',
            SIN_PLACEHOLDER: '000-000-000',
            DOCS_TITLE: 'Required Credentials',
            VSS_LABEL: 'Vulnerable Sector Screen (VSS)',
            LICENSE_LABEL: 'Clinical License / Certificate',
            UPLOAD_BTN: 'Upload Document',
            SUBMIT_BTN: 'Register Provider',
            SUBMITTING: 'Registering...',
            SUCCESS: 'Provider registered successfully'
        }
    },
    CARE_WIZARD: {
        TITLE: 'Client Admission & Intake',
        SUBTITLE: 'Standardized care planning and intake flow.',
        STEPS: ['Demographics', 'Clinical Profile', 'Baseline ADLs'],
        FORM: {
            NAME_LABEL: 'Full Legal Name',
            NAME_PLACEHOLDER: 'e.g. Sarah Jenkins',
            EMAIL_LABEL: 'Email (Portal Access)',
            EMAIL_PLACEHOLDER: 'sarah@example.com',
            ADDR_LABEL: 'Service Address',
            ADDR_PLACEHOLDER: '123 Care Street, Suite 4B...',
            MEDICAL_TITLE: 'Clinical Profile & Allergies',
            MEDICAL_LABEL: 'Medical History & Known Conditions',
            MEDICAL_PLACEHOLDER: 'Detail chronic conditions, allergies, or physical limitations...',
            ADL_TITLE: 'Baseline ADLs (Assistance Levels)',
            SUBMIT_BTN: 'Finalize Care Plan',
            NEXT_BTN: 'Next Step',
            BACK_BTN: 'Back',
            ADMIT_BTN: 'Admit Client',
            ADMITTING: 'Admitting...'
        }
    },
    REVENUE_WIZARD: {
        TITLE: 'Revenue & Billing Configuration',
        SUBTITLE: 'Configure your rates and billing automation.',
        ECONOMICS_TITLE: 'Service Economics',
        RATE_LABEL: 'Base Hourly Rate (Client Charge)',
        CYCLE_LABEL: 'Billing Frequency',
        TAX_TITLE: 'Automated Tax Calculation',
        TAX_DESC: 'Automatically apply HST/GST to all invoices.',
        SUBMIT_BTN: 'Finalize Finance Setup',
        SAVING: 'Saving...',
        SUCCESS: 'Financial settings updated'
    },
    HEALTH_ALERTS: {
        TITLE: 'Business Health Monitor',
        COMPLIANCE: {
            LABEL: 'Compliance Risk',
            DESC: 'Staff with missing or expired documents'
        },
        COVERAGE: {
            LABEL: 'Coverage Gap',
            DESC: 'Unassigned visits in the next 7 days'
        },
        PIPELINE: {
            LABEL: 'Pipeline Stagnation',
            DESC: 'Leads not contacted in 3+ days'
        }
    },
} as const;
