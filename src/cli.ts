#!/usr/bin/env node
import { readFileSync, writeFileSync } from 'fs';
import { compress, decompress } from './index';
const cmd = process.argv[2];
if (cmd === 'compress') {
  const input = process.argv[3];
  const outIdx = process.argv.indexOf('-o');
  const outPath = outIdx >= 0 ? process.argv[outIdx+1] : input + '.shrd';
  const data = JSON.parse(readFileSync(input, 'utf8'));
  const values = Array.isArray(data) ? data : (data.values || []);
  const comp = compress(values);
  writeFileSync(outPath, comp);
  console.log(`Compressed ${values.length} values → ${comp.length} bytes`);
} else if (cmd === 'decompress') {
  const input = process.argv[3];
  const outIdx = process.argv.indexOf('-o');
  const outPath = outIdx >= 0 ? process.argv[outIdx+1] : input + '.json';
  const vals = decompress(readFileSync(input));
  writeFileSync(outPath, JSON.stringify(vals));
  console.log(`Decompressed ${vals.length} values`);
} else {
  console.log('Usage: shard-zip compress in.json [-o out.shrd] | decompress in.shrd [-o out.json]');
}
