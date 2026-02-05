import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry } = MarketingRegistry;

export default function CareersPage() {
    return (
        <div style={{ padding: '2rem', maxWidth: '800px', margin: '0 auto' }}>
            <Helmet>
                <title>{ContentRegistry.CAREERS.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#004d40' }}>{ContentRegistry.CAREERS.TITLE}</h1>
            <p className="lead">{ContentRegistry.CAREERS.SUBTITLE}</p>

            <div style={{ backgroundColor: '#f5f5f5', padding: '1.5rem', borderRadius: '8px', marginBottom: '2rem' }}>
                <h3>Why join {ContentRegistry.APP.NAME}?</h3>
                <ul style={{ paddingLeft: '1.5rem', marginTop: '0.5rem' }}>
                    <li>Competitive Pay</li>
                    <li>Flexible Scheduling</li>
                    <li>Professional Development</li>
                    <li>Supportive Team Environment</li>
                </ul>
            </div>

            <form style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem' }}>
                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Full Name</label>
                    <input type="text" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }} />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Email Address</label>
                    <input type="email" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }} />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.CAREERS.FORM.POSITION}</label>
                    <select style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}>
                        <option value="psw">Personal Support Worker (PSW)</option>
                        <option value="rpn">Registered Practical Nurse (RPN)</option>
                        <option value="rn">Registered Nurse (RN)</option>
                        <option value="admin">Administrative Staff</option>
                    </select>
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.CAREERS.FORM.RESUME}</label>
                    <input type="file" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc', backgroundColor: 'white' }} />
                </div>

                <button type="submit" className="btn-primary" style={{ padding: '1rem', backgroundColor: '#004d40', color: 'white', border: 'none', borderRadius: '4px', fontSize: '1.1rem', cursor: 'pointer' }}>
                    {ContentRegistry.CAREERS.FORM.APPLY_BTN}
                </button>
            </form>
        </div>
    );
}
