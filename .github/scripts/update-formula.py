#!/usr/bin/env python3
"""
Homebrew tap formula updater for genai-io/san.

Regenerates Formula/san.rb from the template san.rb.tmpl, substituting the
release tag and the sha256 of the four release tarballs (darwin/linux ×
amd64/arm64). Runs from this tap's sync-formula.yml workflow when the
formula is stale, so the formula always references existing artifacts.

Usage:
  python3 .github/scripts/update-formula.py --version v1.22.2 \
      --tarballs bin/san_darwin_arm64.tar.gz bin/san_darwin_amd64.tar.gz \
                 bin/san_linux_arm64.tar.gz bin/san_linux_amd64.tar.gz \
      [--out PATH] [--dry-run]

  --out PATH   write the generated formula to PATH
  --dry-run    print the generated formula to stdout; write nothing
"""

import argparse
import hashlib
import os
import re
import sys
from pathlib import Path

TOKENS = {
    "san_darwin_arm64.tar.gz": "__SHA256_DARWIN_ARM64__",
    "san_darwin_amd64.tar.gz": "__SHA256_DARWIN_AMD64__",
    "san_linux_arm64.tar.gz": "__SHA256_LINUX_ARM64__",
    "san_linux_amd64.tar.gz": "__SHA256_LINUX_AMD64__",
}

# The release tag, written literally into the formula URLs. The formula has no
# explicit `version` — Homebrew scans it from the URL — so the tag (with its v
# prefix, e.g. "v1.22.2") must appear verbatim in every download path.
TAG_TOKEN = "__TAG__"

TEMPLATE = Path(__file__).resolve().parent / "san.rb.tmpl"

# ── helpers ──────────────────────────────────────────────────────────────


def sha256_of(path):
    """Return the hex sha256 of a file."""
    digest = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(1 << 20), b""):
            digest.update(chunk)
    return digest.hexdigest()


def generate_formula(version, tarballs):
    """Token-substitute the template; fail fast if a token remains."""
    template = TEMPLATE.read_text()

    mapping = {TAG_TOKEN: version}
    for path in tarballs:
        name = os.path.basename(path)
        token = TOKENS.get(name)
        if token is None:
            raise SystemExit(f"::error:: unexpected tarball: {name} (expected {', '.join(sorted(TOKENS))})")
        mapping[token] = sha256_of(path)

    missing = [t for t in (TAG_TOKEN, *TOKENS.values()) if t not in mapping]
    if missing:
        raise SystemExit(f"::error:: missing tarballs for tokens: {', '.join(missing)}")

    formula = template
    for token, value in mapping.items():
        formula = formula.replace(token, value)

    leftovers = re.findall(r"__[A-Z0-9_]+__", formula)
    if leftovers:
        raise SystemExit(f"::error:: template drift: unreplaced tokens: {', '.join(sorted(set(leftovers)))}")

    return formula


# ── main ─────────────────────────────────────────────────────────────────


def main():
    parser = argparse.ArgumentParser(description="Update the Homebrew tap formula for san")
    parser.add_argument("--version", required=True, help="release tag, e.g. v1.22.2")
    parser.add_argument("--tarballs", nargs="+", required=True,
                        help="paths to the darwin/linux amd64/arm64 tarballs")
    parser.add_argument("--out", help="write the generated formula to PATH")
    parser.add_argument("--dry-run", action="store_true", help="print the formula, change nothing")
    args = parser.parse_args()

    formula = generate_formula(args.version, args.tarballs)

    if args.dry_run:
        print(formula)
        return

    if args.out:
        out = Path(args.out)
        out.parent.mkdir(parents=True, exist_ok=True)
        out.write_text(formula)
        print(f"wrote {args.out}")
        return

    parser.error("one of --out or --dry-run is required")


if __name__ == "__main__":
    main()
