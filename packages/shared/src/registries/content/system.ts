export const systemContent = {
    API_ENDPOINTS: {
        TITLE: 'APIs',
        SUBTITLE: 'Endpoint registry',
        TEST_BTN: 'Test',
        READY: 'Ready',
        TESTING: '⌛...',
    },
    PAGES: {
        TITLE: 'Pages',
        SUBTITLE: 'Route mapping',
    },
    COMPONENTS: {
        TITLE: 'UI Comp',
        SUBTITLE: 'Design tokens',
    },
    MONITORING: {
        TITLE: 'Health',
        SUBTITLE: 'Infrastructure telemetry',
        API_CLUSTER: 'Nodes',
        UPTIME_DESC: '24h • 42ms',
        DB_TELEMETRY: 'P99 • 8.4GB',
        LOGS_TITLE: 'Logs',
        HEARTBEAT: 'OK.',
    },
    ENV_AUDIT: {
        TITLE: 'Env',
        SUBTITLE: 'Config audit',
        SECURITY_NOTE: 'Sensitive keys masked.',
    },
    REGISTRY_CHECK: {
        TITLE: 'Integrity',
        SUBTITLE: 'Sync status',
    },
    DATABASE_SCHEMA: {
        TITLE: 'Schema',
        SUBTITLE: 'Prisma overview',
        MODEL_NAME: 'Model',
        CORE_FIELDS: 'Fields',
        RELATIONS: 'Rel',
        SYNC_STATUS: 'Sync',
        INSIGHT: 'Data isolation isolated at app level.',
    },
    INTEGRITY: {
        TOTAL_ROUTES: 'Total Route Definitions',
        API_MAPPINGS: 'API Endpoint Mappings',
        TRANSLATION_OVERLAP: 'Translation Keys Overlap',
        BROKEN_LINKS: 'Broken Internal Links',
    },
    SECURITY: {
        TITLE: 'Platform Security Lattice',
        PERMISSIONS: 'Deep Permission Grid',
        THREATS: 'Real-time Threat Surveillance',
        SESSIONS: 'Active Session Governance',
        CRYPTO: 'End-to-End Encryption Audit',
    },
    GOVERNANCE: {
        TITLE: 'Live Governance',
        FOOTER: "Shadowing is strictly monitored. Ensure your local environment is configured for 'TECHNICAL_SUPPORT' mode before assuming identities.",
        TITLE_ALERTS: 'Security & Compliance Guardrails',
        DATA_ISOLATION: 'Tenant Data Isolation',
        ENCRYPTION: 'At-Rest Encryption',
        AUDIT_TRAIL: 'Immutable Audit Logs',
        STATUS_LOCKED: 'Secured',
    },
    IMPERSONATION: {
        TITLE: 'User Shadowing & Debug',
        SUBTITLE: 'Securely simulate user sessions to diagnose technical issues and verify RBAC policies.',
        SEARCH_PLACEHOLDER: 'Search by name, email, or Role ID...',
        SEARCH_BTN: 'Find Users',
        SEARCHING: 'Searching...',
        RESULTS_TITLE: 'Search Results',
        MATCH_COUNT: (count: number) => count + ' match(es)',
        INSPECT_BTN: 'Inspect Identity',
        EMPTY_STATE: 'No active audit targets selected.',
        EMPTY_DESC: 'Enter a search query to locate users across the franchise.',
        MODAL: {
            TITLE: 'Identity Metadata',
            SHADOW_BTN: 'Shadow User Session',
            SHIFTING: '✨ Shifting Reality...',
            FOOTER: "Shadowing creates a technical trace in the audit logs. You will have full access to the user's view, data, and permissions.",
            SELECT_PROMPT: 'Select a user to view identity metadata',
        }
    },
    INSIGHTS: {
        TITLE: 'PrimeCare AI Insights',
        SUBTITLE: 'Predictive models and clinical intelligence for your agency.',
        CARDS: {
            BURNOUT: {
                LABEL: 'Staff Burnout Risk',
                DESC: 'PSWs exceed recommended overtime hours.'
            },
            COMPLIANCE: {
                LABEL: 'Compliance Probability',
                DESC: 'Based on automated documentation audits.'
            },
            DEMAND: {
                LABEL: 'Shift Demand Forecast',
                DESC: 'Expected increase in weekend shift requests.'
            }
        },
        CHARTS: {
            RISK_PERFORMANCE: 'Risk vs. Performance (Weekly Prediction)',
        },
        TIPS: {
            TITLE: 'AI-Generated Care Tips',
            DOC_GAP: {
                TITLE: 'Documentation Gap',
                DESC: 'Client has missing daily notes. Risk: Moderate.'
            },
            STAFF_OPT: {
                TITLE: 'Staff Optimization',
                DESC: 'PSWs in specific regions are under-utilized.'
            }
        },
        FIX: 'Fix', // Added for SCRUM_MASTER dashboard needs
        LOADING: 'Synchronizing data...',
    },
    AI: {
        TITLE: 'Clinical Intelligence Hub',
        INSIGHTS: 'Predictive Care Patterns',
        CHURN_RISK: 'Patient Churn Surveillance',
        OPTIMIZATION: 'Workflow Visit Optimization',
        AUTO_PILOT: 'Clinical Autopilot',
    },
    CLINICAL_ASSISTANT: {
        TITLE: 'AI Clinical Assistant',
        SUBTITLE: 'Transform assessment notes into detailed care plans in seconds.',
        INPUT_LABEL: 'Input Assessment Notes',
        INPUT_PLACEHOLDER: 'e.g. Client shows signs of fatigue during transfers...',
        GENERATE_BTN: '🪄 Generate Care Plan',
        GENERATING: 'Generating Plan...',
        DRAFT_TITLE: 'Generated Plan Draft',
        DRAFT_EMPTY: 'Your AI-generated plan will appear here.',
        ANALYZING: 'Analysing clinical data...',
        APPROVE_BTN: 'Approve & Save',
        EDIT_BTN: 'Edit Draft'
    },
    ANOMALIES: {
        TITLE: 'Detected Anomalies',
        SEVERITY: 'Severity',
        COMPONENT: 'Component',
        OBSERVATION: 'Observation',
        TECHNICAL_SUGGESTION: 'Technical Suggestion',
    },
    PERFORMANCE: {
        TITLE: 'Perf',
        SUBTITLE: 'Lighthouse & Latency',
    },
    BUILD_HEALTH: {
        TITLE: 'Builds',
        SUBTITLE: 'CI/CD History',
    },
    SECURITY_SCANS: {
        TITLE: 'Scans',
        SUBTITLE: 'SAST & Deps',
    },
    LOCALIZATION: {
        TITLE: 'Locales',
        SUBTITLE: 'i18n Coverage',
    },
    DEV_KB: {
        TITLE: 'Developer Knowledge Base',
        SUBTITLE: 'Technical documentation and system architecture audit',
    },
    AUDIT: {
        TABS: {
            ROUTES: 'System Routes',
            COMPONENTS: 'Core Components',
        },
        TABLE: {
            ROUTE_NAME: 'Route Name',
            PATH: 'Browser Path',
            REFERENCE: 'Registry Reference',
            MODULE: 'Module',
            COMPONENT_NAME: 'Component Name',
            LAYER: 'Architecture Layer',
        }
    },
    LEARN: {
        TITLE: 'System Training Hub',
        SUBTITLE: 'Learn how to effectively use the PrimeCare platform',
        WHAT_YOU_CAN_DO: 'What You Can Do',
        PRO_TIPS: 'Pro Tips & Efficient Workflows',
    },
} as const;
