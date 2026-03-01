import React, { useState } from 'react';

export default function FHIRCenter() {
    const [json, setJson] = useState<string | null>(null);

    const generateFHIRRecord = () => {
        const mockFHIR = {
            resourceType: "Patient",
            id: "pc-client-123",
            active: true,
            name: [{ use: "official", family: "Smith", given: ["John"] }],
            gender: "male",
            birthDate: "1955-05-12",
            managingOrganization: {
                display: "PrimeCare North Tenant"
            },
            extension: [
                {
                    url: "http://primecare.ca/fhir/StructureDefinition/last-audit-score",
                    valueDecimal: 98.2
                }
            ]
        };
        setJson(JSON.stringify(mockFHIR, null, 2));
    };

    return (
        <div style={{ padding: '24px', maxWidth: '1000px', margin: '0 auto' }}>
            <div style={{ marginBottom: '32px', display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start' }}>
                <div>
                    <h1 style={{ fontSize: '28px', fontWeight: '800', marginBottom: '8px' }}>Interoperability & FHIR</h1>
                    <p style={{ color: '#6B7280' }}>Export clinical records in standard HL7/FHIR formats for hospital integration.</p>
                </div>
                <div style={{ backgroundColor: '#EEF2FF', color: '#4F46E5', padding: '8px 16px', borderRadius: '20px', fontSize: '12px', fontWeight: '700' }}>
                    HL7 FHIR R4 Compliant
                </div>
            </div>

            <div className="pc-card">
                <div className="pc-card-h">Export Patient Record</div>
                <div className="pc-card-b">
                    <div style={{ display: 'flex', gap: '16px', marginBottom: '24px' }}>
                        <select style={{ flex: 1, padding: '12px', borderRadius: '8px', border: '1px solid var(--line)' }}>
                            <option>Select Client...</option>
                            <option>John Smith (pc-123)</option>
                            <option>Alice Cooper (pc-456)</option>
                        </select>
                        <button className="btn btn-primary" onClick={generateFHIRRecord}>Generate FHIR JSON</button>
                    </div>

                    {json && (
                        <div>
                            <div style={{ display: 'flex', justifyContent: 'space-between', marginBottom: '8px' }}>
                                <span style={{ fontSize: '13px', color: '#6B7280', fontWeight: '600' }}>Preview (application/fhir+json)</span>
                                <button className="btn" style={{ fontSize: '12px', padding: '4px 8px' }} onClick={() => navigator.clipboard.writeText(json)}>Copy to Clipboard</button>
                            </div>
                            <pre style={{
                                backgroundColor: '#111827',
                                color: '#10B981',
                                padding: '20px',
                                borderRadius: '8px',
                                overflowX: 'auto',
                                fontSize: '13px',
                                fontFamily: 'monospace',
                                maxHeight: '400px'
                            }}>
                                {json}
                            </pre>
                        </div>
                    )}
                </div>
            </div>

            <div style={{ marginTop: '32px', display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '24px' }}>
                <div className="pc-card">
                    <div className="pc-card-h">Bidirectional Sync Status</div>
                    <div className="pc-card-b" style={{ textAlign: 'center', padding: '40px' }}>
                        <div style={{ fontSize: '24px', marginBottom: '8px' }}>🔗</div>
                        <p style={{ fontWeight: '600' }}>No Active Hospital Links</p>
                        <p style={{ fontSize: '14px', color: '#6B7280' }}>Connect your agency to local EMR systems via HL7 v2 or FHIR.</p>
                        <button className="btn" style={{ marginTop: '16px' }}>Configure Hospital Link</button>
                    </div>
                </div>
                <div className="pc-card" style={{ background: 'linear-gradient(135deg, #4F46E5 0%, #7C3AED 100%)', color: 'white' }}>
                    <div className="pc-card-h" style={{ borderBottom: '1px solid rgba(255,255,255,0.2)' }}>Upcoming: Phase 8</div>
                    <div className="pc-card-b">
                        <h3 style={{ fontWeight: '800', marginBottom: '12px' }}>The Sovereign Health Web</h3>
                        <p style={{ fontSize: '14px', opacity: 0.9 }}>Preparing for decentralized identity (DID) and peer-to-peer clinical data sharing between agencies without central relays.</p>
                    </div>
                </div>
            </div>
        </div>
    );
}
