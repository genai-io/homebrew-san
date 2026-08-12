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

`Formula/san.rb` is generated from `.github/scripts/san.rb.tmpl` in this repository. A daily job ([sync-formula.yml](.github/workflows/sync-formula.yml)) checks the latest `v*` tag on [genai-io/san](https://github.com/genai-io/san) and regenerates the formula with fresh sha256s whenever a new version is out — `brew upgrade san` picks it up within a day of a release. The whole flow is self-contained and needs no secrets. Please report formula issues on the [san issue tracker](https://github.com/genai-io/san/issues).
