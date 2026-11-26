# open-heavy-machinery.github.io

The website of [Open Heavy Machinery](https://open-heavy-machinery.github.io): open tools to practise and develop embedded control for machines you cannot keep at home, starting with heavy machinery.

Plain HTML and CSS, served by GitHub Pages from `main`. There is no build step and no framework, and no external requests: no web fonts, no scripts from a CDN.

## Pages

| Path | Page |
|---|---|
| `index.html` | The organisation: mission, how it started, the projects, how they fit, verified results, roadmap overview, principles, how to get involved |
| `open-tick/index.html` | open-tick, the core: what runs in v0.2 (with the oracle), the flywheel example, transports and the fidelity contract, the extraction from open-crank, roadmap |
| `open-crank/index.html` | open-crank, the heavy-duty diesel: J1939 frames, the hoist step chart, how it works, quick start, roadmap |
| `assets/site.css` | Shared styles. The palette and type are defined once in `:root` |
| `assets/logo/` | The logo as SVG, PNG and JPG (mark, light mark, icon, wordmarks), its inline HTML ready to paste, and the palette, on a page of its own (`assets/logo/index.html`) |

Each page has its own social card (`og-card.png`, `open-tick/og-card.png`, `open-crank/og-card.png`).

## Preview

Open `index.html` in a browser. Every link between pages is relative, so the site works from the file system as well as from GitHub Pages.

## Social cards

`tools/og/render.sh` renders the three cards from the HTML templates in `tools/og/`, with headless Chrome. The data in each card is real: open-tick's `examples/flywheel/delay.frames.csv`, and for open-crank a run of `open-crank-run scenarios/hoist_step.csv` (the template says which commit). Re-render them when a version on the site changes.

## Logo files

The SVGs in `assets/logo/` are the source. `tools/logo/render.sh` renders the PNG and JPG versions from them, with headless Chrome (transparent background) and Pillow.

## Keeping it true

Every number on the site comes from a project's code or CI: the hoist chart from `open-crank-run scenarios/hoist_step.csv`, the flywheel chart from `otk-flywheel examples/flywheel/step.csv`, the trace comparison from open-crank#1's CI. When a project changes, regenerate the number or remove it.

The mission, the project list, their statuses and their roadmaps must agree with each project's README and ROADMAP and with the organisation profile ([`.github`](https://github.com/Open-Heavy-Machinery/.github)). Change them together. Anything that does not exist yet is marked *planned*.

## License

Apache-2.0.
