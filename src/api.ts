import type { JarSize, Lolly, Product } from "./types";

async function json<T>(url: string, init?: RequestInit): Promise<T> {
  const response = await fetch(url, { ...init, headers: { "Content-Type": "application/json", ...(init?.headers || {}) } });
  const body = await response.json() as T & { error?: string };
  if (!response.ok) throw new Error(body.error || "Request failed");
  return body;
}

export const api = {
  catalogue: () => json<{ products: Product[]; jars: JarSize[]; lollies: Lolly[]; categories: { id: string; name: string; slug: string; image_url: string | null }[]; settings: Record<string, string> }>("/api/catalogue"),
  checkout: (items: unknown[]) => json<{ url: string }>("/api/checkout", { method: "POST", body: JSON.stringify({ items }) }),
  contact: (data: Record<string, FormDataEntryValue>) => json<{ ok: true }>("/api/contact", { method: "POST", body: JSON.stringify(data) }),
  adminMe: () => json<{ authenticated: boolean }>("/api/admin/me"),
  adminLogin: (email: string, password: string, turnstileToken = "") => json<{ ok: true }>("/api/admin/login", { method: "POST", body: JSON.stringify({ email, password, turnstileToken }) }),
  adminLogout: () => json<{ ok: true }>("/api/admin/logout", { method: "POST" }),
  adminDashboard: () => json<any>("/api/admin/dashboard"),
  adminProducts: () => json<{ products: Product[] }>("/api/admin/products"),
  saveProduct: (product: Partial<Product>) => json<{ ok: true; id: string }>("/api/admin/products", { method: "POST", body: JSON.stringify(product) })
};
