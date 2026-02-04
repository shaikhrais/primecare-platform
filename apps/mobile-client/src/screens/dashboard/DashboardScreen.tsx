import React, { useCallback, useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, FlatList, ActivityIndicator, RefreshControl } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { ClientRegistry } from 'prime-care-shared';
import { BookingsService, Booking } from '../../services/BookingsService';

const { ContentRegistry, RouteRegistry } = ClientRegistry;

export default function DashboardScreen({ navigation }: any) {
    const [bookings, setBookings] = useState<Booking[]>([]);
    const [loading, setLoading] = useState(true);
    const [refreshing, setRefreshing] = useState(false);

    const loadBookings = async () => {
        try {
            const data = await BookingsService.getBookings();
            setBookings(data);
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
            setRefreshing(false);
        }
    };

    useFocusEffect(
        useCallback(() => {
            loadBookings();
        }, [])
    );

    const onRefresh = () => {
        setRefreshing(true);
        loadBookings();
    };

    const renderItem = ({ item }: { item: Booking }) => (
        <View style={styles.card}>
            <View style={styles.header}>
                <Text style={styles.serviceName}>{item.service?.name || 'Service'}</Text>
                <Text style={styles.status}>{item.status}</Text>
            </View>
            <Text style={styles.date}>{new Date(item.requestedStartAt).toLocaleString()}</Text>
        </View>
    );

    return (
        <View style={styles.container}>
            <FlatList
                data={bookings}
                renderItem={renderItem}
                keyExtractor={(item) => item.id}
                contentContainerStyle={styles.list}
                refreshControl={<RefreshControl refreshing={refreshing} onRefresh={onRefresh} />}
                ListEmptyComponent={
                    !loading ? (
                        <View style={styles.emptyContainer}>
                            <Text style={styles.emptyText}>{ContentRegistry.DASHBOARD.EMPTY_VISITS}</Text>
                        </View>
                    ) : null
                }
            />

            <TouchableOpacity
                style={styles.messageFab}
                onPress={() => navigation.navigate(RouteRegistry.DASHBOARD.CHAT)}
            >
                <Text style={styles.fabText}>💬</Text>
            </TouchableOpacity>

            <TouchableOpacity
                style={styles.fab}
                onPress={() => navigation.navigate(RouteRegistry.DASHBOARD.BOOK_SERVICE)}
            >
                <Text style={styles.fabText}>+</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, backgroundColor: '#f5f5f5' },
    list: { padding: 16 },
    card: {
        backgroundColor: '#fff',
        padding: 16,
        borderRadius: 12,
        marginBottom: 12,
        elevation: 2,
    },
    header: { flexDirection: 'row', justifyContent: 'space-between', marginBottom: 8 },
    serviceName: { fontSize: 16, fontWeight: 'bold', color: '#333' },
    status: { fontSize: 12, fontWeight: 'bold', color: '#666', textTransform: 'uppercase' },
    date: { fontSize: 14, color: '#444' },
    emptyContainer: { alignItems: 'center', marginTop: 50 },
    emptyText: { color: '#888', fontSize: 16 },
    fab: {
        position: 'absolute',
        right: 20,
        bottom: 20,
        backgroundColor: '#007bff',
        width: 56,
        height: 56,
        borderRadius: 28,
        justifyContent: 'center',
        alignItems: 'center',
        elevation: 6,
    },
    fabText: { color: '#fff', fontSize: 24, fontWeight: 'bold' },
    messageFab: {
        position: 'absolute',
        right: 20,
        bottom: 90,
        backgroundColor: '#28a745',
        width: 56,
        height: 56,
        borderRadius: 28,
        justifyContent: 'center',
        alignItems: 'center',
        elevation: 6,
    },
});
