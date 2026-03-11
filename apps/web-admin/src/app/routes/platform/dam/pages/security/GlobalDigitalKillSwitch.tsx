import React, { useState } from 'react';
import { Skull, AlertTriangle, ShieldAlert, WifiOff, Power, Database, Users } from 'lucide-react';

export const GlobalDigitalKillSwitch: React.FC = () => {
    const [isArmed, setIsArmed] = useState(false);
    const [isEngaging, setIsEngaging] = useState(false);
    const [killSwitchActive, setKillSwitchActive] = useState(false);
    const [countdown, setCountdown] = useState(10);
    const [pin, setPin] = useState('');

    const toggleArm = () => {
        if (killSwitchActive) return; // Cannot disarm easily once fired
        setIsArmed(!isArmed);
        setPin('');
    };

    const handleFire = () => {
        if (pin !== '1984') {
            alert("Invalid Executive Override PIN.");
            return;
        }
        
        setIsEngaging(true);
        
        let timer = 10;
        const interval = setInterval(() => {
            timer -= 1;
            setCountdown(timer);
            
            if (timer <= 0) {
                clearInterval(interval);
                setIsEngaging(false);
                setKillSwitchActive(true);
                alert("CRITICAL SECURITY PROTOCOL ENGAGED.\n\nAll external connections severed. Client devices force-disconnected. PostgreSQL database connections destroyed.\n\nApplication is now in STATIC MODE.");
            }
        }, 1000);
    };

    const handleReset = () => {
        if (window.confirm("Are you absolutely sure you want to attempt platform reboot? This requires full cloud-provider redeployment verification.")) {
            setIsArmed(false);
            setKillSwitchActive(false);
            setCountdown(10);
            setPin('');
            alert("Digital kill switch disengaged. Re-establishing network proxies and DNS routing...");
        }
    };

    return (
        <div style={{ backgroundColor: '#0F172A', border: '1px solid #334155', borderRadius: '12px', padding: '32px', marginTop: '32px', color: 'white', position: 'relative', overflow: 'hidden' }}>
            {killSwitchActive && (
                <div style={{ position: 'absolute', top: 0, left: 0, right: 0, bottom: 0, backgroundColor: 'rgba(2dc, 38, 38, 0.1)', zIndex: 0, pointerEvents: 'none', display: 'flex', flexDirection: 'column', alignItems: 'center', justifyContent: 'center' }}>
                    <div style={{ fontSize: '12rem', color: 'rgba(220, 38, 38, 0.15)', fontWeight: 900, fontFamily: 'monospace', letterSpacing: '10px' }}>STATIC</div>
                </div>
            )}

            <div style={{ position: 'relative', zIndex: 1 }}>
                <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'flex-start', marginBottom: '32px' }}>
                    <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
                        <div style={{ backgroundColor: killSwitchActive ? '#DC2626' : '#1E293B', padding: '16px', borderRadius: '12px', border: `2px solid ${killSwitchActive ? '#B91C1C' : '#334155'}`, transition: 'all 0.3s' }}>
                            <Skull size={32} color={killSwitchActive ? 'white' : '#94A3B8'} className={killSwitchActive ? "animate-pulse" : ""} />
                        </div>
                        <div>
                            <h3 style={{ margin: 0, fontSize: '1.6rem', color: killSwitchActive ? '#EF4444' : '#F8FAFC', fontWeight: 900, letterSpacing: '1px' }}>GLOBAL DIGITAL KILL SWITCH</h3>
                            <p style={{ margin: '4px 0 0 0', color: '#94A3B8', fontSize: '0.95rem' }}>Extreme Emergency Override Protocol (EEOP)</p>
                        </div>
                    </div>

                    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'flex-end', gap: '8px' }}>
                        <div style={{ display: 'flex', alignItems: 'center', gap: '8px', padding: '6px 16px', backgroundColor: killSwitchActive ? '#FEF2F2' : '#F0FDF4', color: killSwitchActive ? '#DC2626' : '#16A34A', borderRadius: '6px', fontWeight: 800, fontSize: '0.8rem', fontFamily: 'monospace' }}>
                            <Activity size={16} /> 
                            STATUS: {killSwitchActive ? 'SEVERED (STATIC MODE)' : 'ONLINE & ROUTING'}
                        </div>
                        <div style={{ fontSize: '0.75rem', color: '#64748B', fontFamily: 'monospace' }}>AUTH: EXECUTIVE DIRECTIVE ONLY</div>
                    </div>
                </div>

                {!killSwitchActive ? (
                    <div style={{ display: 'flex', gap: '24px' }}>
                        <div style={{ flex: 1, backgroundColor: '#1E293B', borderRadius: '12px', border: '1px solid #334155', padding: '24px' }}>
                            <h4 style={{ margin: '0 0 16px 0', fontSize: '1rem', color: '#E2E8F0', display: 'flex', alignItems: 'center', gap: '8px' }}>
                                <AlertTriangle size={18} color="#F59E0B" /> Firing Procedure
                            </h4>
                            <p style={{ fontSize: '0.9rem', color: '#CBD5E1', lineHeight: 1.6, marginTop: 0 }}>
                                Firing the kill switch will instantly modify the Cloudflare Edge Worker routing tables. All active websocket connections will be severed. All authenticated JWTs will be invalidated locally.
                            </p>
                            <p style={{ fontSize: '0.9rem', color: '#CBD5E1', lineHeight: 1.6 }}>
                                <strong>Impact:</strong> The entire PrimeCare domain will instantly revert to a static HTML payload reading "Undergoing Emergency Maintenance." No backend APIs will be reachable.
                            </p>

                            <div style={{ display: 'flex', alignItems: 'center', gap: '16px', marginTop: '32px', borderTop: '1px solid #334155', paddingTop: '24px' }}>
                                <button 
                                    onClick={toggleArm}
                                    style={{ 
                                        backgroundColor: isArmed ? '#F59E0B' : '#334155', 
                                        color: isArmed ? '#78350F' : '#F8FAFC', 
                                        border: 'none', borderRadius: '8px', padding: '12px 24px', fontWeight: 800, cursor: 'pointer', transition: 'all 0.2s'
                                    }}
                                >
                                    {isArmed ? 'DISARM PROTOCOL' : 'ARM SAFETY COVER'}
                                </button>

                                {isArmed && (
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
                                        <input 
                                            type="password" 
                                            value={pin}
                                            onChange={(e) => setPin(e.target.value)}
                                            placeholder="Enter Executive PIN" 
                                            maxLength={4}
                                            style={{ padding: '12px', borderRadius: '8px', border: '1px solid #DC2626', backgroundColor: '#450A0A', color: '#FECACA', outline: 'none', width: '160px', fontFamily: 'monospace', fontSize: '1.1rem', letterSpacing: '4px', textAlign: 'center' }}
                                        />
                                        <button 
                                            onClick={handleFire}
                                            disabled={isEngaging}
                                            style={{ 
                                                backgroundColor: '#DC2626', color: 'white', border: 'none', borderRadius: '8px', padding: '12px 32px', fontWeight: 900, cursor: isEngaging ? 'not-allowed' : 'pointer', fontSize: '1.1rem', letterSpacing: '1px', display: 'flex', alignItems: 'center', gap: '8px', boxShadow: '0 0 20px rgba(220, 38, 38, 0.4)'
                                            }}
                                        >
                                            <Power size={20} /> {isEngaging ? `FIRING (${countdown})` : 'FIRE'}
                                        </button>
                                    </div>
                                )}
                            </div>
                            
                            {isEngaging && (
                                <div style={{ marginTop: '16px', backgroundColor: '#450A0A', color: '#FECACA', padding: '12px', borderRadius: '8px', fontFamily: 'monospace', fontSize: '0.85rem', border: '1px solid #DC2626' }}>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}><WifiOff size={14} /> Severing DNS Routes...</div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px', marginBottom: '8px' }}><Users size={14} /> Invalidating Active User Sessions...</div>
                                    <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}><Database size={14} /> Destroying DB Connection Pools...</div>
                                </div>
                            )}
                        </div>

                        <div style={{ width: '300px', backgroundColor: '#1E293B', borderRadius: '12px', border: '1px solid #334155', padding: '24px', display: 'flex', flexDirection: 'column' }}>
                             <div style={{ display: 'flex', alignItems: 'center', gap: '8px', fontWeight: 800, marginBottom: '16px', color: '#94A3B8' }}>
                                <ShieldAlert size={18} /> Justification
                            </div>
                            <p style={{ fontSize: '0.85rem', color: '#CBD5E1', lineHeight: 1.6, marginTop: 0 }}>
                                Useful for mitigating catastrophic zero-day vulnerabilities, active aggressive ransomware encryption originating from a compromised endpoint, or severe infrastructure cascading failures.
                            </p>
                        </div>
                    </div>
                ) : (
                    <div style={{ backgroundColor: '#450A0A', border: '2px dashed #DC2626', borderRadius: '12px', padding: '32px', textAlign: 'center' }}>
                        <ShieldAlert size={64} color="#EF4444" style={{ marginBottom: '16px' }} />
                        <h2 style={{ color: '#FECACA', margin: '0 0 16px 0', fontSize: '1.8rem', letterSpacing: '2px' }}>SYSTEM SEVERED</h2>
                        <p style={{ color: '#F81144', fontSize: '1.1rem', maxWidth: '600px', margin: '0 auto 32px auto', lineHeight: 1.6 }}>
                            All inbound HTTP traffic is currently returning a static HTTP 503 Maintenance Mode payload. All PostgreSQL and Redis connections have been destroyed.
                        </p>
                        
                        <button 
                            onClick={handleReset}
                            style={{ backgroundColor: '#1E293B', color: '#E2E8F0', border: '1px solid #334155', borderRadius: '8px', padding: '12px 24px', fontWeight: 700, cursor: 'pointer', display: 'inline-flex', alignItems: 'center', gap: '8px' }}
                        >
                            <RefreshCw size={16} /> ATTEMPT SYSTEM REBOOT
                        </button>
                    </div>
                )}
            </div>
        </div>
    );
};
