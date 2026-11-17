import type { JarSize, Lolly, Product } from "./types";

async function json<T>(url: string, init?: RequestInit): Promise<T> {
  const response = await fetch(url, { ...init, headers: { "Content-Type": "application/json", ...(init?.headers || {}) } });
  const body = await response.json() as T & { error?: string };
  if (!response.ok) throw new Error(body.error || "Request failed");
  return body;
}

async function upload(file: File): Promise<{ key: string; url: string }> {
  const body = new FormData(); body.append("file", file);
  const response = await fetch("/api/admin/media", { method: "POST", body });
  const result = await response.json() as { key: string; url: string; error?: string };
  if (!response.ok) throw new Error(result.error || "Upload failed");
  return result;
}

type Coupon = { code:string; kind:"percent"|"fixed"; value:number; active:0|1 };

export const api = {
  couponQuote: (items: unknown[], coupon: string, shipping: string) =>
    json<{couponCode:string;discount:number;total:number}>("/api/coupon-quote", {
      method:"POST", body:JSON.stringify({items,details:{coupon,shipping}}),
    }),
  adminCoupons: () => json<{coupons:Coupon[]}>("/api/admin/coupons"),
  createCoupon: (coupon: Omit<Coupon,"active">) => json<{ok:true}>("/api/admin/coupons", {
    method:"POST", body:JSON.stringify(coupon),
  }),
  setCouponActive: (code:string, active:boolean) => json<{ok:true}>("/api/admin/coupons", {
    method:"PATCH", body:JSON.stringify({code,active}),
  }),
  catalogue: () => json<{ products: Product[]; jars: JarSize[]; lollies: Lolly[]; categories: { id: string; name: string; slug: string; image_url: string | null }[]; settings: Record<string, string> }>("/api/catalogue"),
  shipping: () => json<{method:string;label:string;rate_cents:number;free_threshold_cents:number|null}[]>("/api/shipping"),
  checkout: (items: unknown[], details: Record<string, FormDataEntryValue | number>, requestId: string) =>
    json<{orderNumber:string;total:number;couponCode:string|null;discount:number;bankTransfer:{bank:string;bsb:string;account:string}}>("/api/bank-transfer-orders", {
      method: "POST", body: JSON.stringify({ items, details, requestId }),
    }),
  contact: (data: Record<string, FormDataEntryValue>) => json<{ ok: true }>("/api/contact", { method: "POST", body: JSON.stringify(data) }),
  newsletter: (email: string) => json<{ ok: true; already_subscribed: boolean }>("/api/newsletter", { method: "POST", body: JSON.stringify({ email }) }),
  adminMe: () => json<{ authenticated: boolean }>("/api/admin/me"),
  adminLogin: (email: string, password: string, turnstileToken = "") => json<{ ok: true }>("/api/admin/login", { method: "POST", body: JSON.stringify({ email, password, turnstileToken }) }),
  adminLogout: () => json<{ ok: true }>("/api/admin/logout", { method: "POST" }),
  adminDashboard: () => json<any>("/api/admin/dashboard"),
  adminProducts: () => json<{ products: Product[]; categories: { id: string; name: string }[] }>("/api/admin/products"),
  saveProduct: (product: Record<string, unknown>) => json<{ ok: true; id: string }>("/api/admin/products", { method: "POST", body: JSON.stringify(product) }),
  deleteProduct: (id: string) => json<{ ok: true }>("/api/admin/products", { method: "DELETE", body: JSON.stringify({ id }) }),
  adminLollies: () => json<{ lollies: Record<string, unknown>[] }>("/api/admin/lollies"),
  saveLolly: (lolly: Record<string, unknown>) => json<{ ok: true; id: string }>("/api/admin/lollies", { method: "POST", body: JSON.stringify(lolly) }),
  adminJars: () => json<{ jars: Record<string, unknown>[] }>("/api/admin/jars"),
  saveJar: (jar: Record<string, unknown>) => json<{ ok: true; id: string }>("/api/admin/jars", { method: "POST", body: JSON.stringify(jar) }),
  adminOrders: () => json<{ orders: Record<string, unknown>[] }>("/api/admin/orders"),
  adminNewsletter: () => json<{ subscribers: Record<string, unknown>[]; total: number; active: number }>("/api/admin/newsletter"),
  saveOrder: (order: Record<string, unknown>) => json<{ ok: true }>("/api/admin/orders", { method: "POST", body: JSON.stringify(order) }),
  adminSiteSettings: () => json<{ settings: Record<string, string> }>("/api/admin/site-settings"),
  saveSiteSettings: (settings: Record<string, string>) => json<{ ok: true }>("/api/admin/site-settings", { method: "POST", body: JSON.stringify(settings) }),
  adminShipping: () => json<{ shipping: Record<string, unknown>[] }>("/api/admin/shipping"),
  saveShipping: (shipping: Record<string, unknown>) => json<{ ok: true }>("/api/admin/shipping", { method: "POST", body: JSON.stringify(shipping) }),
  changePassword: (current_password: string, new_password: string) => json<{ ok: true }>("/api/admin/password", { method: "POST", body: JSON.stringify({ current_password, new_password }) }),
  uploadMedia: upload
};
