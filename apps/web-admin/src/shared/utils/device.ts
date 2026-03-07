export const getDeviceId = () => {
    let deviceId = localStorage.getItem('pc_device_id');
    if (!deviceId) {
        deviceId = crypto.randomUUID();
        localStorage.setItem('pc_device_id', deviceId);
    }
    return deviceId;
};

export const getDeviceMetadata = () => {
    const ua = navigator.userAgent;
    let type = 'Desktop';
    if (/mobile/i.test(ua)) type = 'Mobile';
    if (/tablet/i.test(ua)) type = 'Tablet';

    let name = 'Unknown Browser';
    if (/chrome/i.test(ua)) name = 'Chrome';
    else if (/firefox/i.test(ua)) name = 'Firefox';
    else if (/safari/i.test(ua) && !/chrome/i.test(ua)) name = 'Safari';
    else if (/edge/i.test(ua)) name = 'Edge';

    const platform = (navigator as any).platform || 'Unknown OS';

    return {
        id: getDeviceId(),
        name: `${name} on ${platform}`,
        type
    };
};
