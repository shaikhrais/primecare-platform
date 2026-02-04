import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, ActivityIndicator } from 'react-native';
import { ClientRegistry } from 'prime-care-shared';
import { InvoicesService, Invoice } from '../../services/InvoicesService';

const { ContentRegistry } = ClientRegistry;

export default function InvoicesScreen() {
    const [invoices, setInvoices] = useState<Invoice[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        loadInvoices();
    }, []);

    const loadInvoices = async () => {
        try {
            const data = await InvoicesService.getInvoices();
            setInvoices(data);
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    const renderItem = ({ item }: { item: Invoice }) => (
        <View style={styles.card}>
            <View style={styles.header}>
                <Text style={styles.description}>{item.description}</Text>
                <Text style={[styles.status,
                item.status === 'paid' ? styles.paid :
                    item.status === 'overdue' ? styles.overdue : styles.pending
                ]}>
                    {item.status.toUpperCase()}
                </Text>
            </View>
            <View style={styles.details}>
                <Text style={styles.amount}>${item.amount.toFixed(2)}</Text>
                <Text style={styles.date}>Due: {new Date(item.dueDate).toLocaleDateString()}</Text>
            </View>
        </View>
    );

    if (loading) return <ActivityIndicator style={styles.loader} size="large" />;

    return (
        <View style={styles.container}>
            <FlatList
                data={invoices}
                renderItem={renderItem}
                keyExtractor={item => item.id}
                contentContainerStyle={styles.list}
                ListEmptyComponent={<Text style={styles.empty}>No invoices found.</Text>}
            />
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#f5f5f5' },
    loader: { flex: 1, justifyContent: 'center' },
    list: { padding: 16 },
    card: {
        backgroundColor: '#fff',
        padding: 16,
        borderRadius: 12,
        marginBottom: 12,
        elevation: 2,
    },
    header: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 8 },
    description: { fontSize: 16, fontWeight: 'bold', color: '#333' },
    status: { fontSize: 12, fontWeight: 'bold', paddingHorizontal: 8, paddingVertical: 2, borderRadius: 10, overflow: 'hidden' },
    paid: { backgroundColor: '#e8f5e9', color: '#2e7d32' },
    pending: { backgroundColor: '#fff3e0', color: '#ef6c00' },
    overdue: { backgroundColor: '#ffebee', color: '#c62828' },
    details: { flexDirection: 'row', justifyContent: 'space-between', alignItems: 'center' },
    amount: { fontSize: 18, fontWeight: 'bold', color: '#004d40' },
    date: { fontSize: 14, color: '#666' },
    empty: { textAlign: 'center', marginTop: 40, color: '#888' }
});
