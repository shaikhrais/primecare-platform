import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { ActivityIndicator, View } from 'react-native';
import { useAuth } from '../context/AuthContext';

// Auth Screens
import LoginScreen from '../screens/auth/LoginScreen';

// Dashboard Screens
import HomeScreen from '../screens/dashboard/HomeScreen';
import ProfileScreen from '../screens/dashboard/ProfileScreen';

// Visit Screens
import VisitDetailScreen from '../screens/visits/VisitDetailScreen';

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
            <Tab.Screen name="Visits" component={HomeScreen} />
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
                    <Stack.Screen name="Login" component={LoginScreen} />
                ) : (
                    <Stack.Screen name="Main" component={MainTabs} />
                )}

                <Stack.Screen name="VisitDetails" component={VisitDetailScreen} options={{ headerShown: true, title: 'Visit Details' }} />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
