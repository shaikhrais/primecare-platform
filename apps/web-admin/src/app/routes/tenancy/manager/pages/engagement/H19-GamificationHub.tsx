// ================================================================
// PAGE IDENTITY: H19 · Gamification Hub — PSW Engagement & Retention
// Type: Hub | Owner: manager | Registry: H25
// TEMPLATE-DRIVEN: Uses PageTemplate + PageSectionRegistry
// ================================================================
import React, { useState } from 'react';
import { PageTemplate } from '@/shared/components/ui/PageTemplate';
import type { TableColumn } from '@/shared/components/sections';

const mockLeaderboard = [
    { rank: '🏆', name: 'Priya Sharma', level: 'Diamond', points: 2847, streak: '45 days', visits: 312 },
    { rank: '🥈', name: 'David Chen', level: 'Diamond', points: 2610, streak: '38 days', visits: 289 },
    { rank: '🥉', name: 'Maria Santos', level: 'Platinum', points: 2455, streak: '30 days', visits: 275 },
    { rank: '⭐', name: 'James Wright', level: 'Platinum', points: 2180, streak: '22 days', visits: 256 },
    { rank: '⭐', name: 'Aisha Patel', level: 'Gold', points: 2050, streak: '19 days', visits: 240 },
    { rank: '⭐', name: 'Kevin O\'Brien', level: 'Gold', points: 1890, streak: '15 days', visits: 228 },
    { rank: '⭐', name: 'Sarah Kim', level: 'Silver', points: 1750, streak: '12 days', visits: 210 },
    { rank: '⭐', name: 'Tom Rodriguez', level: 'Silver', points: 1620, streak: '9 days', visits: 195 },
];

const leaderboardCols: TableColumn[] = [
    { key: 'rank', label: 'Rank', align: 'center' },
    { key: 'name', label: 'PSW' },
    { key: 'level', label: 'Level' },
    { key: 'points', label: 'Points' },
    { key: 'streak', label: 'Streak' },
    { key: 'visits', label: 'Visits' },
];

const badges = [
    { icon: '🏃', title: 'Visit Streak', subtitle: '30+ consecutive days', badge: '12% unlocked' },
    { icon: '⏰', title: 'Punctuality Pro', subtitle: '95%+ on-time check-ins', badge: '28% unlocked' },
    { icon: '❤️', title: 'Client Favorite', subtitle: '5★ avg from 10+ clients', badge: '18% unlocked' },
    { icon: '📚', title: 'Scholar', subtitle: 'Complete 10 training modules', badge: '34% unlocked' },
    { icon: '🦸', title: 'First Responder', subtitle: 'Filed 3+ incident reports', badge: '45% unlocked' },
    { icon: '🌙', title: 'Night Owl', subtitle: '50+ evening shifts', badge: '22% unlocked' },
    { icon: '🗺️', title: 'Road Warrior', subtitle: '1000+ km traveled', badge: '15% unlocked' },
    { icon: '🤝', title: 'Team Player', subtitle: 'Cover 5+ shifts', badge: '20% unlocked' },
];

const challenges = [
    { name: '🎯 March Madness', description: 'Complete 20 visits this week', progress: 75, badge: 'Reward: 50 pts', meta: '⏰ 3 days left' },
    { name: '🎯 Zero No-Shows', description: 'Perfect attendance for 2 weeks', progress: 85, badge: 'Reward: 100 pts', meta: '⏰ 4 days left' },
    { name: '🎯 Documentation Star', description: 'Submit all notes within 1hr', progress: 60, badge: 'Reward: 30 pts', meta: '⏰ 5 days left' },
];

const rewards = [
    { icon: '☕', title: 'Coffee Card', subtitle: '$10 Tim Hortons gift card', badge: '🎯 500 pts' },
    { icon: '🎬', title: 'Movie Night', subtitle: '2x Cineplex movie tickets', badge: '🎯 1,000 pts' },
    { icon: '🛍️', title: 'Shopping Spree', subtitle: '$50 Amazon gift card', badge: '🎯 2,000 pts' },
    { icon: '✈️', title: 'PTO Day', subtitle: 'Extra paid time off day', badge: '🎯 3,000 pts' },
    { icon: '📱', title: 'Tech Upgrade', subtitle: 'New tablet or phone case', badge: '🎯 5,000 pts' },
    { icon: '🌟', title: 'Wall of Fame', subtitle: 'Featured on company wall', badge: '🎯 100 pts' },
];

export default function GamificationHub() {
    const [activeTab, setActiveTab] = useState('leaderboard');

    const tabContent: Record<string, Record<string, any>> = {
        leaderboard: { 'H25.leaderboard': { table: { columns: leaderboardCols, rows: mockLeaderboard } } },
        badges: { 'H25.badges': { cardGrid: { items: badges, columns: 4 } } },
        challenges: { 'H25.challenges': { progressList: { items: challenges } } },
        rewards: { 'H25.rewards': { cardGrid: { items: rewards, columns: 3 } } },
    };

    return (
        <PageTemplate
            pageId="H25"
            title="🎮 Gamification Hub"
            subtitle="PSW engagement, achievements, streaks & rewards"
            actionPageId="manager.gamification"
            sectionData={{
                'H25.stats': { kpiCards: [
                    { label: 'Active PSWs', value: 48, icon: '👥', color: 'var(--pc-primary)' },
                    { label: 'Avg Score', value: '2,050', icon: '📊', color: 'var(--pc-success)' },
                    { label: 'Badges Issued', value: 156, icon: '🎖️', color: 'var(--pc-warning)' },
                    { label: 'Active Challenges', value: 3, icon: '🎯', color: '#7C3AED' },
                    { label: 'Retention Rate', value: '94%', icon: '💎', color: 'var(--pc-info, #2563EB)' },
                ]},
                'H25.tabs': { tabs: {
                    tabs: [
                        { id: 'leaderboard', label: '🏆 Leaderboard', count: 8 },
                        { id: 'badges', label: '🎖️ Badges', count: 8 },
                        { id: 'challenges', label: '🎯 Challenges', count: 3 },
                        { id: 'rewards', label: '🎁 Rewards' },
                    ],
                    activeTab, onTabChange: setActiveTab,
                }},
                ...tabContent[activeTab],
            }}
        />
    );
}
