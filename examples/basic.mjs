/**
 * shard-zip integer + bytes demo
 *   node examples/basic.mjs
 */
import {
  compress,
  decompress,
  compressBytes,
  decompressBytes,
} from "../dist/index.js";

const values = [1, 2, 2, 3, 100, 101, 101, 102];
const wire = compress(values);
const back = decompress(wire);
console.log("ints", {
  n: values.length,
  packed: wire.length,
  ok: back.every((v, i) => v === values[i]),
});

const raw = new TextEncoder().encode("AAAAAB".repeat(100));
const b = compressBytes(raw);
const bBack = decompressBytes(b);
console.log("bytes", {
  orig: raw.length,
  packed: b.length,
  ratio: (b.length / raw.length).toFixed(3),
  ok: bBack.every((x, i) => x === raw[i]),
});
