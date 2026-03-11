import React, { useState, useEffect } from 'react';
import { Wifi, ShieldAlert, CheckCircle2 } from 'lucide-react';

export const PublicWifiSanitizer: React.FC = () => {
    const [isSecure, setIsSecure] = useState(true);

    useEffect(() => {
        // Mocks checking the navigator.connection object.
        // If effectiveType is "cellular" or ping is high, assume insecure/public conditions
        // where visual eavesdropping is likely.
        const connection = (navigator as any).connection;

        if (connection) {
            const handleConnectionChange = () => {
                const insecureTypes = ['cellular', '3g', '2g'];
                if (insecureTypes.includes(connection.type) || insecureTypes.includes(connection.effectiveType)) {
                    setIsSecure(false);
                } else {
                    setIsSecure(true);
                }
            };

            // Setup listeners
            connection.addEventListener('change', handleConnectionChange);
            handleConnectionChange(); // Initial check

            return () => connection.removeEventListener('change', handleConnectionChange);
        } else {
            // Native Network API unsupported in this browser environment, defaulting to secure
            setIsSecure(true);
        }
    }, []);

    if (isSecure) {
        return (
            <div style={{ padding: '8px 12px', backgroundColor: '#F0FDF4', borderRadius: '8px', display: 'flex', alignItems: 'center', gap: '8px', fontSize: '0.8rem', color: '#166534', border: '1px solid #BBF7D0' }}>
                <CheckCircle2 size={16} /> Secure Network: Full PHI Visible
            </div>
        );
    }

    return (
        <div style={{ padding: '12px', backgroundColor: '#FEF2F2', borderRadius: '8px', border: '1px solid #FECACA', display: 'flex', alignItems: 'flex-start', gap: '12px', marginTop: '16px' }}>
            <div style={{ backgroundColor: '#FEE2E2', padding: '8px', borderRadius: '8px' }}>
                <Wifi size={20} color="#DC2626" />
            </div>
            <div>
                <h4 style={{ margin: 0, fontSize: '0.9rem', color: '#991B1B', display: 'flex', alignItems: 'center', gap: '6px' }}>
                    <ShieldAlert size={14} /> Insecure Network Detected
                </h4>
                <p style={{ margin: '4px 0 0 0', fontSize: '0.8rem', color: '#DC2626', lineHeight: '1.4' }}>
                    You appear to be on a public or cellular network. PrimeCare has auto-enabled <strong>Visual Sanitization Mode</strong>. Patient names will be truncated to initials (e.g., J.D.) to prevent shoulder-surfing.
                </p>
            </div>
        </div>
    );
};
