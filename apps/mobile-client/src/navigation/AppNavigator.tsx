import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { ClientRegistry } from '@primecare/shared';

import LoginScreen from '../screens/auth/LoginScreen';
import RegistrationScreen from '../screens/auth/RegistrationScreen';
import DashboardScreen from '../screens/dashboard/DashboardScreen';
import BookServiceScreen from '../screens/dashboard/BookServiceScreen';

const { RouteRegistry } = ClientRegistry;
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
                    name={RouteRegistry.AUTH.REGISTER}
                    component={RegistrationScreen}
                    options={{ headerShown: false }}
                />
                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.HOME}
                    component={DashboardScreen}
                    options={{ headerTitle: 'My Services' }}
                />
                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.BOOK_SERVICE}
                    component={BookServiceScreen}
                    options={{ headerTitle: 'Book Service' }}
                />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
