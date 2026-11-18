#!/usr/bin/env bash
# Build slidphi-shard-zip_<upstream>-1_all.deb from ../dist (Linux only).
# Usage: ./build-deb.sh [out-dir]
# Needs: dpkg-deb, node (to read package.json version).
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
ROOT="$(cd "$HERE/.." && pwd)"
OUT="${1:-$HERE}"
test -f "$ROOT/dist/cli.js" || { echo "run npm run build first" >&2; exit 1; }

VER="$(sed -n 's/^[[:space:]]*"version":[[:space:]]*"\([^"]*\)".*/\1/p' "$ROOT/package.json" | head -1)"
test -n "$VER" || { echo "could not read version from package.json" >&2; exit 1; }
mkdir -p "$OUT"
PKG=slidphi-shard-zip
REL="${VER}-1"
STAGE="$(mktemp -d)"
trap 'rm -rf "$STAGE"' EXIT

mkdir -p "$STAGE/DEBIAN" "$STAGE/usr/lib/shard-zip" "$STAGE/usr/bin" \
         "$STAGE/usr/share/doc/$PKG"
cp "$ROOT/dist/cli.js" "$ROOT/dist/index.js" "$STAGE/usr/lib/shard-zip/"
cp "$ROOT/dist/cli.d.ts" "$ROOT/dist/index.d.ts" "$STAGE/usr/lib/shard-zip/" 2>/dev/null || true
cp "$ROOT/LICENSE" "$STAGE/usr/share/doc/$PKG/copyright"
chmod 644 "$STAGE/usr/lib/shard-zip/"* "$STAGE/usr/share/doc/$PKG/copyright"
ln -s ../lib/shard-zip/cli.js "$STAGE/usr/bin/shard-zip"

cat > "$STAGE/DEBIAN/control" <<EOF
Package: $PKG
Version: $REL
Section: utils
Priority: optional
Architecture: all
Depends: nodejs (>= 18)
Maintainer: Slid Phi Labs <corey@slidphilabs.com>
Homepage: https://www.slidphilabs.com/npm#shard-zip
Description: shard-zip integer compressor (Slid Phi Labs)
 Pure-JS lossless compressor for integer sequences: Fibonacci self-sync,
 Blackjack V2 adaptive variants, K-division, raw fallback.
 GPL-3.0-only. CLI: shard-zip compress in.json [-o out.shrd].
EOF

dpkg-deb --root-owner-group --build "$STAGE" "$OUT/${PKG}_${REL}_all.deb"
echo "wrote $OUT/${PKG}_${REL}_all.deb"
echo "test: sudo dpkg -i $OUT/${PKG}_${REL}_all.deb"
echo "smoke: echo '[1,2,3,2,1]' > /tmp/t.json && shard-zip compress /tmp/t.json -o /tmp/t.shrd && shard-zip decompress /tmp/t.shrd -o /tmp/t.out.json && cat /tmp/t.out.json"
