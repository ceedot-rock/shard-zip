declare class BlackjackBase {
    codes: Record<string, number[]>;
    trie: any;
    variant: string;
    constructor(variant: 'C' | 'E' | 'I' | 'G');
    encode(values: number[], K?: number): number[];
    decode(bits: number[], K?: number): number[];
}
export declare class BlackjackV2 {
    encode(values: number[]): {
        bits: number[];
        variant: any;
        K: number;
        len: number;
    };
    decode(bits: number[]): number[];
}
export { BlackjackBase as BlackjackCodec, BlackjackV2 as AdaptiveCodec };
export declare function compress(values: number[]): Uint8Array;
export declare function decompress(data: Uint8Array): number[];
export declare function compressBytes(bytes: Uint8Array): Uint8Array;
export declare function decompressBytes(data: Uint8Array): Uint8Array;
