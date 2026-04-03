/**
 * Epic 39: Electronic Health Record (EHR) HL7 Bridges
 * 
 * pipeline that natively translates internal PrimeCare JSON objects
 * (e.g., Patient Demographics) into HL7 v2.x pipe-delimited strings to successfully
 * handshake with legacy hospital systems like Epic or Cerner.
 */

interface PrimeCarePatient {
    internalId: string;
    firstName: string;
    lastName: string;
    dob: string; // YYYYMMDD
    gender: 'M' | 'F' | 'O';
    address: string;
}

export class Hl7BridgeConnector {

    /**
     * Converts JSON Demographics into an HL7 ADT^A04 (Register Patient) message.
     */
    static convertToHL7v2(patient: PrimeCarePatient): string {
        const timestamp = new Date().toISOString().replace(/[-:T.]/g, '').substring(0, 14);
        const sendingApp = 'PRIMECARE';
        const receivingApp = 'EPIC_EHR';

        // Message Header Segment
        const msh = `MSH|^~\\&|${sendingApp}|${sendingApp}_FACILITY|${receivingApp}|HOSPITAL_FACILITY|${timestamp}||ADT^A04|MSG${timestamp}|P|2.5.1`;
        
        // Event Type Segment
        const evn = `EVN|A04|${timestamp}`;
        
        // Patient Identification Segment
        const pid = `PID|1||${patient.internalId}^^^PRIMECARE^MR||${patient.lastName}^${patient.firstName}^^^^||${patient.dob}|${patient.gender}|||${patient.address}^^^^|||||||`;
        
        // Additional Demographics Segment (Optional but standard)
        const pd1 = `PD1|||||||||||||||||`;

        const rawHl7 = [msh, evn, pid, pd1].join('\r'); // HL7 requires carriage returns
        
        console.log(`[HL7 Engine] Successfully generated ADT^A04 for ${patient.internalId}.`);
        console.log(`[HL7 Output]:\n${rawHl7.substring(0, 100)}...`);

        return rawHl7;
    }
}
