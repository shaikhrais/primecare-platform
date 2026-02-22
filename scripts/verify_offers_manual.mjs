const API_URL = 'http://127.0.0.1:8787';

async function verify() {
    console.log('--- VERIFY OPEN OFFERS ---');

    // 1. Login
    const loginRes = await fetch(`${API_URL}/v1/auth/login`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            email: 'psw.a@primecare.ca',
            password: 'admin123'
        })
    });

    if (!loginRes.ok) {
        console.error('Login Failed:', await loginRes.text());
        return;
    }

    const { token } = await loginRes.json();
    console.log('Login Success. Token acquired.');

    // 2. Fetch Offers
    const offersRes = await fetch(`${API_URL}/v1/psw/schedule/offers`, {
        headers: { 'Authorization': `Bearer ${token}` }
    });

    if (!offersRes.ok) {
        console.error('Fetch Offers Failed:', await offersRes.text());
        return;
    }

    const offers = await offersRes.json();
    console.log('Open Offers Count:', offers.length);
    console.log('Offers Details:', JSON.stringify(offers, null, 2));

    if (offers.length > 0) {
        const offerId = offers[0].id;
        console.log(`Accepting offer: ${offerId}`);

        const acceptRes = await fetch(`${API_URL}/v1/psw/schedule/offers/${offerId}/accept`, {
            method: 'POST',
            headers: { 'Authorization': `Bearer ${token}` }
        });

        if (acceptRes.ok) {
            console.log('✅ Offer Accepted Successfully');
        } else {
            console.error('Failed to Accept Offer:', await acceptRes.text());
        }
    } else {
        console.log('❌ No offers found in API response.');
    }
}

verify().catch(console.error);
