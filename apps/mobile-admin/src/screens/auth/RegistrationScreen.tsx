import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ActivityIndicator } from 'react-native';
// @ts-ignore
import { MOBILE_APP_KEY, API_URL } from '@env';
import { ClientRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = ClientRegistry;

export default function RegistrationScreen({ navigation }: any) {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [errorMessage, setErrorMessage] = useState<string | null>(null);

    const handleRegister = async () => {
        setLoading(true);
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.AUTH.REGISTER}`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json', 'x-mobile-app-key': MOBILE_APP_KEY },
                body: JSON.stringify({ email, password, role: 'client' }),
            });

            if (response.ok) {
                navigation.replace(RouteRegistry.DASHBOARD.HOME);
            } else {
                const data = await response.json();
                setErrorMessage(data.error || 'Registration failed');
            }
        } catch (error) {
            setErrorMessage(ContentRegistry.AUTH.ERRORS.NETWORK);
        } finally {
            setLoading(false);
        }
    };

    return (
        <View style={styles.container}>
            <Text style={styles.title}>{ContentRegistry.AUTH.REGISTER.TITLE}</Text>

            {errorMessage && <Text style={styles.error}>{errorMessage}</Text>}

            <TextInput
                style={styles.input}
                placeholder={ContentRegistry.AUTH.REGISTER.EMAIL_LABEL}
                value={email}
                onChangeText={setEmail}
                autoCapitalize="none"
            />
            <TextInput
                style={styles.input}
                placeholder={ContentRegistry.AUTH.REGISTER.PASSWORD_LABEL}
                value={password}
                onChangeText={setPassword}
                secureTextEntry
            />

            <TouchableOpacity style={styles.button} onPress={handleRegister} disabled={loading}>
                {loading ? <ActivityIndicator color="#fff" /> : <Text style={styles.buttonText}>{ContentRegistry.AUTH.REGISTER.BUTTON}</Text>}
            </TouchableOpacity>

            <TouchableOpacity style={styles.link} onPress={() => navigation.navigate(RouteRegistry.AUTH.LOGIN)}>
                <Text style={styles.linkText}>{ContentRegistry.AUTH.REGISTER.LOGIN_LINK}</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, padding: 20, justifyContent: 'center', backgroundColor: '#fff' },
    title: { fontSize: 24, fontWeight: 'bold', textAlign: 'center', color: '#333', marginBottom: 20 },
    error: { color: 'red', textAlign: 'center', marginBottom: 10 },
    input: { borderWidth: 1, borderColor: '#ddd', padding: 15, borderRadius: 8, marginBottom: 15 },
    button: { backgroundColor: '#007bff', padding: 15, borderRadius: 8, alignItems: 'center' },
    buttonText: { color: '#fff', fontWeight: 'bold' },
    link: { marginTop: 15, alignItems: 'center' },
    linkText: { color: '#007bff' },
});
