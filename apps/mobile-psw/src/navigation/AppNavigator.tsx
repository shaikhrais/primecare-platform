import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import LoginScreen from '../screens/auth/LoginScreen';
import DashboardScreen from '../screens/dashboard/DashboardScreen';
import { PswRegistry } from '@primecare/shared';
const { RouteRegistry, ContentRegistry } = PswRegistry;

const Stack = createNativeStackNavigator();

export default function AppNavigator() {
    return (
        <NavigationContainer>
            <Stack.Navigator initialRouteName={RouteRegistry.AUTH.LOGIN}>
                <Stack.Screen
                    name={RouteRegistry.AUTH.LOGIN}
                    component={LoginScreen}
                    options={{ headerShown: false }}
                />
                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.HOME}
                    component={DashboardScreen}
                    options={{ headerTitle: 'My Visits' }}
                />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
