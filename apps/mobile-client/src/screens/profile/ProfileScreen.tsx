import React from 'react';
import { View, Text, StyleSheet, TouchableOpacity } from 'react-native';
import { useAuth } from '../../context/AuthContext';

export default function ProfileScreen() {
    const { user, logout } = useAuth();

    return (
        <View style={styles.container}>
            <View style={styles.header}>
                <View style={styles.avatar}>
                    <Text style={styles.avatarText}>{user?.email?.[0]?.toUpperCase() || 'U'}</Text>
                </View>
                <Text style={styles.email}>{user?.email}</Text>
                <Text style={styles.role}>{user?.role?.toUpperCase()}</Text>
            </View>

            <View style={styles.section}>
                <Text style={styles.sectionTitle}>Account Settings</Text>
                <TouchableOpacity style={styles.menuItem}>
                    <Text>Edit Profile</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.menuItem}>
                    <Text>Payment Methods</Text>
                </TouchableOpacity>
                <TouchableOpacity style={styles.menuItem}>
                    <Text>Notifications</Text>
                </TouchableOpacity>
            </View>

            <TouchableOpacity style={styles.logoutButton} onPress={logout}>
                <Text style={styles.logoutText}>Logout</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        backgroundColor: '#f5f5f5',
    },
    header: {
        backgroundColor: 'white',
        padding: 30,
        alignItems: 'center',
        marginBottom: 20,
    },
    avatar: {
        width: 80,
        height: 80,
        borderRadius: 40,
        backgroundColor: '#004d40',
        justifyContent: 'center',
        alignItems: 'center',
        marginBottom: 10,
    },
    avatarText: {
        color: 'white',
        fontSize: 32,
        fontWeight: 'bold',
    },
    email: {
        fontSize: 18,
        fontWeight: 'bold',
        color: '#333',
    },
    role: {
        color: '#666',
        marginTop: 2,
    },
    section: {
        backgroundColor: 'white',
        padding: 20,
    },
    sectionTitle: {
        fontSize: 16,
        fontWeight: 'bold',
        color: '#004d40',
        marginBottom: 10,
    },
    menuItem: {
        paddingVertical: 15,
        borderBottomWidth: 1,
        borderBottomColor: '#eee',
    },
    logoutButton: {
        marginTop: 20,
        backgroundColor: 'white',
        padding: 15,
        alignItems: 'center',
    },
    logoutText: {
        color: '#ef4444',
        fontWeight: 'bold',
    },
});
