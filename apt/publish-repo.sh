#!/usr/bin/env bash
# Publish .debs as a signed APT repo under ./repo (Linux only).
# Usage: APT_GPG_KEY=<key-id> ./publish-repo.sh [deb ...]
# Needs: dpkg-scanpackages (dpkg-dev), gzip, gpg.
# First time only, create the repo key:
#   gpg --quick-generate-key "Slid Phi Labs <corey@slidphilabs.com>" rsa4096 sign 5y
#   gpg --armor --export corey@slidphilabs.com > repo/slidphi-archive-keyring.gpg
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
POOL="$HERE/repo/pool/main"
DIST="$HERE/repo/dists/stable/main/binary-amd64"
mkdir -p "$POOL" "$DIST"

for deb in "$@"; do cp "$deb" "$POOL/"; done

cd "$HERE/repo"
dpkg-scanpackages --arch amd64 pool/main /dev/null | gzip -9c > dists/stable/main/binary-amd64/Packages.gz

{
  echo "Origin: Slid Phi Labs"
  echo "Label: slidphi"
  echo "Suite: stable"
  echo "Codename: stable"
  echo "Architectures: amd64 all"
  echo "Components: main"
  echo "Description: Slid Phi Labs compression tools"
  echo "Date: $(date -Ru)"
  for f in dists/stable/main/binary-amd64/Packages.gz; do
    echo "MD5Sum:"
    echo " $(md5sum "$f" | cut -d' ' -f1) $(stat -c%s "$f") $f"
    echo "SHA256:"
    echo " $(sha256sum "$f" | cut -d' ' -f1) $(stat -c%s "$f") $f"
  done
} > dists/stable/Release

if [ -z "${APT_GPG_KEY:-}" ]; then
  echo "unsigned repo written (no APT_GPG_KEY). Sign before serving:" >&2
  echo "  gpg --default-key <key-id> --clearsign -o dists/stable/InRelease dists/stable/Release" >&2
  exit 1
fi
gpg --default-key "$APT_GPG_KEY" --clearsign -o dists/stable/InRelease dists/stable/Release
gpg --default-key "$APT_GPG_KEY" -abs -o dists/stable/Release.gpg dists/stable/Release
echo "signed repo at $HERE/repo — serve it (any static host) and point users at README install steps"
