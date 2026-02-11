/**
 * Enterprise Form JSON Schemas
 * Used for Layer 4 (Network Payload) verification in Cypress tests.
 * Ensures the frontend is sending the correct contract keys and types.
 */

export const FORM_SCHEMAS = {
    DAILY_ENTRY: {
        type: "object",
        required: ["clientId", "adl", "mood", "vitals", "notes", "signature"],
        properties: {
            clientId: { type: "string" },
            adl: { type: "object" },
            mood: { type: "string" },
            vitals: { type: "object" },
            notes: { type: "string" },
            signature: { type: "string" }
        }
    },
    PROFILE_UPDATE: {
        type: "object",
        required: ["fullName", "email", "phone", "address"],
        properties: {
            fullName: { type: "string" },
            email: { type: "string" },
            phone: { type: "string" },
            address: { type: "string" }
        }
    },
    SERVICE_CREATE: {
        type: "object",
        required: ["name", "category", "rate", "description"],
        properties: {
            name: { type: "string" },
            category: { type: "string" },
            rate: { type: "string" },
            description: { type: "string" }
        }
    },
    CLIENT_ADMISSION: {
        type: "object",
        required: ["fullName", "email", "phone", "address", "emergencyContact"],
        properties: {
            fullName: { type: "string" },
            email: { type: "string" },
            phone: { type: "string" },
            address: { type: "string" },
            emergencyContact: { type: "string" },
            medicalNotes: { type: "string" }
        }
    },
    PSW_ONBOARDING: {
        type: "object",
        required: ["fullName", "email", "phone", "sin", "certifications"],
        properties: {
            fullName: { type: "string" },
            email: { type: "string" },
            phone: { type: "string" },
            sin: { type: "string" },
            certifications: { type: "array" },
            backgroundCheckStatus: { type: "string" }
        }
    },
    EVALUATION: {
        type: "object",
        required: ["staffId", "performanceScore", "attendanceScore", "technicalSkills"],
        properties: {
            staffId: { type: "string" },
            performanceScore: { type: "number" },
            attendanceScore: { type: "number" },
            technicalSkills: { type: "number" },
            actionPlan: { type: "string" },
            comments: { type: "string" }
        }
    },
    EXPENSE_CLAIM: {
        type: "object",
        required: ["date", "category", "amount", "description"],
        properties: {
            date: { type: "string" },
            category: { type: "string" },
            amount: { type: "string" },
            description: { type: "string" },
            receiptAttached: { type: "boolean" }
        }
    },
    FEEDBACK: {
        type: "object",
        required: ["visitId", "rating", "careQuality", "professionalism"],
        properties: {
            visitId: { type: "string" },
            rating: { type: "number" },
            careQuality: { type: "number" },
            professionalism: { type: "number" },
            comments: { type: "string" },
            recommend: { type: "boolean" }
        }
    }
};
