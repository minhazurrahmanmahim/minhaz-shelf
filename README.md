# Minhaz's Shelf — সেটআপ (একবারই করতে হবে)

## ১) Supabase প্রজেক্ট (ফ্রি)
1. supabase.com → সাইন আপ → **New project** (Region: Singapore, একটা ডাটাবেস পাসওয়ার্ড দিন, সেভ করে রাখুন)।
2. **SQL Editor** → New query → `setup.sql` এর পুরোটা paste → **Run**।
3. **Authentication → Users → Add user → Create new user**: আপনার ইমেইল + শক্ত পাসওয়ার্ড দিন, **Auto Confirm User** টিক দিন। (এটাই আপনার ওয়েবসাইটের পাসওয়ার্ড)
4. ইউজার বানানোর **পরে** Authentication-এর সেটিংসে (Sign In / Providers → Email) **"Allow new users to sign up" বন্ধ** করুন, যাতে আর কেউ অ্যাকাউন্ট খুলতে না পারে।
5. **Project Settings → API Keys** থেকে **Project URL** ও **Publishable key** (`sb_publishable_...`) কপি করুন। Publishable key না দেখালে "Create new API keys" চাপুন।

## ২) config.js
`config.js` খুলে url, key, email বসান (email = ৩ নম্বর ধাপের ইমেইল)।

## ৩) GitHub Pages
সব ফাইল (`.github` ফোল্ডারসহ) repo-তে আপলোড → Settings → Pages → Branch `main` / root।
লিংক: `https://USERNAME.github.io/REPO/`

## ৪) (গুরুত্বপূর্ণ) প্রজেক্ট যেন ঘুমিয়ে না পড়ে
Supabase ফ্রি প্রজেক্ট ৭ দিন কোনো কাজ না হলে pause হয়। এটা ঠেকাতে repo → Settings → Secrets and variables → Actions-এ দুটো secret দিন:
`SUPABASE_URL` (Project URL) ও `SUPABASE_KEY` (Publishable key)।
তারপর Actions ট্যাব থেকে `keepalive` একবার **Run workflow** চাপুন। এরপর প্রতি ৩ দিনে নিজে নিজে ping যাবে।

## পাসওয়ার্ড বদলাতে
অ্যাপের ⚙️ সেটিংস → "পাসওয়ার্ড বদলান"।
