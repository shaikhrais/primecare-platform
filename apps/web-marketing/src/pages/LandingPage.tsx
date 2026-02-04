import React from 'react';
import { Link } from 'react-router-dom';
import { MarketingRegistry } from '@primecare/shared';

const { ContentRegistry, RouteRegistry } = MarketingRegistry;

export default function LandingPage() {
    return (
        <div>
            <h1>{ContentRegistry.APP.NAME}</h1>
            <Link to={RouteRegistry.SERVICES}>Services</Link>
        </div>
    );
}
