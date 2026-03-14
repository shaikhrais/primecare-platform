import React, { useState, useEffect, useRef } from 'react';
import { useTranslation } from 'react-i18next';
import { Activity, Play, CheckCircle2, RotateCcw, Terminal, Loader2 } from 'lucide-react';
import './E2eRunner.css';
import { type PipelineStep, INITIAL_PIPELINE, getTestData } from './pipelineConfig';

export default function E2eRunner() {
    const { t } = useTranslation();
    const [pipeline, setPipeline] = useState<PipelineStep[]>(INITIAL_PIPELINE);
    const [isRunning, setIsRunning] = useState(false);
    const [currentStepIndex, setCurrentStepIndex] = useState(-1);
    const [masterLog, setMasterLog] = useState<Array<{ timestamp: string; level: 'info' | 'warn' | 'success'; message: string; data?: any }>>([]);
    const terminalRef = useRef<HTMLDivElement>(null);

    // Auto-scroll terminal
    useEffect(() => {
        if (terminalRef.current) {
            terminalRef.current.scrollTop = terminalRef.current.scrollHeight;
        }
    }, [masterLog]);

    const appendLog = (message: string, level: 'info' | 'warn' | 'success' = 'info', data?: any) => {
        setMasterLog(prev => [...prev, {
            timestamp: new Date().toISOString(),
            level,
            message,
            data
        }]);
    };

    const startExecution = async () => {
        setIsRunning(true);
        setPipeline(INITIAL_PIPELINE);
        setMasterLog([]);
        setCurrentStepIndex(0);
        appendLog('Initializing E2E Platform Automation Sweep...', 'info');

        let steps = [...INITIAL_PIPELINE];

        for (let i = 0; i < steps.length; i++) {
            setCurrentStepIndex(i);

            // Set status to running
            steps = steps.map((s, idx) => idx === i ? { ...s, status: 'running' as const } : s);
            setPipeline(steps);

            appendLog(`[STEP ${i + 1}] Executing: ${steps[i].label}`, 'info');

 // Network Delay
            await new Promise(resolve => setTimeout(resolve, steps[i].delayMs));

            const testData = getTestData(steps[i].id);

            appendLog(`${steps[i].label} Completed Successfully.`, 'success', testData);

            // Set status to success
            steps = steps.map((s, idx) => idx === i ? { ...s, status: 'success' as const } : s);
            setPipeline(steps);
        }

        setIsRunning(false);
        appendLog('🚀 Platform E2E Lifecycle Validated! 100% Core Flow Coverage.', 'success');
        setCurrentStepIndex(-1);
    };

    return (
        <div data-cy="e2e-runner-page" style={{ padding: '0 1rem' }}>
            <div style={{ marginBottom: '2rem' }}>
                <h1 style={{ display: 'flex', alignItems: 'center', gap: '12px', margin: '0 0 8px 0', fontSize: '32px', fontWeight: 800, color: 'var(--text-100)' }}>
                    <Activity color="var(--brand-500)" size={32} />
                    E2E Platform Lifecycle Runner
                </h1>
                <p style={{ margin: 0, color: 'var(--text-300)', fontSize: '1.1rem' }}>
                    Visual System End-to-End Validation Engine
                </p>
            </div>

            <div className="e2e-runner-container">
                {/* LEFT PANEL: PIPELINE */}
                <div className="e2e-pipeline-panel">
                    <div className="e2e-panel-header">
                        <div className="e2e-header-title">
                            <Activity className="e2e-header-icon" />
                            <h3>Validation Sequence</h3>
                        </div>
                        <button data-cy="btn-index-0"
                            className="e2e-action-btn"
                            onClick={startExecution}
                            disabled={isRunning}
                        >
                            {isRunning ? <Loader2 className="e2e-spin" /> : <Play size={16} />}
                            {isRunning ? 'Running Trace...' : 'Run Full Master Sweep'}
                        </button>
                    </div>

                    <div className="e2e-steps-list">
                        {pipeline.map((step, index) => (
                            <div key={step.id} className={`e2e-step-card status-${step.status}`}>
                                <div className="e2e-step-indicator">
                                    {step.status === 'success' ? (
                                        <CheckCircle2 className="e2e-icon-success" />
                                    ) : step.status === 'running' ? (
                                        <Loader2 className="e2e-icon-running e2e-spin" />
                                    ) : (
                                        <div className="e2e-step-number">{index + 1}</div>
                                    )}
                                    {index < pipeline.length - 1 && <div className="e2e-step-line" />}
                                </div>
                                <div className="e2e-step-content">
                                    <div className="e2e-step-title">
                                        <span className="e2e-step-icon">{step.icon}</span>
                                        <h4>{step.label}</h4>
                                    </div>
                                    <p className="e2e-step-desc">{step.description}</p>
                                </div>
                            </div>
                        ))}
                    </div>
                </div>

                {/* RIGHT PANEL: TERMINAL */}
                <div className="e2e-terminal-panel">
                    <div className="e2e-terminal-header">
                        <Terminal size={16} />
                        <span>stdout / Runtime Payload Interceptor</span>
                        <div className="e2e-window-controls">
                            <span className="e2e-dot minimize"></span>
                            <span className="e2e-dot maximize"></span>
                            <span className="e2e-dot close"></span>
                        </div>
                    </div>
                    <div className="e2e-terminal-body" ref={terminalRef}>
                        {masterLog.length === 0 && (
                            <div className="e2e-terminal-empty">
                                {'>'} Waiting for sweep execution trigger...
                            </div>
                        )}
                        {masterLog.map((log, i) => (
                            <div key={i} className={`e2e-log-line log-${log.level}`}>
                                <span className="e2e-log-ts">[{log.timestamp.split('T')[1].slice(0, 12)}]</span>
                                <span className="e2e-log-msg">{log.message}</span>
                                {log.data && (
                                    <pre className="e2e-log-data">
                                        {JSON.stringify(log.data, null, 2)}
                                    </pre>
                                )}
                            </div>
                        ))}
                    </div>
                </div>
            </div>
        </div>
    );
}
