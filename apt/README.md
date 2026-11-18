# apt install slidphi-shard-zip

Ships today: **shard-zip** (pure-JS integer compressor, GPL-3.0-only).
`pulsar`, TNSSRC/`npcc`, and ZRW are **not** packageable from this checkout:
their engines live in private repos (`neural-pcc`), archived repos
(`pulsar-best`), or are absent from the tree (`zrw-pack.js`). Each needs its
source opened and a matching `apt/<name>/` package dir before it can ride
this rail.

## Build the .deb (Debian/Ubuntu runner)

```sh
npm run build && npm test
./apt/build-deb.sh ./dist-deb
```

## Publish the repo (maintainer, first time)

```sh
gpg --quick-generate-key "Slid Phi Labs <corey@slidphilabs.com>" rsa4096 sign 5y
gpg --armor --export corey@slidphilabs.com > apt/repo/slidphi-archive-keyring.gpg
APT_GPG_KEY=corey@slidphilabs.com ./apt/publish-repo.sh dist-deb/*.deb
```

Serve `apt/repo/` from any static host (it is designed for
`https://www.slidphilabs.com/apt`).

## Install (user)

```sh
curl -fsSL https://www.slidphilabs.com/apt/slidphi-archive-keyring.gpg \
  | sudo tee /usr/share/keyrings/slidphi-archive-keyring.gpg >/dev/null
echo "deb [signed-by=/usr/share/keyrings/slidphi-archive-keyring.gpg] \
  https://www.slidphilabs.com/apt stable main" \
  | sudo tee /etc/apt/sources.list.d/slidphi.list
sudo apt update && sudo apt install slidphi-shard-zip
echo '[1,2,3,2,1]' > /tmp/t.json && shard-zip compress /tmp/t.json -o /tmp/t.shrd
```

No repo yet? `sudo dpkg -i slidphi-shard-zip_*_all.deb` (needs `nodejs>=18`).

## Money note

The `.deb` is free — GPL-3.0-only requires the source stay open anyway.
Revenue does not come from the install; it comes from **commercial grants
for closed use** (see `agentic.usd`/SKU fields in `package.json`), the
**hosted receipted premium** (metered API with mandates + signed receipts),
per-call tolls, and enterprise support. Free code, paid commercial license
plus hosted trust — the MySQL shape.
