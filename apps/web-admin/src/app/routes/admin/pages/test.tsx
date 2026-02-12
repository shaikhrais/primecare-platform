import React from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ContentRegistry } = AdminRegistry;

export default function TestPage() {
    return (
        <div>
            <h1>Test Page</h1>
            <p>Title from Registry: {ContentRegistry.USERS.TITLE}</p>
        </div>
    );
}
