import React, { useEffect, useState, useCallback } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, FlatList, ActivityIndicator } from 'react-native';
import { useAuth, API_URL } from '../../context/AuthContext';
import { PermissionService } from '../../services/PermissionService';

interface Visit {
    id: string;
    requestedStartAt: string;
    status: string;
    service: { name: string };
    clientNotes?: string;
}

export default function HomeScreen({ navigation }: any) {
    const { user, logout, token } = useAuth();
    const [visits, setVisits] = useState<Visit[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        const init = async () => {
            await PermissionService.requestNotificationPermission();
        };
        init();

        const unsubscribe = navigation.addListener('focus', () => {
            fetchBookings();
        });

        return unsubscribe;
    }, [navigation]);

    const fetchBookings = async () => {
        try {
            const response = await fetch(`${API_URL}/v1/client/bookings`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            const data = await response.json();
            if (Array.isArray(data)) {
                setVisits(data);
            }
        } catch (e) {
            console.error(e);
        } finally {
            setLoading(false);
        }
    };

    const renderVisit = ({ item }: { item: Visit }) => (
        <View style={styles.visitCard}>
            <View style={styles.visitHeader}>
                <Text style={styles.serviceName}>{item.service.name}</Text>
                <StatusBadge status={item.status} />
            </View>
            <Text style={styles.visitDate}>
                {item.requestedStartAt ? new Date(item.requestedStartAt).toLocaleString() : 'Date Pending'}
            </Text>
            {item.clientNotes && <Text style={styles.notes} numberOfLines={1}>{item.clientNotes}</Text>}
        </View>
    );

    const StatusBadge = ({ status }: { status: string }) => {
        let color = '#999';
        if (status === 'requested') color = '#f57c00'; // Orange
        if (status === 'scheduled') color = '#1976d2'; // Blue
        if (status === 'completed') color = '#388e3c'; // Green

        return (
            <View style={[styles.badge, { backgroundColor: color }]}>
                <Text style={styles.badgeText}>{status.toUpperCase()}</Text>
            </View>
        );
    };

    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <Text style={styles.welcome}>Welcome back,</Text>
                <Text style={styles.name}>{user?.email?.split('@')[0] || 'Client'}</Text>
            </View>

            <Text style={styles.sectionTitle}>Your Bookings</Text>

            {loading ? (
                <ActivityIndicator color="#004d40" style={{ margin: 20 }} />
            ) : (
                <FlatList
                    data={visits}
                    renderItem={renderVisit}
                    keyExtractor={item => item.id}
                    contentContainerStyle={styles.list}
                    ListEmptyComponent={
                        <View style={styles.emptyCard}>
                            <Text style={styles.emptyText}>No upcoming visits scheduled.</Text>
                        </View>
                    }
                />
            )}

            <TouchableOpacity
                style={styles.bookButton}
                onPress={() => navigation.navigate('Services')}
            >
                <Text style={styles.buttonText}>Book New Service</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        backgroundColor: '#f5f5f5',
    },
    header: {
        marginBottom: 20,
    },
    welcome: {
        fontSize: 18,
        color: '#666',
    },
    name: {
        fontSize: 26,
        fontWeight: 'bold',
        color: '#004d40',
    },
    sectionTitle: {
        fontSize: 20,
        fontWeight: 'bold',
        marginBottom: 15,
        color: '#333',
    },
    list: {
        paddingBottom: 20,
    },
    visitCard: {
        backgroundColor: 'white',
        padding: 16,
        borderRadius: 12,
        marginBottom: 12,
        elevation: 2,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
    },
    visitHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 8,
    },
    serviceName: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#333',
    },
    visitDate: {
        fontSize: 14,
        color: '#666',
        marginBottom: 4,
    },
    notes: {
        fontSize: 13,
        color: '#999',
        fontStyle: 'italic',
    },
    badge: {
        paddingHorizontal: 8,
        paddingVertical: 4,
        borderRadius: 6,
    },
    badgeText: {
        color: 'white',
        fontSize: 10,
        fontWeight: 'bold',
    },
    emptyCard: {
        backgroundColor: 'white',
        padding: 30,
        borderRadius: 12,
        alignItems: 'center',
        marginBottom: 20,
        borderStyle: 'dashed',
        borderWidth: 1,
        borderColor: '#ccc',
    },
    emptyText: {
        color: '#999',
        fontSize: 16,
    },
    bookButton: {
        backgroundColor: '#004d40',
        padding: 16,
        borderRadius: 10,
        alignItems: 'center',
        marginTop: 'auto', // Push to bottom if list is short
        marginBottom: 10,
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
});
