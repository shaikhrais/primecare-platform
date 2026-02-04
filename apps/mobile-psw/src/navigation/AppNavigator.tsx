import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';

import LoginScreen from '../screens/auth/LoginScreen';
import RegistrationScreen from '../screens/auth/RegistrationScreen';
import DashboardScreen from '../screens/dashboard/DashboardScreen';
import VisitDetailsScreen from '../screens/dashboard/VisitDetailsScreen';
import TimesheetsScreen from '../screens/dashboard/TimesheetsScreen';
import { PswRegistry } from 'prime-care-shared';

const { RouteRegistry } = PswRegistry;
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
                    options={{ headerTitle: 'My Visits' }}
                />
                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.VISIT_DETAILS}
                    component={VisitDetailsScreen}
                    options={{ title: 'Visit Details' }}
                />
                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.TIMESHEETS}
                    component={TimesheetsScreen}
                    options={{ title: 'My Timesheets' }}
                />
            </Stack.Navigator>
        </NavigationContainer>
    );
}
