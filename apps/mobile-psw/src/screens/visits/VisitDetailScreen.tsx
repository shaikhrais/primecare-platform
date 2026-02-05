import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, Alert, ScrollView, ActivityIndicator } from 'react-native';
import { useAuth, API_URL } from '../../context/AuthContext';
import { PermissionService } from '../../services/PermissionService';

export default function VisitDetailScreen({ route, navigation }: any) {
    const { visitId } = route.params;
    const [visit, setVisit] = useState<any>(null);
    const [loading, setLoading] = useState(true);
    const { token } = useAuth();

    useEffect(() => {
        fetchVisitDetails();
    }, []);

    const fetchVisitDetails = async () => {
        try {
            // For now, re-fetch list or find specific (mocking fetch specific for MVP)
            // Real impl would have GET /v1/psw/visits/:id
            const response = await fetch(`${API_URL}/v1/psw/visits`, {
                headers: { 'Authorization': `Bearer ${token}` }
            });
            const data = await response.json();
            const found = data.find((v: any) => v.id === visitId);
            setVisit(found);
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    const handleAction = async (action: 'check-in' | 'check-out') => {
        if (action === 'check-in' || action === 'check-out') {
            const hasLocation = await PermissionService.requestLocationPermission();
            if (!hasLocation) {
                Alert.alert('Permission Denied', 'Location permission is required for check-in/check-out.');
                return;
            }
        }

        setLoading(true);
        try {
            const response = await fetch(`${API_URL}/v1/psw/visits/${visitId}/${action}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    latitude: 43.6532, // Mock GPS
                    longitude: -79.3832
                })
            });

            if (response.ok) {
                Alert.alert('Success', `Successfully ${action === 'check-in' ? 'Checked In' : 'Checked Out'}`);
                fetchVisitDetails(); // Refresh
            } else {
                Alert.alert('Error', 'Action failed');
            }
        } catch (error) {
            Alert.alert('Error', 'Network error');
        } finally {
            setLoading(false);
        }
    };

    if (!visit || loading) {
        return (
            <View style={styles.center}>
                <ActivityIndicator size="large" color="#004d40" />
            </View>
        );
    }

    return (
        <ScrollView style={styles.container}>
            <View style={styles.card}>
                <Text style={styles.label}>Client</Text>
                <Text style={styles.value}>{visit.client.fullName}</Text>

                <Text style={styles.label}>Address</Text>
                <Text style={styles.value}>{visit.client.address || '123 Main St, Toronto, ON'}</Text>

                <Text style={styles.label}>Status</Text>
                <Text style={[styles.value, { color: '#004d40', fontWeight: 'bold' }]}>{visit.status.toUpperCase()}</Text>
            </View>

            <View style={styles.actions}>
                {visit.status === 'scheduled' && (
                    <TouchableOpacity style={styles.button} onPress={() => handleAction('check-in')}>
                        <Text style={styles.buttonText}>Check In</Text>
                    </TouchableOpacity>
                )}

                {visit.status === 'in_progress' && (
                    <TouchableOpacity style={[styles.button, { backgroundColor: '#d32f2f' }]} onPress={() => handleAction('check-out')}>
                        <Text style={styles.buttonText}>Check Out</Text>
                    </TouchableOpacity>
                )}

                {visit.status === 'completed' && (
                    <View style={styles.completedBox}>
                        <Text style={styles.completedText}>Visit Completed</Text>
                    </View>
                )}
            </View>
        </ScrollView>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f5f5f5',
        padding: 20,
    },
    center: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    card: {
        backgroundColor: 'white',
        padding: 20,
        borderRadius: 10,
        marginBottom: 20,
        elevation: 2,
    },
    label: {
        fontSize: 14,
        color: '#666',
        marginBottom: 4,
    },
    value: {
        fontSize: 18,
        color: '#333',
        marginBottom: 16,
        fontWeight: '500',
    },
    actions: {
        marginTop: 20,
    },
    button: {
        backgroundColor: '#004d40',
        padding: 18,
        borderRadius: 8,
        alignItems: 'center',
        marginBottom: 10,
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
    completedBox: {
        padding: 20,
        backgroundColor: '#e8f5e9',
        borderRadius: 8,
        alignItems: 'center',
    },
    completedText: {
        color: '#388e3c',
        fontWeight: 'bold',
        fontSize: 16,
    },
});
