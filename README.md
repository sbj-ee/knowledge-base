# knowledge-base

A searchable [MkDocs Material](https://squidfunk.github.io/mkdocs-material/) site that
aggregates selected **public** engineering references from
[github.com/sbj-ee](https://github.com/sbj-ee), auto-published to GitHub Pages.

Live site: **https://sbj-ee.github.io/knowledge-base/** (after first deploy)

## Why only public sources?

GitHub Pages on a personal/free account is **always world-readable**, even when served
from a private repo (private Pages requires GitHub Enterprise Cloud). To avoid exposing
anything, this site only aggregates content from already-public repos:

- **EE_Ref** (public) → Electrical Engineering reference
- **tmux_cheat_sheet** (public) → tmux cheat sheet
- **Ansible_Playbooks** (public) → Ansible playbooks reference
- **pynetbox_examples** (public) → NetBox automation examples

Private references (e.g. `Notes`, `EE-Book`) are intentionally **excluded**. If you ever
want those searchable, run MkDocs locally (`mkdocs serve`) and don't deploy them.

## Content flow

Source markdown is copied into `docs/` (this repo is the published artifact, the source
repos stay authoritative). `sync.sh` works in two modes off one source manifest:

```bash
./sync.sh                # local: copy from sibling repos under ../
REMOTE=1 ./sync.sh       # remote: fetch latest from raw.githubusercontent.com
```

### Auto-resync

`.github/workflows/resync.yml` keeps the site current automatically. It runs daily (and
on demand), pulls the latest source content in remote mode, commits any changes back, and
redeploys. It's self-contained (sync → build → deploy in one job) because a push made with
the default `GITHUB_TOKEN` does not trigger other workflows.

**Optional — instant updates:** a source repo can notify this one on push instead of
waiting for the daily run. Add a step to the source repo's workflow:

```yaml
- name: Notify knowledge-base
  run: |
    curl -fsSL -X POST \
      -H "Authorization: Bearer ${{ secrets.KB_DISPATCH_TOKEN }}" \
      -H "Accept: application/vnd.github+json" \
      https://api.github.com/repos/sbj-ee/knowledge-base/dispatches \
      -d '{"event_type":"source-updated"}'
```

where `KB_DISPATCH_TOKEN` is a fine-grained PAT with `contents: write` on `knowledge-base`.

## Local development

Uses [uv](https://docs.astral.sh/uv/) (no global installs needed):

```bash
uv venv
uv pip install -r requirements.txt
uv run mkdocs serve      # live preview at http://127.0.0.1:8000
uv run mkdocs build      # static build into ./site
```

## Deployment

Pushing to `main` triggers `.github/workflows/deploy.yml`, which builds the site and
publishes it to GitHub Pages. **One-time setup:** in the repo, go to
*Settings → Pages → Build and deployment → Source* and select **GitHub Actions**.

## Structure

```
knowledge-base/
├── docs/
│   ├── index.md          # landing page
│   ├── ee/index.md       # from EE_Ref
│   ├── tmux/index.md     # from tmux_cheat_sheet
│   ├── ansible/index.md  # from Ansible_Playbooks
│   └── netbox/index.md   # from pynetbox_examples
├── mkdocs.yml
├── requirements.txt
├── sync.sh               # re-copy content from source repos
└── .github/workflows/deploy.yml
```
