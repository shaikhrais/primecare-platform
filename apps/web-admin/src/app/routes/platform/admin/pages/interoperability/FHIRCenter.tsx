import React, { useState } from 'react';
import { AdminRegistry } from 'prime-care-shared';

const { ButtonRegistry } = AdminRegistry;

export default function FHIRCenter() {
    const [json, setJson] = useState<string | null>(null);
    const [logs] = useState([
        { id: '1', type: 'Patient', direction: 'OUTBOUND', status: 'SUCCESS', time: '2 mins ago' },
        { id: '2', type: 'Observation', direction: 'INBOUND', status: 'SUCCESS', time: '1 hour ago' },
        { id: '3', type: 'Medication', direction: 'OUTBOUND', status: 'FAILURE', error: 'Invalid Dosage Format', time: '3 hours ago' },
    ]);

    const generateFHIRRecord = () => {
        const mockFHIR = {
            resourceType: "Patient",
            id: "pc-client-123",
            active: true,
            name: [{ use: "official", family: "Smith", given: ["John"] }],
            gender: "male",
            birthDate: "1955-05-12",
            managingOrganization: { display: "PrimeCare North Tenant" },
            extension: [{ url: "http://primecare.ca/fhir/StructureDefinition/last-audit-score", valueDecimal: 98.2 }]
        };
        setJson(JSON.stringify(mockFHIR, null, 2));
    };

    return (
        <div style={{ padding: '2rem' }}>
            <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '2rem' }}>
                <div>
                    <h1 style={{ fontSize: '1.875rem', fontWeight: 'bold' }}>Interoperability & FHIR</h1>
                    <p style={{ color: '#6b7280' }}>HL7 FHIR R4 clinical data exchange gateway.</p>
                </div>
                <div style={{ backgroundColor: '#ecfdf5', color: '#059669', padding: '0.5rem 1rem', borderRadius: '1rem', fontSize: '0.75rem', fontWeight: 'bold' }}>
                    FHIR R4 COMPLIANT
                </div>
            </div>

            <div style={{ display: 'grid', gridTemplateColumns: '1.5fr 1fr', gap: '2rem' }}>
                <div className="pc-card">
                    <div className="pc-card-h">Visual Record Generator</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'flex', gap: '1rem', marginBottom: '1.5rem' }}>
                            <select style={{ flex: 1, padding: '0.75rem', borderRadius: '0.5rem', border: '1px solid #e5e7eb' }}>
                                <option>Select Patient Record...</option>
                                <option>John Smith (pc-123)</option>
                            </select>
                            <button
                                className="btn primary"
                                onClick={generateFHIRRecord}
                                data-cy="btn-adm-fhir-export"
                            >
                                {ButtonRegistry.find((b: any) => b.id === 'btn-adm-fhir-export')?.label || 'Export FHIR Record'}
                            </button>
                        </div>
                        {json && (
                            <pre style={{ backgroundColor: '#111827', color: '#10b981', padding: '1.5rem', borderRadius: '0.5rem', overflow: 'auto', maxHeight: '300px', fontSize: '0.875rem' }}>
                                {json}
                            </pre>
                        )}
                    </div>
                </div>

                <div className="pc-card">
                    <div className="pc-card-h">Live Sync Stream</div>
                    <div className="pc-card-b">
                        <div style={{ display: 'grid', gap: '1rem' }}>
                            {logs.map(log => (
                                <div key={log.id} style={{ display: 'flex', justifyContent: 'space-between', padding: '1rem', background: '#f9fafb', borderRadius: '0.5rem' }}>
                                    <div>
                                        <div style={{ fontWeight: 'bold', fontSize: '0.875rem' }}>{log.type}</div>
                                        <div style={{ fontSize: '0.75rem', color: '#6b7280' }}>{log.direction} • {log.time}</div>
                                    </div>
                                    <span style={{ color: log.status === 'SUCCESS' ? '#059669' : '#ef4444', fontSize: '0.75rem', fontWeight: 'bold' }}>
                                        {log.status}
                                    </span>
                                </div>
                            ))}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
}
