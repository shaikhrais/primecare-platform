import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { ActivityIndicator, View } from 'react-native';
import { useAuth } from '../context/AuthContext';

// Auth Screens
import LoginScreen from '../screens/auth/LoginScreen';
import RegisterScreen from '../screens/auth/RegisterScreen';

// Dashboard Screens
import HomeScreen from '../screens/dashboard/HomeScreen';
import ServiceListScreen from '../screens/services/ServiceListScreen';
import ProfileScreen from '../screens/profile/ProfileScreen';
import ChatScreen from '../screens/dashboard/ChatScreen';
import CallScreen from '../screens/dashboard/CallScreen';

// Other Screens
import BookingScreen from '../screens/services/BookingScreen';

const Stack = createNativeStackNavigator();
const Tab = createBottomTabNavigator();

function MainTabs() {
    return (
        <Tab.Navigator
            screenOptions={{
                headerShown: true,
                tabBarActiveTintColor: '#004d40',
                tabBarInactiveTintColor: 'gray',
            }}
        >
            <Tab.Screen name="Home" component={HomeScreen} />
            <Tab.Screen name="Services" component={ServiceListScreen} />
            <Tab.Screen name="Profile" component={ProfileScreen} />
        </Tab.Navigator>
    );
}

export default function AppNavigator() {
    const { token, isLoading } = useAuth();

    if (isLoading) {
        return (
            <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }}>
                <ActivityIndicator size="large" color="#004d40" />
            </View>
        );
    }

    return (
        <NavigationContainer>
            <Stack.Navigator screenOptions={{ headerShown: false }}>
                {!token ? (
                    <>
                        <Stack.Screen name="Login" component={LoginScreen} />
                        <Stack.Screen name="Register" component={RegisterScreen} />
                        {/* Backdoor for dev access to main app without login */}
                        <Stack.Screen name="MainApp" component={MainTabs} />
                    </>
                ) : (
                    <Stack.Screen name="Main" component={MainTabs} />
                )}

                {/* Common Screens accessible from anywhere or specifically Main */}
                <Stack.Screen name="Booking" component={BookingScreen} options={{ headerShown: true, title: 'Book Service' }} />
                <Stack.Screen name="Chat" component={ChatScreen} options={{ headerShown: true, title: 'Messages' }} />
                <Stack.Screen name="Call" component={CallScreen} options={{ headerShown: false }} />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
