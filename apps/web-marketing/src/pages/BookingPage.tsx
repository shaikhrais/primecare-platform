import React from 'react';
import { MarketingRegistry } from 'prime-care-shared';
import { Helmet } from 'react-helmet-async';

const { ContentRegistry } = MarketingRegistry;

export default function BookingPage() {
    return (
        <div style={{ padding: '2rem', maxWidth: '800px', margin: '0 auto' }} data-cy="page.container">
            <Helmet>
                <title>{ContentRegistry.BOOKING.TITLE} | {ContentRegistry.APP.NAME}</title>
            </Helmet>

            <h1 style={{ color: '#00897b' }} data-cy="page.title">{ContentRegistry.BOOKING.TITLE}</h1>
            <p className="lead" data-cy="page.header">{ContentRegistry.BOOKING.SUBTITLE}</p>

            <form style={{ display: 'flex', flexDirection: 'column', gap: '1.5rem', marginTop: '2rem' }}>
                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }} data-cy="lbl-name">Full Name</label>
                    <input data-cy="inp-name" type="text" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }} />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Email Address</label>
                    <input data-cy="inp-email" type="email" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }} />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>Phone Number</label>
                    <input data-cy="inp-phone" type="tel" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }} />
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.BOOKING.FORM.SERVICE_TYPE}</label>
                    <select data-cy="sel-service" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}>
                        <option value="">Select a Service...</option>
                        <option value="foot-care">Foot Care</option>
                        <option value="senior-care">Senior Home Care</option>
                        <option value="education">Nurse Education</option>
                        <option value="it-support">IT Support</option>
                    </select>
                </div>

                <div>
                    <label style={{ display: 'block', marginBottom: '0.5rem', fontWeight: 'bold' }}>{ContentRegistry.BOOKING.FORM.URGENCY}</label>
                    <select data-cy="sel-urgency" style={{ width: '100%', padding: '0.75rem', borderRadius: '4px', border: '1px solid #ccc' }}>
                        <option value="immediate">Immediately</option>
                        <option value="week">Within a week</option>
                        <option value="month">Within a month</option>
                        <option value="info">Just researching</option>
                    </select>
                </div>

                <button data-cy="btn-submit-booking" type="submit" className="btn-primary" style={{ padding: '1rem', backgroundColor: '#00897b', color: 'white', border: 'none', borderRadius: '4px', fontSize: '1.1rem', cursor: 'pointer' }}>
                    {ContentRegistry.BOOKING.FORM.SUBMIT_BTN}
                </button>
            </form>
        </div>
    );
}
