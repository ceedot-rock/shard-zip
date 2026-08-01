# shard-zip

[![npm](https://img.shields.io/npm/v/shard-zip)](https://www.npmjs.com/package/shard-zip)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![site](https://img.shields.io/badge/site-slidphilabs.vercel.app-blue)](https://slidphilabs.vercel.app)

**Omnipresent compressor** — Fibonacci self-sync + **Blackjack V2** (adaptive variants, K-division, raw fallback). Pure JS, **full compress/decompress**.

## Install

```bash
npm i shard-zip
```

## Donate to SlidPhiLabs

**→ [Donate $29.99](https://buy.stripe.com/eVq9AUd7D0OY0CVdAQ6wE0a)** · [Support $199](https://buy.stripe.com/7sYbJ27NjfJSbhz8gw6wE09)

## Quick start

```js
import { compress, decompress, compressBytes, decompressBytes } from "shard-zip";

const wire = compress([1, 2, 2, 3, 100, 101]);
const back = decompress(wire);

const packed = compressBytes(new TextEncoder().encode("hello ".repeat(40)));
const raw = decompressBytes(packed);
```

### CLI

```bash
npx shard-zip compress values.json -o out.shrd
npx shard-zip decompress out.shrd -o out.json
```

`values.json` should be a JSON array of numbers, or `{ "values": [...] }`.

## API

| Export | Description |
|--------|-------------|
| `compress(values: number[]): Uint8Array` | Integer series |
| `decompress(buf): number[]` | Inverse |
| `compressBytes(bytes): Uint8Array` | Raw bytes |
| `decompressBytes(buf): Uint8Array` | Inverse |
| `BlackjackCodec` / `AdaptiveCodec` | Lower-level codecs |

## Related

- [blackjack-compression](https://www.npmjs.com/package/blackjack-compression) — Blackjack v4 (Rice / ω / combinadic / file LZ77)
- [shard-tsdb](https://www.npmjs.com/package/shard-tsdb) — TSDB using this family
- [slid-phi](https://www.npmjs.com/package/slid-phi) — Omni-Dormant int pathways

Site: [slidphilabs.vercel.app](https://slidphilabs.vercel.app)

## License

MIT
