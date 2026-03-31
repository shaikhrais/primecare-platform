const testApi = async (url) => {
  try {
    const res = await fetch(url, {
      method: "POST",
      headers: { "Content-Type": "application/json", "X-Requested-With": "XMLHttpRequest" },
      body: JSON.stringify({ email: "itpro.mohammed@gmail.com", password: "password123" })
    });
    const status = res.status;
    const body = await res.text();
    console.log("[" + url + "] -> STATUS: " + status);
    console.log("[" + url + "] -> BODY: " + body);
  } catch (err) {
    console.error("[" + url + "] -> ERROR: " + err.message);
  }
};
(async () => {
   await testApi("http://127.0.0.1:8787/v1/auth/login");
   await testApi("https://primecare-api.itpro-mohammed.workers.dev/v1/auth/login");
})();
