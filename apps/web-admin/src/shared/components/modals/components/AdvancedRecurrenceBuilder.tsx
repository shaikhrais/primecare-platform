import React, { useState, useEffect } from 'react';
import { RRule, Frequency, Weekday } from 'rrule';

export interface AdvancedRecurrenceBuilderProps {
    value: string;
    onChange: (rruleString: string, endDate?: string) => void;
    startDate: string;
    disabled?: boolean;
}

export const AdvancedRecurrenceBuilder: React.FC<AdvancedRecurrenceBuilderProps> = ({
    value, onChange, startDate, disabled
}) => {
    const [freq, setFreq] = useState<Frequency>(RRule.WEEKLY);
    const [interval, setInterval] = useState(1);
    const [byweekday, setByweekday] = useState<Weekday[]>([]);
    
    const [endType, setEndType] = useState<'never' | 'after' | 'date'>('never');
    const [count, setCount] = useState(10);
    const [until, setUntil] = useState('');

    useEffect(() => {
        if (!startDate) return;
        try {
            if (value) {
                const rule = RRule.fromString(value);
                setFreq(rule.options.freq);
                setInterval(rule.options.interval || 1);
                if (rule.options.byweekday) setByweekday(rule.options.byweekday as unknown as Weekday[]);
                if (rule.options.count) {
                    setEndType('after');
                    setCount(rule.options.count);
                } else if (rule.options.until) {
                    setEndType('date');
                    setUntil(rule.options.until.toISOString().substring(0, 10));
                }
            } else {
                const d = new Date(startDate);
                if (!isNaN(d.getTime())) {
                    const wd = [RRule.SU, RRule.MO, RRule.TU, RRule.WE, RRule.TH, RRule.FR, RRule.SA][d.getDay()];
                    setByweekday([wd]);
                }
            }
        } catch (e) {
            console.error('Failed to parse initial RRule:', e);
        }
    }, [startDate]);

    useEffect(() => {
        if (!startDate) return;
        const dtstart = new Date(startDate);
        if (isNaN(dtstart.getTime())) return;
        
        const options: any = {
            freq,
            interval,
            dtstart,
        };

        if (freq === RRule.WEEKLY && byweekday.length > 0) {
            options.byweekday = byweekday;
        }

        if (endType === 'after') {
            options.count = count;
        } else if (endType === 'date' && until) {
            options.until = new Date(until);
            // set time to end of day to be inclusive
            options.until.setUTCHours(23, 59, 59, 999);
        }

        try {
            const rule = new RRule(options);
            let rruleStr = rule.toString();
            if (rruleStr.includes('RRULE:')) {
                rruleStr = rruleStr.split('RRULE:')[1].trim();
            }
            onChange(rruleStr, endType === 'date' ? new Date(until).toISOString() : undefined);
        } catch (e) {
            console.error('Failed to generate RRule:', e);
        }
    }, [freq, interval, byweekday, endType, count, until, startDate]);

    const days = [
        { label: 'S', val: RRule.SU }, { label: 'M', val: RRule.MO }, { label: 'T', val: RRule.TU },
        { label: 'W', val: RRule.WE }, { label: 'T', val: RRule.TH }, { label: 'F', val: RRule.FR }, { label: 'S', val: RRule.SA }
    ];

    const toggleDay = (d: Weekday) => {
        if (byweekday.some(w => w.weekday === d.weekday)) {
            setByweekday(byweekday.filter(w => w.weekday !== d.weekday));
        } else {
            setByweekday([...byweekday, d]);
        }
    }

    return (
        <div style={{ display: 'flex', flexDirection: 'column', gap: '1rem', padding: '1.25rem', backgroundColor: '#f8fafc', borderRadius: '0.75rem', border: '1px solid #e2e8f0', boxShadow: 'inset 0 2px 4px 0 rgb(0 0 0 / 0.02)' }}>
            <h4 style={{ margin: 0, fontSize: '0.875rem', fontWeight: 600, color: '#334155' }}>Advanced Recurrence Schedule</h4>
            
            <div style={{ display: 'flex', gap: '1rem', alignItems: 'center' }}>
                <span style={{ fontSize: '0.875rem', color: '#475569' }}>Repeat every</span>
                <input data-cy="input-shared.advanced-recurrence-builder-0" 
                    type="number" 
                    min={1} 
                    value={interval} 
                    onChange={e => setInterval(parseInt(e.target.value) || 1)}
                    disabled={disabled}
                    style={{ width: '60px', padding: '0.5rem', border: '1px solid #cbd5e1', borderRadius: '0.5rem', fontSize: '0.875rem' }}
                />
                <select data-cy="select-shared.advanced-recurrence-builder-0" 
                    value={freq} 
                    onChange={e => setFreq(parseInt(e.target.value))}
                    disabled={disabled}
                    style={{ padding: '0.5rem', border: '1px solid #cbd5e1', borderRadius: '0.5rem', flex: 1, fontSize: '0.875rem', backgroundColor: '#fff' }}
                >
                    <option value={RRule.DAILY}>Days</option>
                    <option value={RRule.WEEKLY}>Weeks</option>
                    <option value={RRule.MONTHLY}>Months</option>
                </select>
            </div>

            {freq === RRule.WEEKLY && (
                <div style={{ display: 'flex', gap: '0.5rem', justifyContent: 'space-between', marginTop: '0.5rem' }}>
                    {days.map((d, i) => {
                        const isSelected = byweekday.some(w => w.weekday === d.val.weekday);
                        return (
                            <button data-cy="btn-shared.advanced-recurrence-builder-0"
                                key={`day-${i}`}
                                type="button"
                                onClick={() => toggleDay(d.val)}
                                disabled={disabled}
                                style={{
                                    width: '36px', height: '36px', borderRadius: '50%',
                                    border: isSelected ? 'none' : '1px solid #cbd5e1',
                                    backgroundColor: isSelected ? '#3b82f6' : '#fff',
                                    color: isSelected ? '#fff' : '#475569',
                                    cursor: disabled ? 'not-allowed' : 'pointer',
                                    display: 'flex', alignItems: 'center', justifyContent: 'center', fontSize: '0.875rem', fontWeight: 600,
                                    transition: 'all 0.2s',
                                    boxShadow: isSelected ? '0 4px 6px -1px rgb(59 130 246 / 0.3)' : 'none'
                                }}
                            >
                                {d.label}
                            </button>
                        );
                    })}
                </div>
            )}

            <div style={{ height: '1px', backgroundColor: '#e2e8f0', margin: '0.5rem 0' }} />

            <div style={{ display: 'flex', flexDirection: 'column', gap: '0.75rem' }}>
                <span style={{ fontSize: '0.875rem', fontWeight: 600, color: '#334155' }}>Ends</span>
                
                <label style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', fontSize: '0.875rem', color: '#475569', cursor: disabled ? 'not-allowed' : 'pointer' }}>
                    <input data-cy="input-shared.advanced-recurrence-builder-1" type="radio" name="endType" checked={endType === 'never'} onChange={() => setEndType('never')} disabled={disabled} style={{ width: '1rem', height: '1rem', accentColor: '#3b82f6' }} />
                    Never (Continuous)
                </label>
                
                <label style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', fontSize: '0.875rem', color: '#475569', cursor: disabled ? 'not-allowed' : 'pointer' }}>
                    <input data-cy="input-shared.advanced-recurrence-builder-2" type="radio" name="endType" checked={endType === 'after'} onChange={() => setEndType('after')} disabled={disabled} style={{ width: '1rem', height: '1rem', accentColor: '#3b82f6' }} />
                    After
                    <input data-cy="input-shared.advanced-recurrence-builder-3" 
                        type="number" min={1} value={count} onChange={e => setCount(parseInt(e.target.value) || 1)} disabled={disabled || endType !== 'after'}
                        style={{ width: '70px', padding: '0.375rem 0.5rem', border: '1px solid #cbd5e1', borderRadius: '0.375rem', opacity: endType !== 'after' ? 0.5 : 1 }}
                    />
                    occurrences
                </label>

                <label style={{ display: 'flex', alignItems: 'center', gap: '0.75rem', fontSize: '0.875rem', color: '#475569', cursor: disabled ? 'not-allowed' : 'pointer' }}>
                    <input data-cy="input-shared.advanced-recurrence-builder-4" type="radio" name="endType" checked={endType === 'date'} onChange={() => setEndType('date')} disabled={disabled} style={{ width: '1rem', height: '1rem', accentColor: '#3b82f6' }} />
                    On
                    <input data-cy="input-shared.advanced-recurrence-builder-5" 
                        type="date" value={until} onChange={e => setUntil(e.target.value)} disabled={disabled || endType !== 'date'}
                        style={{ padding: '0.375rem 0.5rem', border: '1px solid #cbd5e1', borderRadius: '0.375rem', opacity: endType !== 'date' ? 0.5 : 1 }}
                    />
                </label>
            </div>
        </div>
    );
};
