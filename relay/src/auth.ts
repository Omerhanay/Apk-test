import { createHash, timingSafeEqual } from "node:crypto";

export function sha256Hex(value: string): string {
  return createHash("sha256").update(value, "utf8").digest("hex");
}

/** Constant-time comparison of a presented bearer token against the configured hash. */
export function verifyBearer(header: string | undefined, expectedSha256: string): boolean {
  if (!header?.startsWith("Bearer ")) return false;
  const token = header.slice("Bearer ".length).trim();
  if (token.length < 32) return false;
  const presented = Buffer.from(sha256Hex(token), "hex");
  const expected = Buffer.from(expectedSha256, "hex");
  return presented.length === expected.length && timingSafeEqual(presented, expected);
}
