#!/usr/bin/env node
"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const fs_1 = require("fs");
const index_1 = require("./index");
const cmd = process.argv[2];
if (cmd === 'compress') {
    const input = process.argv[3];
    const outIdx = process.argv.indexOf('-o');
    const outPath = outIdx >= 0 ? process.argv[outIdx + 1] : input + '.shrd';
    const data = JSON.parse((0, fs_1.readFileSync)(input, 'utf8'));
    const values = Array.isArray(data) ? data : (data.values || []);
    const comp = (0, index_1.compress)(values);
    (0, fs_1.writeFileSync)(outPath, comp);
    console.log(`Compressed ${values.length} values → ${comp.length} bytes`);
}
else if (cmd === 'decompress') {
    const input = process.argv[3];
    const outIdx = process.argv.indexOf('-o');
    const outPath = outIdx >= 0 ? process.argv[outIdx + 1] : input + '.json';
    const vals = (0, index_1.decompress)((0, fs_1.readFileSync)(input));
    (0, fs_1.writeFileSync)(outPath, JSON.stringify(vals));
    console.log(`Decompressed ${vals.length} values`);
}
else {
    console.log('Usage: shard-zip compress in.json [-o out.shrd] | decompress in.shrd [-o out.json]');
}
