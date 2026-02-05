import React, { useEffect, useState } from 'react';
import { View, Text, StyleSheet, FlatList, TouchableOpacity, ActivityIndicator } from 'react-native';
import { API_URL } from '../../context/AuthContext';

interface Service {
    id: string;
    name: string;
    description: string;
    price: number;
}

export default function ServiceListScreen({ navigation }: any) {
    const [services, setServices] = useState<Service[]>([]);
    const [loading, setLoading] = useState(true);

    useEffect(() => {
        fetchServices();
    }, []);

    const fetchServices = async () => {
        try {
            const response = await fetch(`${API_URL}/v1/public/services`);
            const data = await response.json();
            if (Array.isArray(data)) {
                setServices(data);
            }
        } catch (error) {
            console.error(error);
        } finally {
            setLoading(false);
        }
    };

    const renderItem = ({ item }: { item: Service }) => (
        <TouchableOpacity
            style={styles.card}
            onPress={() => navigation.navigate('Booking', { serviceId: item.id, serviceName: item.name })}
        >
            <View style={styles.row}>
                <Text style={styles.name}>{item.name}</Text>
                <Text style={styles.price}>${item.price}</Text>
            </View>
            <Text style={styles.description} numberOfLines={2}>{item.description}</Text>
        </TouchableOpacity>
    );

    if (loading) {
        return (
            <View style={styles.center}>
                <ActivityIndicator size="large" color="#004d40" />
            </View>
        );
    }

    return (
        <View style={styles.container}>
            <FlatList
                data={services}
                renderItem={renderItem}
                keyExtractor={item => item.id}
                contentContainerStyle={styles.list}
            />
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f5f5f5',
    },
    center: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
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
    name: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#333',
        flex: 1,
    },
    price: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#004d40',
    },
    description: {
        color: '#666',
        fontSize: 14,
    },
});
