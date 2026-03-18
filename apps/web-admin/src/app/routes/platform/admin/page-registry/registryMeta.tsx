import React from 'react';
import { BarChart3, ClipboardList, Layers, Compass, FileText, Wand2, AlertTriangle, Wrench, Globe, BookOpen } from 'lucide-react';
import type { PageType } from 'prime-care-shared';

export const TYPE_META: Record<PageType, { color: string; bg: string; icon: React.ReactNode; label: string }> = {
    dashboard:  { color: '#1D4ED8', bg: '#DBEAFE', icon: <BarChart3 size={14} />, label: 'Dashboard' },
    form:       { color: '#065F46', bg: '#D1FAE5', icon: <ClipboardList size={14} />, label: 'Form' },
    list:       { color: '#92400E', bg: '#FEF3C7', icon: <Layers size={14} />, label: 'List' },
    hub:        { color: '#9D174D', bg: '#FCE7F3', icon: <Compass size={14} />, label: 'Hub' },
    wizard:     { color: '#5B21B6', bg: '#EDE9FE', icon: <Wand2 size={14} />, label: 'Wizard' },
    report:     { color: '#166534', bg: '#DCFCE7', icon: <FileText size={14} />, label: 'Report' },
    tool:       { color: '#0369A1', bg: '#E0F2FE', icon: <Wrench size={14} />, label: 'Tool' },
    portal:     { color: '#B45309', bg: '#FEF9C3', icon: <Globe size={14} />, label: 'Portal' },
    registry:   { color: '#7C3AED', bg: '#F3E8FF', icon: <BookOpen size={14} />, label: 'Registry' },
    settings:   { color: '#374151', bg: '#F3F4F6', icon: <Wrench size={14} />, label: 'Settings' },
    detail:     { color: '#4338CA', bg: '#E0E7FF', icon: <FileText size={14} />, label: 'Detail' },
    error:      { color: '#DC2626', bg: '#FEE2E2', icon: <AlertTriangle size={14} />, label: 'Error' },
};

export const OWNER_META: Record<string, { icon: string; color: string; bg: string }> = {
    admin:         { icon: '⚙️', color: '#1E40AF', bg: '#DBEAFE' },
    superuser:     { icon: '👑', color: '#92400E', bg: '#FEF3C7' },
    manager:       { icon: '📊', color: '#7C3AED', bg: '#EDE9FE' },
    staff:         { icon: '👥', color: '#0369A1', bg: '#E0F2FE' },
    psw:           { icon: '🩺', color: '#065F46', bg: '#D1FAE5' },
    rn:            { icon: '💉', color: '#DC2626', bg: '#FEE2E2' },
    client:        { icon: '👤', color: '#B45309', bg: '#FEF9C3' },
    coordinator:   { icon: '📍', color: '#9D174D', bg: '#FCE7F3' },
    allied:        { icon: '🏥', color: '#166534', bg: '#DCFCE7' },
    'scrum-master':{ icon: '🔧', color: '#374151', bg: '#F3F4F6' },
    auth:          { icon: '🔐', color: '#4338CA', bg: '#E0E7FF' },
    shared:        { icon: '🔗', color: '#64748B', bg: '#F1F5F9' },
};
