/**
 * Calculates the great-circle distance between two points on a sphere given their longitudes and latitudes.
 * Returns geographical distance in physical kilometers.
 */
export function calculateHaversineDistanceKm(lat1: number, lon1: number, lat2: number, lon2: number): number {
  const R = 6371; // Earth's radius in km
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLon = (lon2 - lon1) * Math.PI / 180;
  const a = 
    Math.sin(dLat/2) * Math.sin(dLat/2) +
    Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) * 
    Math.sin(dLon/2) * Math.sin(dLon/2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  return R * c;
}

/**
 * Ranks a list of idle field workers by closest physical distance to an unassigned target shift.
 * Defends the network by filtering out toxic workers (TrustScore < 70) from priority dispatching.
 */
export function rankClosestWorkers(
    shiftLat: number, 
    shiftLng: number, 
    idleWorkers: Array<{id: string, lat: number, lng: number, trustScore: number}>
) {
    return idleWorkers
        // Absolute Algorithmic Shield: Hide premium critical shifts from unreliable workers natively
        .filter(w => w.trustScore >= 70) 
        .map(w => ({
            ...w,
            distanceKm: calculateHaversineDistanceKm(shiftLat, shiftLng, w.lat, w.lng)
        }))
        .sort((a, b) => a.distanceKm - b.distanceKm);
}
