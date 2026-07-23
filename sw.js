const CACHE = 'teach-calendar-v4';
self.addEventListener('install', e => {
  self.skipWaiting();
  e.waitUntil(caches.open(CACHE).then(c => c.addAll(['index.html?v=4','manifest.json?v=4'])));
});
self.addEventListener('activate', e => {
  e.waitUntil(clients.claim());
  // 清除旧缓存
  e.waitUntil(caches.keys().then(keys => Promise.all(keys.filter(k => k !== CACHE).map(k => caches.delete(k)))));
});
self.addEventListener('fetch', e => {
  e.respondWith(
    fetch(e.request).catch(() => caches.match(e.request))
  );
});
