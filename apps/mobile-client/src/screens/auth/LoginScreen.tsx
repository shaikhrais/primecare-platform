import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ActivityIndicator } from 'react-native';
// @ts-ignore
import { MOBILE_APP_KEY, API_URL } from '@env';
import { ClientRegistry } from 'prime-care-shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = ClientRegistry;

export default function LoginScreen({ navigation }: any) {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [errorMessage, setErrorMessage] = useState<string | null>(null);

    const handleLogin = async () => {
        setErrorMessage(null);
        setLoading(true);
        try {
            const response = await fetch(`${API_URL}${ApiRegistry.AUTH.LOGIN}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'x-mobile-app-key': MOBILE_APP_KEY,
                },
                body: JSON.stringify({ email, password }),
            });

            if (response.ok) {
                navigation.replace(RouteRegistry.DASHBOARD.HOME);
            } else {
                const data = await response.json();
                setErrorMessage(data.error || 'Login failed');
            }
        } catch (error) {
            setErrorMessage(ContentRegistry.AUTH.ERRORS.NETWORK);
        } finally {
            setLoading(false);
        }
    };

    return (
        <View style={styles.container}>
            <Text style={styles.title}>{ContentRegistry.APP.NAME}</Text>
            <Text style={styles.subtitle}>{ContentRegistry.APP.TAGLINE}</Text>

            {errorMessage && <Text style={styles.error}>{errorMessage}</Text>}

            <TextInput
                style={styles.input}
                placeholder={ContentRegistry.AUTH.LOGIN.EMAIL_PLACEHOLDER}
                value={email}
                onChangeText={setEmail}
                autoCapitalize="none"
            />
            <TextInput
                style={styles.input}
                placeholder={ContentRegistry.AUTH.LOGIN.PASSWORD_PLACEHOLDER}
                value={password}
                onChangeText={setPassword}
                secureTextEntry
            />

            <TouchableOpacity style={styles.button} onPress={handleLogin} disabled={loading}>
                {loading ? <ActivityIndicator color="#fff" /> : <Text style={styles.buttonText}>{ContentRegistry.AUTH.LOGIN.BUTTON}</Text>}
            </TouchableOpacity>

            <TouchableOpacity style={styles.link} onPress={() => navigation.navigate(RouteRegistry.AUTH.REGISTER)}>
                <Text style={styles.linkText}>{ContentRegistry.AUTH.LOGIN.REGISTER_LINK}</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: { flex: 1, padding: 20, justifyContent: 'center', backgroundColor: '#fff' },
    title: { fontSize: 24, fontWeight: 'bold', textAlign: 'center', color: '#333' },
    subtitle: { fontSize: 16, textAlign: 'center', color: '#666', marginBottom: 30 },
    error: { color: 'red', textAlign: 'center', marginBottom: 10 },
    input: { borderWidth: 1, borderColor: '#ddd', padding: 15, borderRadius: 8, marginBottom: 15 },
    button: { backgroundColor: '#007bff', padding: 15, borderRadius: 8, alignItems: 'center' },
    buttonText: { color: '#fff', fontWeight: 'bold' },
    link: { marginTop: 15, alignItems: 'center' },
    linkText: { color: '#007bff' },
});
