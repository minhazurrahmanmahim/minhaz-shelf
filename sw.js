const C='shelf-v2',F=['./','index.html','config.js','manifest.webmanifest','icon-192.png','icon-512.png'];
self.addEventListener('install',e=>{e.waitUntil(caches.open(C).then(c=>c.addAll(F)));self.skipWaiting()});
self.addEventListener('activate',e=>{e.waitUntil(caches.keys().then(k=>Promise.all(k.filter(x=>x!=C).map(x=>caches.delete(x)))));clients.claim()});
self.addEventListener('fetch',e=>{const u=new URL(e.request.url);
 if(e.request.method!='GET'||u.hostname.endsWith('supabase.co'))return; // ডেটা/লগইন কখনো ক্যাশ হবে না
 e.respondWith(caches.match(e.request).then(r=>{const n=fetch(e.request).then(res=>{if(res&&(res.ok||res.type=='opaque')){const cp=res.clone();caches.open(C).then(c=>c.put(e.request,cp))}return res}).catch(()=>r||caches.match('./'));return r||n}))});
