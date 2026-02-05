import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, ActivityIndicator } from 'react-native';
import { useAuth, API_URL } from '../../context/AuthContext';

interface Visit {
    id: string;
    status: string;
    scheduledAt: string;
    client: { fullName: string };
}

export default function HomeScreen({ navigation }: any) {
    const [visits, setVisits] = useState<Visit[]>([]);
    const [loading, setLoading] = useState(true);
    const { token, user } = useAuth();

    useEffect(() => {
        fetchVisits();
    }, []);

    const fetchVisits = async () => {
        try {
            const response = await fetch(`${API_URL}/v1/psw/visits`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            const data = await response.json();
            if (Array.isArray(data)) {
                setVisits(data);
            }
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    const renderItem = ({ item }: { item: Visit }) => (
        <TouchableOpacity
            style={styles.card}
            onPress={() => navigation.navigate('VisitDetails', { visitId: item.id })}
        >
            <View style={styles.row}>
                <Text style={styles.clientName}>{item.client.fullName}</Text>
                <StatusBadge status={item.status} />
            </View>
            <Text style={styles.date}>{new Date(item.scheduledAt).toLocaleString()}</Text>
        </TouchableOpacity>
    );

    const StatusBadge = ({ status }: { status: string }) => {
        let color = '#999';
        if (status === 'scheduled') color = '#1976d2';
        if (status === 'in_progress') color = '#f57c00';
        if (status === 'completed') color = '#388e3c';

        return (
            <View style={[styles.badge, { backgroundColor: color }]}>
                <Text style={styles.badgeText}>{status.replace('_', ' ').toUpperCase()}</Text>
            </View>
        );
    };

    return (
        <View style={styles.container}>
            <Text style={styles.headerTitle}>Assigned Visits</Text>
            {loading ? (
                <ActivityIndicator size="large" color="#004d40" style={{ marginTop: 20 }} />
            ) : (
                <FlatList
                    data={visits}
                    renderItem={renderItem}
                    keyExtractor={item => item.id}
                    contentContainerStyle={styles.list}
                    ListEmptyComponent={<Text style={styles.empty}>No visits assigned yet.</Text>}
                    onRefresh={fetchVisits}
                    refreshing={loading}
                />
            )}
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f5f5f5',
    },
    headerTitle: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#004d40',
        padding: 20,
        paddingBottom: 10,
    },
    list: {
        padding: 16,
    },
    card: {
        backgroundColor: 'white',
        padding: 16,
        borderRadius: 10,
        marginBottom: 12,
        elevation: 2,
    },
    row: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 8,
    },
    clientName: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#333',
    },
    date: {
        color: '#666',
        fontSize: 14,
    },
    badge: {
        paddingHorizontal: 8,
        paddingVertical: 4,
        borderRadius: 4,
    },
    badgeText: {
        color: 'white',
        fontSize: 12,
        fontWeight: 'bold',
    },
    empty: {
        textAlign: 'center',
        marginTop: 50,
        color: '#999',
        fontSize: 16,
    },
});
