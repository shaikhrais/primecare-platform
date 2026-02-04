import React, { useState, useEffect } from 'react';
import { View, Text, StyleSheet, TouchableOpacity, FlatList, TextInput, ActivityIndicator, Alert } from 'react-native';
import { ClientRegistry } from 'prime-care-shared';
import { BookingsService, Service } from '../../services/BookingsService';

const { ContentRegistry, RouteRegistry } = ClientRegistry;

export default function BookServiceScreen({ navigation }: any) {
    const [services, setServices] = useState<Service[]>([]);
    const [selectedService, setSelectedService] = useState<string | null>(null);
    const [date, setDate] = useState(new Date().toISOString().slice(0, 16).replace('T', ' ')); // Simple text input for now
    const [loading, setLoading] = useState(false);

    useEffect(() => {
        loadServices();
    }, []);

    const loadServices = async () => {
        try {
            const data = await BookingsService.getServices();
            setServices(data);
        } catch (error) {
            Alert.alert('Error', 'Failed to load services');
        }
    };

    const handleBooking = async () => {
        if (!selectedService) {
            Alert.alert('Error', 'Please select a service');
            return;
        }

        setLoading(true);
        try {
            // Convert simple text date to ISO string for API
            const isoDate = new Date(date).toISOString();
            await BookingsService.createBooking(selectedService, isoDate);
            Alert.alert('Success', ContentRegistry.BOOKING.SUCCESS);
            navigation.navigate(RouteRegistry.DASHBOARD.HOME);
        } catch (error) {
            Alert.alert('Error', 'Booking failed. Please check the date format (YYYY-MM-DD HH:MM).');
        } finally {
            setLoading(false);
        }
    };

    const renderItem = ({ item }: { item: Service }) => (
        <TouchableOpacity
            style={[styles.card, selectedService === item.id && styles.cardSelected]}
            onPress={() => setSelectedService(item.id)}
        >
            <View>
                <Text style={styles.serviceName}>{item.name}</Text>
                <Text style={styles.servicePrice}>${item.price}</Text>
            </View>
            <Text style={styles.serviceDesc}>{item.description}</Text>
        </TouchableOpacity>
    );

    return (
        <View style={styles.container}>
            <Text style={styles.title}>{ContentRegistry.BOOKING.SELECT_SERVICE}</Text>
            <FlatList
                data={services}
                renderItem={renderItem}
                keyExtractor={(item) => item.id}
                style={styles.list}
            />

            <View style={styles.form}>
                <Text style={styles.label}>{ContentRegistry.BOOKING.SELECT_DATE}</Text>
                <TextInput
                    style={styles.input}
                    value={date}
                    onChangeText={setDate}
                    placeholder="YYYY-MM-DD HH:MM"
                />

                <TouchableOpacity
                    style={[styles.button, loading && styles.buttonDisabled]}
                    onPress={handleBooking}
                    disabled={loading}
                >
                    {loading ? <ActivityIndicator color="#fff" /> :
                        <Text style={styles.buttonText}>{ContentRegistry.BOOKING.BUTTON}</Text>}
                </TouchableOpacity>
            </View>
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, padding: 20, backgroundColor: '#f9f9f9' },
    title: { fontSize: 20, fontWeight: 'bold', marginBottom: 15, color: '#333' },
    list: { marginBottom: 20 },
    card: {
        backgroundColor: '#fff',
        padding: 15,
        borderRadius: 8,
        marginBottom: 10,
        borderWidth: 1,
        borderColor: '#ddd',
    },
    cardSelected: {
        borderColor: '#007bff',
        backgroundColor: '#e3f2fd',
    },
    serviceName: { fontSize: 16, fontWeight: 'bold', color: '#333' },
    servicePrice: { fontSize: 14, color: '#007bff', fontWeight: 'bold', marginTop: 2 },
    serviceDesc: { fontSize: 14, color: '#666', marginTop: 5 },
    form: {
        backgroundColor: '#fff',
        padding: 15,
        borderRadius: 8,
        elevation: 3,
    },
    label: { fontSize: 14, marginBottom: 5, color: '#333' },
    input: {
        borderWidth: 1,
        borderColor: '#ddd',
        borderRadius: 5,
        padding: 10,
        marginBottom: 15,
        fontSize: 16,
    },
    button: { backgroundColor: '#007bff', padding: 15, borderRadius: 8, alignItems: 'center' },
    buttonDisabled: { backgroundColor: '#aad1f7' },
    buttonText: { color: '#fff', fontWeight: 'bold' },
});
