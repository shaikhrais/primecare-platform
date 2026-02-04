import React, { useState } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, ActivityIndicator, Alert, ScrollView } from 'react-native';
import { PswRegistry } from 'prime-care-shared';
import { VisitsService } from '../../services/VisitsService';

const { ContentRegistry } = PswRegistry;

export default function VisitDetailsScreen({ route, navigation }: any) {
    const { visit } = route.params;
    const [status, setStatus] = useState(visit.status);
    const [loading, setLoading] = useState(false);

    const handleCheckIn = async () => {
        setLoading(true);
        try {
            // Mock Location (Toronto)
            await VisitsService.checkIn(visit.id, 43.6532, -79.3832);
            setStatus('in_progress');
            Alert.alert('Success', 'You have checked in successfully.');
        } catch (error) {
            Alert.alert('Error', 'Failed to check in. Please try again.');
        } finally {
            setLoading(false);
        }
    };

    const handleCheckOut = async () => {
        setLoading(true);
        try {
            await VisitsService.checkOut(visit.id, 43.6532, -79.3832);
            setStatus('completed');
            Alert.alert('Success', 'Visit completed.');
            navigation.goBack();
        } catch (error) {
            Alert.alert('Error', 'Failed to check out.');
        } finally {
            setLoading(false);
        }
    };

    return (
        <ScrollView contentContainerStyle={styles.container}>
            <View style={styles.header}>
                <Text style={styles.title}>{visit.client.fullName}</Text>
                <View style={[
                    styles.statusBadge,
                    status === 'in_progress' ? styles.statusInProgress :
                        status === 'completed' ? styles.statusCompleted : styles.statusScheduled
                ]}>
                    <Text style={styles.statusText}>
                        {status === 'in_progress' ? ContentRegistry.VISITS.STATUS.IN_PROGRESS :
                            status === 'completed' ? ContentRegistry.VISITS.STATUS.COMPLETED :
                                ContentRegistry.VISITS.STATUS.SCHEDULED}
                    </Text>
                </View>
            </View>

            <View style={styles.section}>
                <Text style={styles.sectionTitle}>Service</Text>
                <Text style={styles.sectionText}>{visit.service.name}</Text>
            </View>

            <View style={styles.section}>
                <Text style={styles.sectionTitle}>Location</Text>
                <Text style={styles.sectionText}>{visit.client.addressLine1}</Text>
                <Text style={styles.sectionText}>{visit.client.city}</Text>
            </View>

            <View style={styles.section}>
                <Text style={styles.sectionTitle}>Time</Text>
                <Text style={styles.sectionText}>
                    {new Date(visit.requestedStartAt).toLocaleString()}
                </Text>
                <Text style={styles.sectionText}>Duration: {visit.durationMinutes} minutes</Text>
            </View>

            <View style={styles.actions}>
                {status === 'scheduled' || status === 'en_route' ? (
                    <TouchableOpacity
                        style={[styles.button, styles.checkInButton, loading && styles.buttonDisabled]}
                        onPress={handleCheckIn}
                        disabled={loading}
                    >
                        {loading ? <ActivityIndicator color="#fff" /> :
                            <Text style={styles.buttonText}>{ContentRegistry.VISITS.ACTIONS.CHECK_IN}</Text>}
                    </TouchableOpacity>
                ) : status === 'in_progress' ? (
                    <TouchableOpacity
                        style={[styles.button, styles.checkOutButton, loading && styles.buttonDisabled]}
                        onPress={handleCheckOut}
                        disabled={loading}
                    >
                        {loading ? <ActivityIndicator color="#fff" /> :
                            <Text style={styles.buttonText}>{ContentRegistry.VISITS.ACTIONS.CHECK_OUT}</Text>}
                    </TouchableOpacity>
                ) : null}
            </View>
        </ScrollView>
    );
}

const styles = StyleSheet.create({
    container: {
        padding: 20,
        backgroundColor: '#fff',
        flexGrow: 1,
    },
    header: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        alignItems: 'center',
        marginBottom: 24,
        paddingBottom: 16,
        borderBottomWidth: 1,
        borderBottomColor: '#eee',
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#333',
    },
    statusBadge: {
        paddingHorizontal: 10,
        paddingVertical: 6,
        borderRadius: 12,
    },
    statusScheduled: { backgroundColor: '#e3f2fd' },
    statusInProgress: { backgroundColor: '#fff3e0' },
    statusCompleted: { backgroundColor: '#e8f5e9' },
    statusText: { fontSize: 12, fontWeight: 'bold', color: '#333' },
    section: {
        marginBottom: 24,
    },
    sectionTitle: {
        fontSize: 14,
        color: '#888',
        marginBottom: 4,
        textTransform: 'uppercase',
        letterSpacing: 1,
    },
    sectionText: {
        fontSize: 16,
        color: '#333',
        fontWeight: '500',
    },
    actions: {
        marginTop: 'auto',
        paddingTop: 20,
    },
    button: {
        paddingVertical: 16,
        borderRadius: 8,
        alignItems: 'center',
    },
    checkInButton: {
        backgroundColor: '#004d40',
    },
    checkOutButton: {
        backgroundColor: '#d32f2f',
    },
    buttonDisabled: {
        opacity: 0.7,
    },
    buttonText: {
        color: '#fff',
        fontSize: 18,
        fontWeight: 'bold',
    },
});
