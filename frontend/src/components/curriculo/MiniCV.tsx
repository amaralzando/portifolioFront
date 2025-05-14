import Image from "next/image"

export default function MiniCV() {
	return (
		<div className="flex-1 flex flex-col-reverse gap-6 md:flex-row lg:flex-col-reverse xl:flex-row items-center bg-black border border-zinc-800 rounded-2xl p-6">
			{/* Image Container - Agora centralizado verticalmente em todas as telas */}
			<div className="relative w-72 h-64 flex items-center justify-center">
				<Image
					src="/minha-foto.jpg"
					alt="Foto de perfil"
					fill
					className="object-cover rounded-lg"
				/>
			</div>

			{/* Text Content */}
			<div className="flex flex-col gap-4 w-full">
				{/* Name and Title */}
				<div className="flex flex-col items-center md:items-start lg:items-center xl:items-start gap-1">
					<h1 className="text-2xl font-bold bg-gradient-to-r from-red-500 via-white to-white text-transparent bg-clip-text">
						Gabriel Amaral
					</h1>
					<span className="text-zinc-400">CEO da GasaTec e Desenvolvedor Full-stack</span>
				</div>

				{/* Description */}
				<p className="text-sm text-zinc-300 text-center md:text-left lg:text-center xl:text-left leading-relaxed">
					Sou um profissional dedicado e apaixonado por desenvolver sistemas que unem
					eficiência e usabilidade. Meu foco está em entregar não apenas funcionalidades,
					mas soluções que realmente façam a diferença, priorizando qualidade, performance
					e melhores práticas. Acredito na força da colaboração e na evolução constante.
					Esteja o desafio na otimização de processos, na resolução de problemas complexos
					ou na construção de projetos impactantes, estou sempre pronto para contribuir
					com criatividade, organização e comprometimento.
				</p>
			</div>
		</div>
	)
}
