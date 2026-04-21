// Prisma Load Adapter React Hook
import { useState, useCallback } from 'react';

export const useNavbarlayout3Adapter = () => {
    const [isLoading, setIsLoading] = useState(false);
    const [data, setData] = useState<any>(null);

    const loadData = useCallback(async () => {
        setIsLoading(true);
        // NOTE: Prisma DB endpoint fetch
        setData({});
        setIsLoading(false);
    }, []);

    return { isLoading, data, loadData };
};
