-- Supabase → SQL Editor → New query → পুরোটা paste করে Run
create table if not exists public.books(
  id bigint primary key,
  owner uuid not null default auth.uid() references auth.users(id) on delete cascade,
  title text not null, author text default '', lang text default 'bn', cat text default 'অন্যান্য', status text default 'want',
  page int default 1, pages int default 0, added bigint, last bigint, fin bigint,
  hl jsonb default '[]'::jsonb, ans jsonb, rating int default 0, time int default 0,
  cover text, file boolean default false, offline boolean default false);
create table if not exists public.prefs(
  owner uuid primary key default auth.uid() references auth.users(id) on delete cascade,
  cats jsonb default '[]'::jsonb);

alter table public.books enable row level security;
alter table public.prefs enable row level security;
drop policy if exists "own books" on public.books;
drop policy if exists "own prefs" on public.prefs;
create policy "own books" on public.books for all to authenticated using (owner = auth.uid()) with check (owner = auth.uid());
create policy "own prefs" on public.prefs for all to authenticated using (owner = auth.uid()) with check (owner = auth.uid());
grant usage on schema public to authenticated, anon;
grant select, insert, update, delete on public.books, public.prefs to authenticated;

-- PDF রাখার প্রাইভেট বাকেট
insert into storage.buckets (id, name, public) values ('books','books',false) on conflict (id) do nothing;
drop policy if exists "own files" on storage.objects;
create policy "own files" on storage.objects for all to authenticated
  using (bucket_id = 'books' and (storage.foldername(name))[1] = auth.uid()::text)
  with check (bucket_id = 'books' and (storage.foldername(name))[1] = auth.uid()::text);

-- প্রজেক্ট যেন ঘুমিয়ে না পড়ে, তার জন্য ছোট ping ফাংশন (keepalive workflow ব্যবহার করে)
create or replace function public.ping() returns int language sql as $$ select 1 $$;
grant execute on function public.ping() to anon, authenticated;
