// ================================================================
// PAGE IDENTITY: T20 � Daily Entry
// Type: Tool | Owner: manager
// ================================================================
import { AdminRegistry } from 'prime-care-shared';
import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { useNotification } from '@/shared/context/NotificationContext';

// Components
import { DailyEntryGuard } from './components/DailyEntryGuard';
import { DailyEntryContext } from './components/DailyEntryContext';
import { ADLChecklist } from './components/ADLChecklist';
import { VitalsAndWellness } from './components/VitalsAndWellness';
import { NotesAndSignature } from './components/NotesAndSignature';

const { ContentRegistry, RouteRegistry } = AdminRegistry;

export default function DailyEntryPage() {
    const navigate = useNavigate();
    const { showToast } = useNotification();

    // State
    const [clients, setClients] = useState<any[]>([]);
    const [selectedClient, setSelectedClient] = useState<string>('');
    const [visitId, setVisitId] = useState<string>('');

    const [adl, setAdl] = useState({
        bathing: false,
        dressing: false,
        feeding: false,
        toileting: false,
        mobility: false
    });
    const [meds, setMeds] = useState({ given: false, notes: '' });
    const [mood, setMood] = useState<number>(3);
    const [vitals, setVitals] = useState({ bp: '', pulse: '', temp: '' });
    const [notes, setNotes] = useState('');
    const [signature, setSignature] = useState('');
    const [submitting, setSubmitting] = useState(false);
    const [isDirty, setIsDirty] = useState(false);
    const [showGuard, setShowGuard] = useState(false);

    // Unsaved changes guard (Native)
    useEffect(() => {
        const handleBeforeUnload = (e: BeforeUnloadEvent) => {
            if (isDirty) {
                e.preventDefault();
                e.returnValue = '';
            }
        };
        window.addEventListener('beforeunload', handleBeforeUnload);
        return () => window.removeEventListener('beforeunload', handleBeforeUnload);
    }, [isDirty]);

    const fetchClients = async () => {
        const token = localStorage.getItem('token');
        const res = await fetch(`${import.meta.env.VITE_API_URL}/v1/staff/customers`, {
            headers: { 'Authorization': `Bearer ${token}` }
        });
        if (res.ok) {
            const data = await res.json();
            setClients(data);
            if (data.length > 0 && !selectedClient) setSelectedClient(data[0].id);
        }
    };

    useEffect(() => {
        fetchClients();
    }, []);

    const handleSubmit = async (isDraft: boolean) => {
        if (!selectedClient) return showToast(ContentRegistry.DAILY_ENTRY.MESSAGES.SELECT_CLIENT, 'error');
        if (!isDraft && !signature) return showToast(ContentRegistry.DAILY_ENTRY.MESSAGES.SIGNATURE_REQUIRED, 'error');

        setSubmitting(true);
        try {
            const token = localStorage.getItem('token');
            const endpoint = isDraft ? '/v1/daily-entry/draft' : '/v1/daily-entry';

            const res = await fetch(`${import.meta.env.VITE_API_URL}${endpoint}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    clientId: selectedClient,
                    visitId: visitId || undefined,
                    adlData: adl,
                    medication: meds,
                    mood,
                    vitals,
                    notes,
                    signature,
                    status: isDraft ? 'DRAFT' : 'SUBMITTED'
                })
            });

            if (res.ok) {
                showToast(isDraft ? ContentRegistry.DAILY_ENTRY.MESSAGES.SUCCESS_DRAFT : ContentRegistry.DAILY_ENTRY.MESSAGES.SUCCESS_SUBMIT, 'success');
                if (!isDraft) navigate(RouteRegistry.MANAGER.DASHBOARD);
            } else {
                showToast(ContentRegistry.DAILY_ENTRY.MESSAGES.ERROR_SAVE, 'error');
            }
        } catch (error) {
            console.error('Submit error', error);
            showToast(ContentRegistry.DAILY_ENTRY.MESSAGES.ERROR_SERVER, 'error');
        } finally {
            setSubmitting(false);
        }
    };

    return (
        <div data-cy="page.container" role="main" aria-label="Daily Entry" style={{ display: 'flex', height: 'calc(100vh - 100px)', gap: '24px' }} data-cy="form.daily.page">
            <DailyEntryGuard showGuard={showGuard} setShowGuard={setShowGuard} />

            <DailyEntryContext
                clients={clients}
                selectedClient={selectedClient}
                setSelectedClient={setSelectedClient}
                setIsDirty={setIsDirty}
                onRefreshClients={fetchClients}
            />

            <div style={{ flex: 1, background: 'var(--bg-elev)', padding: '32px', borderRadius: '16px', border: '1px solid var(--line)', overflowY: 'auto' }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '32px' }} data-cy="page.header">
                    <h1 className="display-text" style={{ fontSize: '2rem', margin: 0 }} data-cy="page.title">{ContentRegistry.DAILY_ENTRY.TITLE}</h1>
                    <div style={{ fontSize: '0.9rem', opacity: 0.6 }} data-cy="page.subtitle">{new Date().toLocaleDateString()}</div>
                </div>

                <div style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(300px, 1fr))', gap: '32px' }}>
                    <ADLChecklist adl={adl} setAdl={setAdl} setIsDirty={setIsDirty} />
                    <VitalsAndWellness vitals={vitals} setVitals={setVitals} mood={mood} setMood={setMood} setIsDirty={setIsDirty} />
                </div>

                <NotesAndSignature
                    notes={notes}
                    setNotes={setNotes}
                    signature={signature}
                    setSignature={setSignature}
                    setIsDirty={setIsDirty}
                    handleSubmit={handleSubmit}
                    submitting={submitting}
                />
            </div>
        </div>
    );
}
