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
import StaffDashboardScreen from '../screens/dashboard/StaffDashboardScreen';
import ServiceListScreen from '../screens/services/ServiceListScreen';
import ProfileScreen from '../screens/profile/ProfileScreen';
import ChatScreen from '../screens/dashboard/ChatScreen';
import CallScreen from '../screens/dashboard/CallScreen';

// Other Screens
import BookingScreen from '../screens/services/BookingScreen';
import UserLookupScreen from '../screens/profile/UserLookupScreen';

import { MobileAdminRegistry } from 'prime-care-shared';

const { RouteRegistry } = MobileAdminRegistry;

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
            <Tab.Screen name="Hub" component={StaffDashboardScreen} />
            <Tab.Screen name="Users" component={UserLookupScreen} />
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
                        <Stack.Screen name={RouteRegistry.LOGIN} component={LoginScreen} />
                        <Stack.Screen name="MainApp" component={MainTabs} />
                    </>
                ) : (
                    <Stack.Screen name="Main" component={MainTabs} />
                )}

                <Stack.Screen name={RouteRegistry.STAFF_HUB} component={StaffDashboardScreen} options={{ headerShown: true, title: 'Staff Hub' }} />
                <Stack.Screen name={RouteRegistry.MESSAGING} component={ChatScreen} options={{ headerShown: true, title: 'Support Chat' }} />
                <Stack.Screen name={RouteRegistry.USER_LOOKUP} component={UserLookupScreen} options={{ headerShown: true, title: 'User Lookup' }} />
                <Stack.Screen name="Call" component={CallScreen} options={{ headerShown: false }} />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
