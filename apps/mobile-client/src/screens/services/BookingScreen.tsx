import React, { useState } from 'react';
import { View, Text, TextInput, StyleSheet, TouchableOpacity, Alert, ActivityIndicator } from 'react-native';
import { useAuth, API_URL } from '../../context/AuthContext';

export default function BookingScreen({ route, navigation }: any) {
    const { serviceId, serviceName } = route.params || {};
    const [requestedDate, setRequestedDate] = useState('');
    const [notes, setNotes] = useState('');
    const [loading, setLoading] = useState(false);
    const { token } = useAuth();

    const handleBooking = async () => {
        if (!requestedDate) {
            Alert.alert('Error', 'Please enter a requested date/time');
            return;
        }

        setLoading(true);
        try {
            const response = await fetch(`${API_URL}/v1/client/bookings`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': `Bearer ${token}`
                },
                body: JSON.stringify({
                    serviceId,
                    requestedAt: requestedDate, // API expects ISO string usually, but for now we pass string or handle it
                    notes
                }),
            });

            if (response.ok) {
                Alert.alert('Success', 'Booking request sent!', [
                    { text: 'OK', onPress: () => navigation.navigate('Home') }
                ]);
            } else {
                const data = await response.json();
                Alert.alert('Error', data.error || 'Booking failed');
            }
        } catch (error) {
            Alert.alert('Error', 'Network error');
        } finally {
            setLoading(false);
        }
    };

    return (
        <View style={styles.container}>
            <Text style={styles.title}>Book {serviceName}</Text>

            <Text style={styles.label}>Requested Date/Time (YYYY-MM-DD HH:MM)</Text>
            <TextInput
                style={styles.input}
                placeholder="2026-02-10 09:00"
                value={requestedDate}
                onChangeText={setRequestedDate}
            />

            <Text style={styles.label}>Notes / Special Requests</Text>
            <TextInput
                style={[styles.input, { height: 100 }]}
                placeholder="Any specific details..."
                value={notes}
                onChangeText={setNotes}
                multiline
            />

            <TouchableOpacity style={styles.button} onPress={handleBooking} disabled={loading}>
                {loading ? (
                    <ActivityIndicator color="white" />
                ) : (
                    <Text style={styles.buttonText}>Confirm Booking</Text>
                )}
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 20,
        backgroundColor: '#fff',
    },
    title: {
        fontSize: 24,
        fontWeight: 'bold',
        color: '#004d40',
        marginBottom: 20,
    },
    label: {
        fontSize: 16,
        color: '#333',
        marginBottom: 5,
        fontWeight: '600',
    },
    input: {
        borderColor: '#ddd',
        borderWidth: 1,
        borderRadius: 8,
        padding: 12,
        marginBottom: 20,
        fontSize: 16,
        textAlignVertical: 'top',
    },
    button: {
        backgroundColor: '#004d40',
        padding: 16,
        borderRadius: 8,
        alignItems: 'center',
        marginTop: 10,
    },
    buttonText: {
        color: 'white',
        fontSize: 18,
        fontWeight: 'bold',
    },
});
