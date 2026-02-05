import { Platform, Alert } from 'react-native';
import { check, request, PERMISSIONS, RESULTS } from 'react-native-permissions';

export const PermissionService = {
    requestNotificationPermission: async () => {
        if (Platform.OS === 'android' && Platform.Version >= 33) {
            const result = await request((PERMISSIONS.ANDROID as any).POST_NOTIFICATIONS);
            return result === RESULTS.GRANTED;
        }
        return true;
    },

    requestLocationPermission: async () => {
        let permission = Platform.OS === 'android'
            ? PERMISSIONS.ANDROID.ACCESS_FINE_LOCATION
            : PERMISSIONS.IOS.LOCATION_WHEN_IN_USE;

        const result = await request(permission);

        if (result === RESULTS.BLOCKED) {
            Alert.alert('Permission Required', 'Please enable location services in settings to check in.');
            return false;
        }

        return result === RESULTS.GRANTED;
    },
};
