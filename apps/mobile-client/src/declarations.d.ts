declare module 'react-native-permissions' {
    export const check: any;
    export const request: any;
    export const PERMISSIONS: {
        ANDROID: {
            POST_NOTIFICATIONS: string;
            ACCESS_FINE_LOCATION: string;
            ACCESS_COARSE_LOCATION: string;
            [key: string]: string;
        };
        IOS: {
            LOCATION_WHEN_IN_USE: string;
            [key: string]: string;
        };
    };
    export const RESULTS: {
        GRANTED: string;
        DENIED: string;
        BLOCKED: string;
        UNAVAILABLE: string;
    };
}
