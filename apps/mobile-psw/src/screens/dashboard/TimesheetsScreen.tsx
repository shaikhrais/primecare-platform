import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, ActivityIndicator } from 'react-native';
import { PswRegistry } from '@primecare/shared';
import { TimesheetsService, TimesheetEntry } from '../../services/TimesheetsService';

const { ContentRegistry } = PswRegistry;

export default function TimesheetsScreen() {
    const [entries, setEntries] = useState<TimesheetEntry[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        loadTimesheets();
    }, []);

    const loadTimesheets = async () => {
        const data = await TimesheetsService.getTimesheets();
        setEntries(data);
        setLoading(false);
    };

    const renderItem = ({ item }: { item: TimesheetEntry }) => (
        <View style={styles.card}>
            <View style={styles.header}>
                <Text style={styles.date}>{item.date}</Text>
                <Text style={[styles.status,
                item.status === 'approved' ? styles.approved : styles.pending
                ]}>{item.status.toUpperCase()}</Text>
            </View>
            <View style={styles.details}>
                <View>
                    <Text style={styles.label}>{ContentRegistry.TIMESHEETS.HOURS}</Text>
                    <Text style={styles.value}>{item.hours} hrs</Text>
                </View>
                <View>
                    <Text style={styles.label}>{ContentRegistry.TIMESHEETS.EARNINGS}</Text>
                    <Text style={styles.value}>${item.earnings.toFixed(2)}</Text>
                </View>
            </View>
        </View>
    );

    if (loading) return <ActivityIndicator style={styles.loader} size="large" />;

    return (
        <View style={styles.container}>
            <FlatList
                data={entries}
                renderItem={renderItem}
                keyExtractor={item => item.id}
                contentContainerStyle={styles.list}
                ListEmptyComponent={<Text style={styles.empty}>{ContentRegistry.TIMESHEETS.EMPTY}</Text>}
            />
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#f0f2f5' },
    loader: { flex: 1, justifyContent: 'center' },
    list: { padding: 16 },
    card: {
        backgroundColor: '#fff',
        padding: 16,
        borderRadius: 12,
        marginBottom: 12,
        elevation: 2,
    },
    header: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 12 },
    date: { fontSize: 16, fontWeight: 'bold', color: '#333' },
    status: { fontSize: 12, fontWeight: 'bold', paddingHorizontal: 8, paddingVertical: 2, borderRadius: 10, overflow: 'hidden' },
    approved: { backgroundColor: '#e8f5e9', color: '#2e7d32' },
    pending: { backgroundColor: '#fff3e0', color: '#ef6c00' },
    details: { flexDirection: 'row', justifyContent: 'space-between', borderTopWidth: 1, borderTopColor: '#f0f0f0', paddingTop: 12 },
    label: { fontSize: 12, color: '#666' },
    value: { fontSize: 18, fontWeight: 'bold', color: '#333' },
    empty: { textAlign: 'center', marginTop: 40, color: '#888' }
});
