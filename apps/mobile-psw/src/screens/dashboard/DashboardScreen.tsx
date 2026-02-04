import React from 'react';
import { View, Text, StyleSheet } from 'react-native';
import { PswRegistry } from '@primecare/shared';
const { ContentRegistry } = PswRegistry;

export default function DashboardScreen() {
    return (
        <View style={styles.container}>
            <Text style={styles.text}>{ContentRegistry.DASHBOARD.WELCOME}</Text>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        justifyContent: 'center',
        alignItems: 'center',
    },
    text: {
        fontSize: 20,
        fontWeight: 'bold',
    },
});
