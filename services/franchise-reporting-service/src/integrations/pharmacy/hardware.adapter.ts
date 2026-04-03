// hardware.adapter.ts
// Generic Interface layer for Automated Dispensing Cabinets (ADC) and Barcode Scanners (BCMA)

interface DispenseRequest {
    orderId: string;
    patientId: string;
    ndc: string; // National Drug Code
    quantity: number;
    machineIp?: string;
}

interface ScanVerificationParams {
    ndc: string;
    patientId: string;
    expectedNdc: string; // The drug they were supposed to scan
}

/**
 * Mocks the HL7 or RESTful dispatch to a physical ADC (e.g. Pyxis / Omnicell).
 */
export async function dispatchDispenser(req: DispenseRequest): Promise<{ status: string, message: string }> {
    console.log(`[HARDWARE_ADAPTER] Dispatching ADC Command to IP: ${req.machineIp || 'Local Sandbox'}`);
    console.log(`[HARDWARE_ADAPTER] Payload: Order ${req.orderId} | NDC ${req.ndc} | QTY ${req.quantity}`);

    // Simulate hardware networking delay (pinging the cabinet)
    await new Promise(resolve => setTimeout(resolve, 800));

    // For demonstration, we simply return a successful ack.
    // In production, this would parse an HL7 ACK or REST 200 OK.
    return {
        status: 'DISPENSING',
        message: 'Cabinet drawer 4A unlocked. Awaiting physical retrieval.',
    };
}

/**
 * Validates a BCMA (Barcode Medication Administration) USB/Bluetooth wedge scanner input.
 */
export function verifyBarcodeScan(params: ScanVerificationParams): { valid: boolean, error?: string } {
    console.log(`[HARDWARE_ADAPTER] Verifying Scanner Input: ${params.ndc}`);
    
    // Simulate typical 10-11 digit NDC extraction formatting if needed
    const cleanNdc = params.ndc.replace(/-/g, '').trim();
    const cleanExpected = params.expectedNdc.replace(/-/g, '').trim();

    if (cleanNdc !== cleanExpected) {
        return {
            valid: false,
            error: 'CRITICAL: Medication mismatch detected. The scanned barcode does not match the active MAR order.'
        };
    }

    return { valid: true };
}
