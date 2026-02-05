import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import LandingPage from './pages/LandingPage';
import ServicesPage from './pages/ServicesPage';
import AboutPage from './pages/AboutPage';
import BlogPage from './pages/BlogPage';
import BlogPostPage from './pages/BlogPostPage';
import ContactPage from './pages/ContactPage';
import TermsPage from './pages/TermsPage';
import PrivacyPage from './pages/PrivacyPage';
import FootCarePage from './pages/FootCarePage';
import EducationPage from './pages/EducationPage';
import ITSupportPage from './pages/ITSupportPage';
import SeniorCarePage from './pages/SeniorCarePage';
import BookingPage from './pages/BookingPage';
import CareersPage from './pages/CareersPage';
import VolunteerPage from './pages/VolunteerPage';
import FranchisePage from './pages/FranchisePage';
import TestimonialsPage from './pages/TestimonialsPage';
import FAQPage from './pages/FAQPage';
import StaffingPage from './pages/StaffingPage';
import FacilityFootCarePage from './pages/FacilityFootCarePage';
import FootCareCertificatePage from './pages/FootCareCertificatePage';
import PSWTrainingPage from './pages/PSWTrainingPage';
import ConsultingPage from './pages/ConsultingPage';
import LoginPage from './pages/LoginPage';
import CaregiverLoginPage from './pages/CaregiverLoginPage';

const { RouteRegistry } = MarketingRegistry;

import Layout from './components/layout/Layout';

export const routes = [
    {
        path: '/',
        element: <Layout />,
        children: [
            { path: RouteRegistry.HOME, Component: LandingPage },
            { path: RouteRegistry.SERVICES, Component: ServicesPage },
            { path: RouteRegistry.ABOUT, Component: AboutPage },
            { path: RouteRegistry.SERVICE_FOOT_CARE, Component: FootCarePage },
            { path: RouteRegistry.SERVICE_EDUCATION, Component: EducationPage },
            { path: RouteRegistry.SERVICE_IT, Component: ITSupportPage },
            { path: RouteRegistry.SERVICE_SENIOR, Component: SeniorCarePage },
            { path: RouteRegistry.BLOG, Component: BlogPage },
            { path: RouteRegistry.BLOG_DETAIL, Component: BlogPostPage },
            { path: RouteRegistry.CONTACT, Component: ContactPage },
            { path: RouteRegistry.TERMS, Component: TermsPage },
            { path: RouteRegistry.PRIVACY, Component: PrivacyPage },
            { path: RouteRegistry.CAREERS, Component: CareersPage },
            { path: RouteRegistry.BOOKING, Component: BookingPage },
            // New pages
            { path: '/volunteer', Component: VolunteerPage },
            { path: '/franchise', Component: FranchisePage },
            { path: '/testimonials', Component: TestimonialsPage },
            { path: '/faq', Component: FAQPage },
            { path: '/services/staffing', Component: StaffingPage },
            { path: '/services/facility-foot-care', Component: FacilityFootCarePage },
            { path: '/education/foot-care-certificate', Component: FootCareCertificatePage },
            { path: '/education/psw-training', Component: PSWTrainingPage },
            { path: '/consulting', Component: ConsultingPage },
            { path: '/login', Component: LoginPage },
            { path: '/caregiver-login', Component: CaregiverLoginPage },
            { path: "*", Component: LandingPage },
        ]
    }
];
