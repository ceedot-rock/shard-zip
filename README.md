# shard-zip

[![npm](https://img.shields.io/npm/v/shard-zip)](https://www.npmjs.com/package/shard-zip)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](./LICENSE)
[![site](https://img.shields.io/badge/site-slidphilabs.vercel.app-blue)](https://slidphilabs.vercel.app)

**Omnipresent pure-JS compressor** — Fibonacci self-sync + **Blackjack V2** adaptive variants, K-division, and raw fallback. Full **compress/decompress** for integer series and byte streams. CLI included.

| | |
|--|--|
| **npm** | [`shard-zip@0.2.4`](https://www.npmjs.com/package/shard-zip) |
| **site** | [slidphilabs.vercel.app](https://slidphilabs.vercel.app) |
| **license** | [MIT](./LICENSE) |

---

## Why this exists

You often need a **single pure-JS adaptive path** for mixed integer streams and bytes — without wiring gzip/brotli native bindings. shard-zip picks among Fibonacci self-sync, Blackjack V2 variants, K-division, and raw so round-trip always works and ratios stay competitive on runs and smooth series.

---

## Install

```bash
npm i shard-zip
```

Node **≥ 18**.

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

---

## When it shines

| Shape | Expectation |
|-------|-------------|
| Runs / repeats | Strong (Fib + adaptive Blackjack) |
| Smooth walks | Competitive adaptive variants |
| Mixed / unknown | Auto fallback to safe path |
| High-entropy random | Weak (use general purpose codecs) |

Always verify with `decompress` / `decompressBytes` — **round-trip is the contract**.

---

## API

| Export | Description |
|--------|-------------|
| `compress(values: number[]): Uint8Array` | Integer series |
| `decompress(buf): number[]` | Inverse |
| `compressBytes(bytes): Uint8Array` | Raw bytes |
| `decompressBytes(buf): Uint8Array` | Inverse |
| `BlackjackCodec` / `AdaptiveCodec` | Lower-level codecs |

---

## Donate to SlidPhiLabs

**→ [Donate $29.99](https://buy.stripe.com/eVq9AUd7D0OY0CVdAQ6wE0a)** · [Support $199](https://buy.stripe.com/7sYbJ27NjfJSbhz8gw6wE09)

---

## Related packages

| Package | Role |
|---------|------|
| [zero-range-wave-compression](https://github.com/ceedot-rock/zero-range-wave-compression) | ZRW v5 — beats gzip/brotli on zeros/ramps/walks |
| [blackjack-compression](https://www.npmjs.com/package/blackjack-compression) | Blackjack v4 (Rice / ω / combinadic / file LZ77) |
| [slid-phi](https://www.npmjs.com/package/slid-phi) | Omni-Dormant integer pathways |
| [shard-tsdb](https://www.npmjs.com/package/shard-tsdb) | TSDB using this family |
| [CuNi Studio](https://cuni-studio.fly.dev/) | Exact multi-target code playground |

Brand home: **[slidphilabs.vercel.app](https://slidphilabs.vercel.app)**

---

## License

MIT
