# sandbox.metasift.org — placeholder landing page

A single static HTML page that holds the `sandbox.metasift.org` subdomain
while the full live sandbox is being built. Ships with the hackathon
submission so the URL in the README and submission form actually resolves
to something useful (demo video + clone instructions) instead of a 404.

## Why this exists

The full sandbox spec lives in
[`metasift/SANDBOX_DEPLOYMENT_PLAN.md`](../metasift/SANDBOX_DEPLOYMENT_PLAN.md):
a Hostinger KVM2 VPS running the OpenMetadata Docker stack, FastAPI in
read-only `SANDBOX_MODE=1`, Caddy with rate-limiting, BYO OpenRouter key,
and a daily reset timer. That's a real ~10–15 hour build that wasn't worth
squeezing into the pre-submission window.

This page is the v0 stand-in: zero ops, zero recurring cost, ships in a
minute. Visitors who land at `sandbox.metasift.org` get the demo video,
a quickstart, and a clear "Open in Codespaces" CTA — enough to evaluate
MetaSift without us having to run it for them.

## Files

```
sandbox/
├── index.html   ← the entire page (self-contained, no build step)
└── README.md    ← this file
```

The page is one file by design. Inlines the logo SVG, inlines the CSS,
and pulls Inter + JetBrains Mono from Google Fonts. Hosts anywhere that
can serve static files.

## Preview locally

```bash
cd sandbox
python3 -m http.server 8080
# → http://localhost:8080
```

Or just open `index.html` directly in a browser — there's no JS runtime
to hydrate.

## Deploy

Three reasonable options, ranked by setup time:

| Host | Setup | Cost | Best for |
| --- | --- | --- | --- |
| **Cloudflare Pages** | `wrangler pages deploy sandbox/` or git-connect this folder | Free | Recommended. Free TLS, global CDN, custom domain in 2 clicks. |
| **Railway** | New static service, point at `sandbox/`, set custom domain | Bundled in existing plan | Easy if Railway already hosts the marketing site. |
| **GitHub Pages** | Push `sandbox/` to a branch, set Pages source | Free | Slowest to set up custom domain, but works. |

Whichever you pick, point the `sandbox` DNS record at the host and let
Let's Encrypt / Cloudflare provision the cert.

## Things to update over time

- **`https://youtu.be/-8sh1UNwvKI`** — the demo video URL on the
  "Watch the demo" CTA. Already wired; replace if the video is
  re-uploaded or moved.
- **`blueberrylinux/metasift`** — the GitHub org/repo path. Used in five
  places (View on GitHub, Codespaces, Docs link, footer source link,
  status card). Find-and-replace if the repo moves.
- **Status card copy** — the "Why is the live sandbox not up yet?"
  paragraph should change tone once the real sandbox launches (see
  retirement below).

## Retirement plan

When the real sandbox at `sandbox.metasift.org` ships per the deployment
plan:

1. Repoint the `sandbox` DNS record from this static host to the VPS.
2. Archive (don't delete) this folder — it's a useful template for the
   next "we need a placeholder fast" moment.
3. Update [`SANDBOX_DEPLOYMENT_PLAN.md`](../metasift/SANDBOX_DEPLOYMENT_PLAN.md)
   §15 (Implementation order) to mark the placeholder phase complete.
