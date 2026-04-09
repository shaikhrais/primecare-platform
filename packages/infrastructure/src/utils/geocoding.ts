/**
 * Geocoding Utility using OpenStreetMap (Nominatim)
 */

export interface GeocodeResult {
    lat: number;
    lng: number;
    display_name?: string;
}

/**
 * Converts an address string into latitude and longitude coordinates.
 * Falls back to 0,0 if not found.
 */
export async function geocodeAddress(address: string): Promise<GeocodeResult | null> {
    if (!address) return null;

    try {
        // We use Nominatim (OSM) for free geocoding. 
        // Note: In production, you might want to use Google Maps or a dedicated service for higher reliability/rate limits.
        const url = `https://nominatim.openstreetmap.org/search?format=json&q=${encodeURIComponent(address)}&limit=1`;

        const response = await fetch(url, {
            headers: {
                'User-Agent': 'PrimeCare-Platform-Dev/1.0'
            }
        });

        if (!response.ok) {
            console.error('Geocoding API error:', response.statusText);
            return null;
        }

        const data: any = await response.json();

        if (data && data.length > 0) {
            return {
                lat: parseFloat(data[0].lat),
                lng: parseFloat(data[0].lon),
                display_name: data[0].display_name
            };
        }

        return null;
    } catch (error) {
        console.error('Geocoding failed:', error);
        return null;
    }
}
