# Homebrew tap for san

[san](https://github.com/genai-io/san) — Minimal overhead, maximum agent: a fast, open agent harness for the terminal.

## Install

```bash
brew tap genai-io/san
brew install san
```

## Upgrade

```bash
brew upgrade san
```

**Do not use the built-in `san update` command with a Homebrew install** — it overwrites the binary in place, which would clobber the Homebrew-managed copy inside the Cellar and break `brew upgrade` bookkeeping. If you ran it anyway, repair with `brew reinstall san`.

## How this tap is maintained

`Formula/san.rb` is generated from `.github/scripts/san.rb.tmpl` in the san repository. It is updated automatically whenever a new `v*` tag is released (the san release pipeline runs [release.yml](https://github.com/genai-io/san/blob/main/.github/workflows/release.yml)), and a daily backstop job in this repo ([sync-formula.yml](.github/workflows/sync-formula.yml)) re-checks the latest tag and syncs the formula if anything was missed. Please report formula issues on the [san issue tracker](https://github.com/genai-io/san/issues).
