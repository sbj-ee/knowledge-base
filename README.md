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
repos stay authoritative). Re-sync after editing a source repo:

```bash
./sync.sh
```

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
