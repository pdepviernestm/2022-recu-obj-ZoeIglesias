class Computadora{
	const property tamanioDisco
	var property tamanioMemoria
	var property programasEnEjecucion = []
	var property programasInstalados = []
	
	//PUNTO 1
	method instalarPrograma(programa){
		if(self.sePuedeInstalar(programa)){
			throw new Exception(message = "No se cuenta con memoria suficiente para instalar este programa")
		}else {
			self.instalar(programa,programa.parteDelDisco())
		}
	}
	
	method sePuedeInstalar(programa) = tamanioDisco < programa.parteDelDisco()
	
	method instalar(programa,tamanioAOcupar){
		programasInstalados.add(programa)
		tamanioDisco -= tamanioAOcupar
	}
	
	// PUNTO 2
	
	method ejecutarPrograma(programa){
		if(self.puedeSerEjecutado(programa)){
			programasEnEjecucion.add(programa)
			self.reducirMemoria(programa.memoriaAOcupar())
			programa.maquinasEnLasCualFueEjecutado().add(self)
		}
	}
	
	method reducirMemoria(cantidad){ tamanioMemoria -= cantidad }
	
	method puedeSerEjecutado(programa){
		return self.estaInstalado(programa) && self.noEstaSiendoEjecutado(programa) && self.hayMemoriaPara(programa)
	}
	
	method estaInstalado(programa) = programasInstalados.contains(programa)
	
	method noEstaSiendoEjecutado(programa) = not programasEnEjecucion.contains(programa)
	
	method hayMemoriaPara(programa) = tamanioMemoria <= programa.memoriaAOcupar()
	
	// PUNTO 3
	
	method detenerPrograma(programa){
		programasEnEjecucion.remove(programa)
		self.liberarMemoria(programa.memoriaAOcupar())
	}

	method liberarMemoria(cantidad){ tamanioMemoria -= cantidad}
	
	// PUNTO 4
	
	method programaQueMasMemoriaConsume() = programasEnEjecucion.max{ p => p.memoriaAOcupar() }
	
	method alunoEsMuyPesado() = programasInstalados.any{ p => p.parteDelDisco() > tamanioDisco/2 }
		
}

object conjuntoDeComputadoras{
	var property computadoras = []
	
	method sePuedeInstalar(programa) = computadoras.filter{ c => c.sePuedeInstalar(programa) }
}

class Programa{
	var property parteDelDisco
	var property memoriaAOcupar
	var property maquinasEnLasCualFueEjecutado = []
	
}
