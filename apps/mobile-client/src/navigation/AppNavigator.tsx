import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createNativeStackNavigator } from '@react-navigation/native-stack';
import { ClientRegistry } from '@primecare/shared';

import LoginScreen from '../screens/auth/LoginScreen';
import RegistrationScreen from '../screens/auth/RegistrationScreen';
import DashboardScreen from '../screens/dashboard/DashboardScreen';
import BookServiceScreen from '../screens/dashboard/BookServiceScreen';
import ChatScreen from '../screens/dashboard/ChatScreen';

// ...

                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.INVOICES}
                    component={InvoicesScreen}
                    options={{ headerTitle: 'My Invoices' }}
                />
                <Stack.Screen
                    name={RouteRegistry.DASHBOARD.CHAT}
                    component={ChatScreen}
                    options={{ headerTitle: 'Messages' }}
                />
            </Stack.Navigator >
        </NavigationContainer >
    );
}
