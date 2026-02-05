import { Platform, Alert } from 'react-native';
import { check, request, PERMISSIONS, RESULTS } from 'react-native-permissions';

export const PermissionService = {
    requestNotificationPermission: async () => {
        if (Platform.OS === 'android' && Platform.Version >= 33) {
            const result = await request((PERMISSIONS.ANDROID as any).POST_NOTIFICATIONS);
            return result === RESULTS.GRANTED;
        }
        return true; // iOS handles automatically or older Android
    },
};
