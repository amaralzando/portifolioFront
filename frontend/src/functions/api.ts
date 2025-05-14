const baseURL = process.env.API_URL;

export async function httpGet(url: string) {
	if (!baseURL) {
		console.error("❌ API_URL não está definido.");
		return null;
	}

	const fullUrl = normalizarUrl(`${baseURL}/${url}`);
	console.log("🔗 GET", fullUrl);

	try {
		const response = await fetch(fullUrl);
		if (!response.ok) {
			throw new Error(`Erro HTTP: ${response.status} - ${response.statusText}`);
		}
		return await response.json();
	} catch (error) {
		console.error("❌ Erro na requisição:", error);
		return null;
	}
}

function normalizarUrl(url?: string): string {
	try {
		if (!url || !url.includes("://")) return url ?? "";
		const [protocolo, restante] = url.split("://");
		return `${protocolo}://${(restante ?? "").replaceAll(/\/{2,}/g, "/")}`;
	} catch {
		return url ?? "";
	}
}
