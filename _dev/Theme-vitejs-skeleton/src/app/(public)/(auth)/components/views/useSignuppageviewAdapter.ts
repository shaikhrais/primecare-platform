// Prisma Load Adapter React Hook
import { useState, useCallback } from 'react';

export const useSignuppageviewAdapter = () => {
    const [isLoading, setIsLoading] = useState(false);
    const [data, setData] = useState<any>(null);

    const loadData = useCallback(async () => {
        setIsLoading(true);
        // TODO: Prisma DB endpoint fetch
        setData({});
        setIsLoading(false);
    }, []);

    return { isLoading, data, loadData };
};
