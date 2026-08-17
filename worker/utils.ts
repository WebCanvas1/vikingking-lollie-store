import type { Env } from "./types";

export const json = (data: unknown, status = 200, headers: HeadersInit = {}) => new Response(JSON.stringify(data), { status, headers: { "Content-Type": "application/json; charset=utf-8", "Cache-Control": "no-store", ...headers } });
export const id = () => crypto.randomUUID();
export const cleanText = (value: unknown, max = 500) => typeof value === "string" ? value.trim().slice(0, max) : "";
export const b64 = (bytes: Uint8Array) => btoa(String.fromCharCode(...bytes));
export const fromB64 = (value: string) => Uint8Array.from(atob(value), c => c.charCodeAt(0));
export async function sha256(value: string) { const d = await crypto.subtle.digest("SHA-256", new TextEncoder().encode(value)); return b64(new Uint8Array(d)); }
export async function pbkdf2(password: string, salt: Uint8Array, iterations = 310000) {
  const key = await crypto.subtle.importKey("raw", new TextEncoder().encode(password), "PBKDF2", false, ["deriveBits"]);
  const bits = await crypto.subtle.deriveBits({ name: "PBKDF2", salt: salt as BufferSource, iterations, hash: "SHA-256" }, key, 256);
  return b64(new Uint8Array(bits));
}
export function constantTimeEqual(a: string, b: string) { if (a.length !== b.length) return false; let v = 0; for (let i=0;i<a.length;i++) v |= a.charCodeAt(i)^b.charCodeAt(i); return v===0; }
export function cookie(req: Request, name: string) { const header=req.headers.get("Cookie")||""; return header.split(";").map(x=>x.trim()).find(x=>x.startsWith(name+"="))?.slice(name.length+1)||""; }
export async function requireAdmin(req: Request, env: Env) {
  const token=cookie(req,"vk_admin"); if(!token) return null; const hash=await sha256(token);
  return env.DB.prepare("SELECT a.id,a.email FROM admin_sessions s JOIN admins a ON a.id=s.admin_id WHERE s.token_hash=? AND s.expires_at>datetime('now') AND a.active=1").bind(hash).first<{id:string,email:string}>();
}
export async function verifyTurnstile(req: Request, env: Env, token: string) {
  if (!env.TURNSTILE_SECRET_KEY) return true;
  const form=new FormData(); form.set("secret",env.TURNSTILE_SECRET_KEY); form.set("response",token); form.set("remoteip",req.headers.get("CF-Connecting-IP")||"");
  const result=await fetch("https://challenges.cloudflare.com/turnstile/v0/siteverify",{method:"POST",body:form}).then(r=>r.json()) as {success:boolean}; return result.success;
}
