import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Link } from 'react-router-dom';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function FootCarePage() {
    return (
        <div style={{ padding: '2rem' }} data-cy="foot-care-page">
            <Helmet>
                <title>{ContentRegistry.SERVICES.FOOT_CARE.TITLE} | {ContentRegistry.APP.NAME}</title>
                <meta name="description" content={ContentRegistry.SERVICES.FOOT_CARE.DESCRIPTION} />
            </Helmet>
            <h1>{ContentRegistry.SERVICES.FOOT_CARE.TITLE}</h1>
            <p className="lead">{ContentRegistry.SERVICES.FOOT_CARE.DESCRIPTION}</p>
            <ul>
                <li>Diabetic Foot Care</li>
                <li>Corn & Callus Removal</li>
                <li>Fungal Infection Treatment</li>
                <li>Ingrown Toenail Management</li>
            </ul>
            <Link to={RouteRegistry.BOOKING} data-cy="btn-foot-care-booking" className="btn-primary">Book Appointment</Link>
            <br /><br />
            <Link to={RouteRegistry.SERVICES} data-cy="btn-back-to-services">Back to Services</Link>
        </div>
    );
}
