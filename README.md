# ready-word-src

Word Ready production source for the Vercel install-tarball deploy.

`install.sh` downloads `src.tgz.b64` and unpacks the Next.js app, then runs `npm install`.

Default ref is `main`:

```bash
curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/main/install.sh | bash
```

Branch deploy (set both the script URL and `REF` to the same branch):

```bash
curl -fsSL https://raw.githubusercontent.com/GenesisRio/ready-word-src/cursor/magic-link-save-4298/install.sh | REF=cursor/magic-link-save-4298 bash
```

## Auth dashboard (Brady)

Supabase project `ready-word` (`ubttwamfitfmfgyvmrvv`). The Management API was not available from the agent, so confirm these clicks in **Authentication → URL configuration**:

1. Site URL: `https://ready-word.vercel.app`
2. Redirect URLs:
   - `https://ready-word.vercel.app/auth/callback`
   - `https://ready-word-*.vercel.app/auth/callback`
   - `http://127.0.0.1:43147/auth/callback`
   - `http://localhost:43147/auth/callback`
3. **Authentication → Providers → Email**: Email on, magic link on. No password.

A local check showed `http://127.0.0.1:43147/auth/callback` is already accepted on magic-link emails. Production still needs the Site URL and the ready-word.vercel.app callback if they are not listed.

Full notes are in `AUTH.md` inside the tarball.
