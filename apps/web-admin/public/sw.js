// Basic Service Worker for PrimeCare
self.addEventListener('install', (event) => {
    console.log('PC ServiceWorker installed');
});

self.addEventListener('activate', (event) => {
    console.log('PC ServiceWorker activated');
});

self.addEventListener('fetch', (event) => {
    // Pass-through for now
});
