import React, { useEffect, useState, useCallback } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, ActivityIndicator, RefreshControl } from 'react-native';
import { useFocusEffect } from '@react-navigation/native';
import { PswRegistry } from '@primecare/shared';
import { VisitsService } from '../../services/VisitsService';

const { ContentRegistry, RouteRegistry } = PswRegistry;

export default function DashboardScreen({ navigation }: any) {
    const [visits, setVisits] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);
    const [refreshing, setRefreshing] = useState(false);

    const loadVisits = async () => {
        try {
            const data = await VisitsService.getVisits();
            setVisits(data);
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
            setRefreshing(false);
        }
    };

    useFocusEffect(
        useCallback(() => {
            loadVisits();
        }, [])
    );

    const onRefresh = () => {
        setRefreshing(true);
        loadVisits();
    };

    const renderItem = ({ item }: { item: any }) => (
        <TouchableOpacity
            style={styles.card}
            onPress={() => navigation.navigate(RouteRegistry.DASHBOARD.VISIT_DETAILS, { visit: item })}
        >
            <View style={styles.cardHeader}>
                <Text style={styles.clientName}>{item.client.fullName}</Text>
                <View style={[
                    styles.statusBadge,
                    item.status === 'in_progress' ? styles.statusInProgress :
                        item.status === 'completed' ? styles.statusCompleted : styles.statusScheduled
                ]}>
                    <Text style={styles.statusText}>
                        {item.status === 'in_progress' ? ContentRegistry.VISITS.STATUS.IN_PROGRESS :
                            item.status === 'completed' ? ContentRegistry.VISITS.STATUS.COMPLETED :
                                ContentRegistry.VISITS.STATUS.SCHEDULED}
                    </Text>
                </View>
            </View>
            <Text style={styles.serviceName}>{item.service.name}</Text>
            <Text style={styles.address}>{item.client.addressLine1}, {item.client.city}</Text>
            <Text style={styles.time}>
                {new Date(item.requestedStartAt).toLocaleTimeString([], { hour: '2-digit', minute: '2-digit' })}
                {' - '}
                {item.durationMinutes} min
            </Text>
        </TouchableOpacity>
    );

    if (loading) {
        return (
            <View style={styles.loadingContainer}>
                <ActivityIndicator size="large" color="#004d40" />
            </View>
        );
    }

    return (
        <View style={styles.container}>
            <FlatList
                data={visits}
                renderItem={renderItem}
                keyExtractor={(item) => item.id}
                contentContainerStyle={styles.listContent}
                refreshControl={
                    <RefreshControl refreshing={refreshing} onRefresh={onRefresh} />
                }
                ListEmptyComponent={
                    <View style={styles.emptyContainer}>
                        <Text style={styles.emptyText}>{ContentRegistry.VISITS.EMPTY}</Text>
                    </View>
                }
            />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f5f5f5',
    },
    loadingContainer: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    listContent: {
        padding: 16,
    },
    card: {
        backgroundColor: '#fff',
        borderRadius: 12,
        padding: 16,
        marginBottom: 16,
        elevation: 2,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
    },
    cardHeader: {
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
    serviceName: {
        fontSize: 16,
        color: '#004d40',
        marginBottom: 4,
    },
    address: {
        fontSize: 14,
        color: '#666',
        marginBottom: 4,
    },
    time: {
        fontSize: 14,
        fontWeight: '600',
        color: '#444',
    },
    statusBadge: {
        paddingHorizontal: 8,
        paddingVertical: 4,
        borderRadius: 12,
    },
    statusScheduled: {
        backgroundColor: '#e3f2fd',
    },
    statusInProgress: {
        backgroundColor: '#fff3e0',
    },
    statusCompleted: {
        backgroundColor: '#e8f5e9',
    },
    statusText: {
        fontSize: 12,
        fontWeight: 'bold',
        color: '#333',
    },
    emptyContainer: {
        padding: 40,
        alignItems: 'center',
    },
    emptyText: {
        fontSize: 16,
        color: '#888',
    }
});
