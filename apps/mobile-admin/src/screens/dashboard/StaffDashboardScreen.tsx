import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, SafeAreaView, ActivityIndicator } from 'react-native';
import { useAuth, API_URL } from '../../context/AuthContext';
import { MobileAdminRegistry } from 'prime-care-shared';

const { RouteRegistry, ContentRegistry } = MobileAdminRegistry;

export default function StaffDashboardScreen({ navigation }: any) {
    const { user, token } = useAuth();
    const [tickets, setTickets] = useState<any[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetch(`${API_URL}/v1/staff/tickets`, {
            headers: { 'Authorization': `Bearer ${token}` }
        })
            .then(res => res.json())
            .then(data => {
                setTickets(Array.isArray(data) ? data : []);
                setLoading(false);
            })
            .catch(() => setLoading(false));
    }, [token]);

    const renderTicket = ({ item }: { item: any }) => (
        <TouchableOpacity
            style={styles.ticketCard}
            onPress={() => navigation.navigate(RouteRegistry.MESSAGING, { threadId: item.id })}
        >
            <View style={styles.ticketHeader}>
                <Text style={styles.ticketTitle}>{item.client?.fullName || 'General Support'}</Text>
                <Text style={styles.ticketDate}>{new Date(item.createdAt).toLocaleDateString()}</Text>
            </View>
            <Text style={styles.ticketPreview} numberOfLines={1}>
                {item.messages[0]?.bodyText || 'No messages yet'}
            </Text>
            <View style={styles.statusBadge}>
                <Text style={styles.statusText}>OPEN</Text>
            </View>
        </TouchableOpacity>
    );

    return (
        <SafeAreaView style={styles.container}>
            <View style={styles.header}>
                <Text style={styles.welcome}>Welcome, {user?.email?.split('@')[0]}</Text>
                <Text style={styles.tagline}>{ContentRegistry.APP.TAGLINE}</Text>
            </View>

            <View style={styles.statsRow}>
                <View style={styles.statBox}>
                    <Text style={styles.statValue}>{tickets.length}</Text>
                    <Text style={styles.statLabel}>Active Tickets</Text>
                </View>
                <TouchableOpacity
                    style={styles.statBox}
                    onPress={() => navigation.navigate(RouteRegistry.USER_LOOKUP)}
                >
                    <Text style={styles.statValue}>🔍</Text>
                    <Text style={styles.statLabel}>User Lookup</Text>
                </TouchableOpacity>
            </View>

            <Text style={styles.sectionTitle}>Recent Support Requests</Text>

            {loading ? (
                <ActivityIndicator size="large" color="#004d40" style={{ marginTop: 20 }} />
            ) : (
                <FlatList
                    data={tickets}
                    renderItem={renderTicket}
                    keyExtractor={item => item.id}
                    contentContainerStyle={styles.listContent}
                    ListEmptyComponent={
                        <Text style={styles.emptyText}>No active tickets. Good job!</Text>
                    }
                />
            )}
        </SafeAreaView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f5f5f5',
    },
    header: {
        padding: 20,
        backgroundColor: '#004d40',
    },
    welcome: {
        fontSize: 24,
        fontWeight: 'bold',
        color: 'white',
        textTransform: 'capitalize',
    },
    tagline: {
        fontSize: 14,
        color: 'rgba(255,255,255,0.8)',
        marginTop: 5,
    },
    statsRow: {
        flexDirection: 'row',
        padding: 15,
        gap: 15,
    },
    statBox: {
        flex: 1,
        backgroundColor: 'white',
        padding: 20,
        borderRadius: 12,
        alignItems: 'center',
        elevation: 2,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 2 },
        shadowOpacity: 0.1,
        shadowRadius: 4,
    },
    statValue: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#004d40',
    },
    statLabel: {
        fontSize: 12,
        color: '#666',
        marginTop: 5,
    },
    sectionTitle: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#333',
        marginHorizontal: 20,
        marginTop: 10,
        marginBottom: 10,
    },
    listContent: {
        paddingHorizontal: 20,
        paddingBottom: 20,
    },
    ticketCard: {
        backgroundColor: 'white',
        padding: 15,
        borderRadius: 10,
        marginBottom: 10,
        elevation: 1,
        shadowColor: '#000',
        shadowOffset: { width: 0, height: 1 },
        shadowOpacity: 0.05,
        shadowRadius: 2,
    },
    ticketHeader: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        marginBottom: 5,
    },
    ticketTitle: {
        fontWeight: 'bold',
        fontSize: 16,
        color: '#004d40',
    },
    ticketDate: {
        fontSize: 12,
        color: '#999',
    },
    ticketPreview: {
        fontSize: 14,
        color: '#666',
        marginBottom: 10,
    },
    statusBadge: {
        alignSelf: 'flex-start',
        backgroundColor: '#e0f2f1',
        paddingHorizontal: 8,
        paddingVertical: 4,
        borderRadius: 4,
    },
    statusText: {
        fontSize: 10,
        fontWeight: 'bold',
        color: '#004d40',
    },
    emptyText: {
        textAlign: 'center',
        marginTop: 40,
        color: '#999',
    }
});
