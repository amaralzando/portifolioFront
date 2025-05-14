const baseURL = process.env.NEXT_PUBLIC_API_URL

export async function httpGet(url: string) {
	console.log(normalizarUrl(`${baseURL}/${url}`))
	const response = await fetch(normalizarUrl(`${baseURL}/${url}`))
	return response.json()
}

function normalizarUrl(url?: string) {
	try {
		if (!url || !url.includes("://")) return url ?? ""
		const [protocolo, restante] = url.split("://")
		return `${protocolo}://${restante.replaceAll(/\/{2,}/g, "/")}`
	} catch {
		return url ?? ""
	}
}

