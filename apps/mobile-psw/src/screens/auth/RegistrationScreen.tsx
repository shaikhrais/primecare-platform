import React, { useState } from 'react';
import { View, Text, TextInput, TouchableOpacity, StyleSheet, ActivityIndicator } from 'react-native';
// @ts-ignore
import { MOBILE_APP_KEY, API_URL } from '@env';
import { PswRegistry } from '@primecare/shared';

const { ApiRegistry, ContentRegistry, RouteRegistry } = PswRegistry;

export default function RegistrationScreen({ navigation }: any) {
    const [email, setEmail] = useState('');
    const [password, setPassword] = useState('');
    const [confirmPassword, setConfirmPassword] = useState('');
    const [loading, setLoading] = useState(false);
    const [errorMessage, setErrorMessage] = useState<string | null>(null);

    const validateEmail = (email: string) => {
        const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        return re.test(email);
    };

    const handleRegister = async () => {
        setErrorMessage(null);

        if (!email || !password || !confirmPassword) {
            setErrorMessage(ContentRegistry.AUTH.ERRORS.VALIDATION_MISSING);
            return;
        }
        if (!validateEmail(email)) {
            setErrorMessage(ContentRegistry.AUTH.ERRORS.VALIDATION_EMAIL);
            return;
        }
        if (password !== confirmPassword) {
            setErrorMessage("Passwords do not match.");
            return;
        }

        setLoading(true);
        try {
            const timeoutPromise = new Promise((_, reject) =>
                setTimeout(() => reject(new Error('TIMEOUT')), 10000)
            );

            const fetchPromise = fetch(`${API_URL}${ApiRegistry.AUTH.REGISTER}`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                    'x-mobile-app-key': MOBILE_APP_KEY,
                },
                body: JSON.stringify({ email, password, role: 'psw' }),
            });

            const response: any = await Promise.race([fetchPromise, timeoutPromise]);

            if (response.status >= 500) {
                setErrorMessage(ContentRegistry.AUTH.ERRORS.SERVER_ERROR);
                return;
            }

            let data;
            try {
                data = await response.json();
            } catch (e) {
                setErrorMessage(ContentRegistry.AUTH.ERRORS.INVALID_RESPONSE);
                return;
            }

            if (response.ok) {
                // Auto-login or navigate to Dashboard
                navigation.replace(RouteRegistry.DASHBOARD.HOME);
            } else {
                setErrorMessage(data.error || 'Registration failed.');
            }
        } catch (error: any) {
            console.error('Registration Error:', error);
            if (error.message === 'TIMEOUT') {
                setErrorMessage(ContentRegistry.AUTH.ERRORS.TIMEOUT);
            } else if (error.message === 'Network request failed') {
                setErrorMessage(ContentRegistry.AUTH.ERRORS.NETWORK);
            } else {
                setErrorMessage(ContentRegistry.AUTH.ERRORS.UNKNOWN);
            }
        } finally {
            setLoading(false);
        }
    };

    return (
        <View style={styles.container}>
            <Text style={styles.title}>{ContentRegistry.AUTH.REGISTER.TITLE}</Text>
            <Text style={styles.subtitle}>{ContentRegistry.AUTH.REGISTER.SUBTITLE}</Text>

            {errorMessage && (
                <View style={styles.errorContainer}>
                    <Text style={styles.errorText}>{errorMessage}</Text>
                </View>
            )}

            <View style={styles.inputContainer}>
                <Text style={styles.label}>{ContentRegistry.AUTH.REGISTER.EMAIL_LABEL}</Text>
                <TextInput
                    style={styles.input}
                    placeholder={ContentRegistry.AUTH.LOGIN.EMAIL_PLACEHOLDER}
                    value={email}
                    onChangeText={(text) => { setEmail(text); setErrorMessage(null); }}
                    autoCapitalize="none"
                    keyboardType="email-address"
                />
            </View>

            <View style={styles.inputContainer}>
                <Text style={styles.label}>{ContentRegistry.AUTH.REGISTER.PASSWORD_LABEL}</Text>
                <TextInput
                    style={styles.input}
                    placeholder={ContentRegistry.AUTH.LOGIN.PASSWORD_PLACEHOLDER}
                    value={password}
                    onChangeText={(text) => { setPassword(text); setErrorMessage(null); }}
                    secureTextEntry
                />
            </View>

            <View style={styles.inputContainer}>
                <Text style={styles.label}>{ContentRegistry.AUTH.REGISTER.CONFIRM_PASSWORD_LABEL}</Text>
                <TextInput
                    style={styles.input}
                    placeholder={ContentRegistry.AUTH.LOGIN.PASSWORD_PLACEHOLDER}
                    value={confirmPassword}
                    onChangeText={(text) => { setConfirmPassword(text); setErrorMessage(null); }}
                    secureTextEntry
                />
            </View>

            <TouchableOpacity
                style={[styles.button, loading && styles.buttonDisabled]}
                onPress={handleRegister}
                disabled={loading}
            >
                {loading ? (
                    <ActivityIndicator color="#fff" />
                ) : (
                    <Text style={styles.buttonText}>{ContentRegistry.AUTH.REGISTER.BUTTON}</Text>
                )}
            </TouchableOpacity>

            <TouchableOpacity style={styles.linkButton} onPress={() => navigation.navigate(RouteRegistry.AUTH.LOGIN)}>
                <Text style={styles.linkText}>{ContentRegistry.AUTH.REGISTER.LOGIN_LINK}</Text>
            </TouchableOpacity>
        </View>
    );
}

const styles = StyleSheet.create({
    container: {
        flex: 1,
        padding: 24,
        justifyContent: 'center',
        backgroundColor: '#fff',
    },
    title: {
        fontSize: 28,
        fontWeight: 'bold',
        color: '#004d40',
        marginBottom: 8,
        textAlign: 'center',
    },
    subtitle: {
        fontSize: 16,
        color: '#666',
        textAlign: 'center',
        marginBottom: 40,
    },
    errorContainer: {
        backgroundColor: '#ffebee',
        padding: 12,
        borderRadius: 8,
        marginBottom: 20,
        borderWidth: 1,
        borderColor: '#ffcdd2',
    },
    errorText: {
        color: '#b71c1c',
        fontSize: 14,
        textAlign: 'center',
    },
    inputContainer: {
        marginBottom: 20,
    },
    label: {
        fontSize: 14,
        color: '#333',
        marginBottom: 8,
        fontWeight: '500',
    },
    input: {
        height: 50,
        borderWidth: 1,
        borderColor: '#ddd',
        borderRadius: 8,
        paddingHorizontal: 16,
        fontSize: 16,
        backgroundColor: '#fafafa',
    },
    button: {
        height: 52,
        backgroundColor: '#004d40',
        borderRadius: 8,
        justifyContent: 'center',
        alignItems: 'center',
        marginTop: 20,
        elevation: 2,
    },
    buttonDisabled: {
        backgroundColor: '#a5d6a7',
    },
    buttonText: {
        color: '#fff',
        fontSize: 16,
        fontWeight: 'bold',
    },
    linkButton: {
        marginTop: 20,
        alignItems: 'center',
    },
    linkText: {
        color: '#004d40',
        fontSize: 14,
        fontWeight: '600',
    }
});
