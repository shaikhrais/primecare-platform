export const ContentRegistry = {
    APP: {
        NAME: 'PrimeCare Health Services',
        TAGLINE: 'Comprehensive Health & Support Solutions',
    },
    HERO: {
        TITLE: 'Excellence in Healthcare, Delivered to You',
        SUBTITLE: 'PrimeCare Health Services is a premier nursing agency dedicated to providing compassionate, high-quality care. From specialized foot care to senior support and nurse education, our certified professionals bring hospital-grade services directly to your doorstep.',
        CTA_PRIMARY: 'Book a Consultation',
        CTA_SECONDARY: 'Our Services',
    },
    ABOUT: {
        MISSION: 'Our Mission',
        MISSION_TEXT: 'To empower individuals and communities by delivering accessible, exceptional healthcare services that promote dignity, independence, and well-being.',
        VALUES: 'Our Values',
        VALUES_LIST: [
            { title: 'Compassion', text: 'We treat every client with kindness, respect, and empathy.' },
            { title: 'Excellence', text: 'We adhere to the highest standards of nursing and clinical practice.' },
            { title: 'Integrity', text: 'We operate with transparency, honesty, and accountability.' },
            { title: 'Innovation', text: 'We embrace new technologies and methods to improve care delivery.' }
        ]
    },
    SERVICES: {
        TITLE: 'Comprehensive Health Services',
        SUBTITLE: 'We offer a wide range of specialized health and support services tailored to meet the unique needs of our community.',
        FOOT_CARE: {
            TITLE: 'Advanced Foot Care',
            DESCRIPTION: 'Our specialized nursing foot care program is designed to maintain mobility and prevent complications. We treat corns, calluses, diabetic feet, and fungal infections using sterile, hospital-grade tools. Regular foot care is essential for seniors and those with diabetes.',
        },
        EDUCATION: {
            TITLE: 'Nurse Education & Workshops',
            DESCRIPTION: 'We are committed to the continuous professional development of healthcare providers. Our workshops cover Wound Care, Infusion Therapy, and Patient Safety, empowering nurses to deliver the best possible care.',
        },
        IT_SUPPORT: {
            TITLE: 'Health Tech & IT Support',
            DESCRIPTION: 'Navigating the digital health landscape can be challenging. Our IT support team helps clinics and individuals with EMR setup, secure communication tools, and telehealth configuration, bridging the gap between care and technology.',
        },
        SENIOR_CARE: {
            TITLE: 'Senior Home Care & Companionship',
            DESCRIPTION: 'Our compassionate PSWs provide assistance with daily living activities, medication reminders, and companionship, allowing loved ones to age gracefully and safely in the comfort of their own homes.',
        }
    },
    WHY_CHOOSE_US: {
        TITLE: 'Why Choose PrimeCare?',
        POINTS: [
            { title: 'Certified Professionals', text: 'All our PSWs and Nurses are fully licensed, vetted, and background-checked.' },
            { title: 'Patient-Centered Approach', text: 'We tailor our care plans to your specific needs and preferences.' },
            { title: 'Accessible Care', text: 'We bring our services to you—whether at home, in a facility, or virtually.' },
            { title: 'Trusted Expertise', text: 'Years of experience in clinical and community nursing underpin everything we do.' }
        ]
    },
    BLOG: {
        TITLE: 'Health Hub Blog',
        SUBTITLE: 'Insights, tips, and news from our team of healthcare experts.',
    },
    CONTACT: {
        TITLE: 'Get in Touch',
        SUBTITLE: 'Have questions? We are here to help. Reach out to us for enquiries or to book a service.',
        FORM: {
            NAME: 'Full Name',
            EMAIL: 'Email Address',
            MESSAGE: 'How can we help you?',
            SUBMIT: 'Send Message',
        }
    },
    LEGAL: {
        TERMS_TITLE: 'Terms and Conditions',
        PRIVACY_TITLE: 'Privacy Policy',
    },
    CAREERS: {
        TITLE: 'Careers at PrimeCare',
        SUBTITLE: 'Join a team that values your skills and passion. We are always looking for dedicated PSWs and Nurses to grow with us.',
        FORM: {
            POSITION: 'Position Applying For',
            RESUME: 'Upload Resume (PDF/Word)',
            APPLY_BTN: 'Submit Application',
        }
    },
    BOOKING: {
        TITLE: 'Request a Service',
        SUBTITLE: 'Tell us about your care needs. Our intake team will review your request and get back to you within 24 hours with a personalized quote.',
        FORM: {
            SERVICE_TYPE: 'Type of Service',
            URGENCY: 'When do you need care?',
            SUBMIT_BTN: 'Request Quote',
        }
    }
} as const;
