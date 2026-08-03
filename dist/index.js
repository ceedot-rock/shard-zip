/** Proprietary stub — no codec on public npm. https://slidphilabs.vercel.app/access */
const MSG =
  "shard-zip is proprietary (SlidPhiLabs). " +
  "Public npm only ships a stub. After purchase or Try Gate, you receive the real package. " +
  "https://slidphilabs.vercel.app/access";
function blocked() { throw new Error(MSG); }
export const compress = blocked;
export const decompress = blocked;
export const compressBytes = blocked;
export const decompressBytes = blocked;
export default { compress, decompress, compressBytes, decompressBytes };
console.warn("[SlidPhiLabs] Stub — no codec source. → https://slidphilabs.vercel.app/access");
