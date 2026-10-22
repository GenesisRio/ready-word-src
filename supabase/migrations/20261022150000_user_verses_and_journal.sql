-- My Verses and Journal.
-- NOT applied on project ubttwamfitfmfgyvmrvv (ready-word).
-- Apply this file once in the Supabase SQL editor, or with the Supabase CLI,
-- before signed-in sync can succeed. Until then the app keeps both collections
-- on the phone and does not block guests.
--
-- Own-row RLS matches public.progress: authenticated users read and write
-- only rows where user_id = auth.uid(). Signed-out clients never call these
-- tables. anon is revoked so a missing policy cannot leak rows.

create table if not exists public.user_verses (
  user_id uuid not null references auth.users (id) on delete cascade,
  client_id text not null,
  source text not null,
  verse_key text not null,
  category_id text,
  book_id text not null,
  book_name text not null,
  reference text not null,
  body text not null,
  translation text,
  sample boolean not null default false,
  worked boolean not null default false,
  saved boolean not null default false,
  removed_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, client_id),
  constraint user_verses_source_chk check (source in ('path', 'library')),
  constraint user_verses_category_chk check (
    category_id is null
    or category_id in (
      'fear',
      'anxiety',
      'depression',
      'loneliness',
      'grief',
      'anger',
      'shame',
      'guilt',
      'weariness',
      'doubt',
      'temptation',
      'joy',
      'gratitude'
    )
  ),
  constraint user_verses_client_chk check (char_length(client_id) between 1 and 200),
  constraint user_verses_reference_chk check (char_length(reference) between 1 and 200),
  constraint user_verses_body_chk check (char_length(body) > 0)
);

create table if not exists public.journal_entries (
  user_id uuid not null references auth.users (id) on delete cascade,
  client_id text not null,
  verse_client_id text not null,
  reference text not null,
  body text not null,
  entry_date date not null,
  deleted_at timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  primary key (user_id, client_id),
  constraint journal_entries_client_chk check (char_length(client_id) between 1 and 200),
  constraint journal_entries_verse_chk check (char_length(verse_client_id) between 1 and 200),
  constraint journal_entries_body_chk check (char_length(body) between 1 and 4000)
);

create index if not exists journal_entries_user_verse_idx
  on public.journal_entries (user_id, verse_client_id);

alter table public.user_verses enable row level security;
alter table public.journal_entries enable row level security;
alter table public.user_verses force row level security;
alter table public.journal_entries force row level security;

drop policy if exists "user_verses_select_own" on public.user_verses;
create policy "user_verses_select_own"
  on public.user_verses for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "user_verses_insert_own" on public.user_verses;
create policy "user_verses_insert_own"
  on public.user_verses for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "user_verses_update_own" on public.user_verses;
create policy "user_verses_update_own"
  on public.user_verses for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "user_verses_delete_own" on public.user_verses;
create policy "user_verses_delete_own"
  on public.user_verses for delete
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "journal_entries_select_own" on public.journal_entries;
create policy "journal_entries_select_own"
  on public.journal_entries for select
  to authenticated
  using (auth.uid() = user_id);

drop policy if exists "journal_entries_insert_own" on public.journal_entries;
create policy "journal_entries_insert_own"
  on public.journal_entries for insert
  to authenticated
  with check (auth.uid() = user_id);

drop policy if exists "journal_entries_update_own" on public.journal_entries;
create policy "journal_entries_update_own"
  on public.journal_entries for update
  to authenticated
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

drop policy if exists "journal_entries_delete_own" on public.journal_entries;
create policy "journal_entries_delete_own"
  on public.journal_entries for delete
  to authenticated
  using (auth.uid() = user_id);

revoke all on table public.user_verses from public, anon;
revoke all on table public.journal_entries from public, anon;
grant select, insert, update, delete on table public.user_verses to authenticated, service_role;
grant select, insert, update, delete on table public.journal_entries to authenticated, service_role;
