---
title: "Go"
linkTitle: "Go"
weight: 2
---

---

---

---

# Go

Linguagem que foi apresentada para a comunidade em Novembro de 2009.
Seus criadores são: Robert Griesemer, Rob Pike e Ken Thompson.
Go 1.0 foi lançada em Março de 2012
Código aberto e livre

## Por que da criação do Go?

limpa, pequena, compilada e moderna
Linguagem simples com poucas palavras chaves
Padronização com relação ao {} na mesma linha ou na linha abaixo
Simples, segura (memória) e legibilidade
Mínima: uma forma de escrever um determinado tipo de código
Consolidação e não inovação
Go foi baseada no Oberon, Oberon-2 e C
Caractericas de linguagens: OO, Generics, linguagens dinamicamente tipadas. Mas o Go não é uma linguagem OO, ela simplesmente utiliza recursos importantes de Poliformismo e Métodos.
Concorrência baseada em NewSqueak
Fortemente tipada
Linguagem compilada

## Instalação

[Download](https://go.dev/dl/)

## Validando a instalação

```
go version
```

## Go workspace

```
mkdir -p $HOME/go/pkg
mkdir -p $HOME/go/src
mkdir -p $HOME/go/bin
```

## IDE

[Download](https://code.visualstudio.com/download)

## Primeiro programa

```
mkdir -p $HOME/go/src/hello
touch -p $HOME/go/src/hello/hello.go
code $HOME/go/src/hello
```

```hello.go
package main

import "fmt"

func main() {
	fmt.Println("Olá Mundo!")
}

```

```
go mod init
go build hello.go
go run hello
```

## Segundo programa

```hello.go
package main

import (
	"fmt"
	"reflect"
)

func main() {
	// var nome string = "Rodrigo"
	nome := "Rodrigo"
	// var versao float32 = 2.0
	versao := 2.0
	// var idade int = 38
	idade := 38
	fmt.Println("Olá", nome, ",sua idade é", idade)
	fmt.Println("Versão", versao)
	fmt.Println("O tipo da variável nome é", reflect.TypeOf(nome), ". O tipo da variável idade é", reflect.TypeOf(idade))
	exibirMenu()
	var comando int
	// fmt.Scanf("%d", &comando)
	fmt.Scan(&comando)
	fmt.Println("O comando escolhido foi:", comando)
}

func exibirMenu() {
	fmt.Println("1- Iniciar monitoramento")
	fmt.Println("2- Exibir logs")
	fmt.Println("0- Sair do programa")
}
```

```
go mod init
go build hello.go
go run hello
```

## Terceiro programa

```hello.go
package main

import (
	"fmt"
	"os"
)

func main() {
	exibirIntroducao()
	exibirMenu()
	comando := lerComando()
	switch comando {
	case 1:
		iniciarMonitoramento()
	case 2:
		exibirLogs()
	case 0:
		fmt.Println("Saindo do programa")
		os.Exit(0)
	default:
		fmt.Println("Comando inválido!")
		os.Exit(-1)
	}
}

func exibirIntroducao() {
	nome := "Rodrigo"
	versao := 3.0
	fmt.Println("Olá", nome, ", seja bem-vindo!")
	fmt.Println("Este programa esta na versão", versao)
}

func exibirMenu() {
	fmt.Println("1- Iniciar monitoramento")
	fmt.Println("2- Exibir logs")
	fmt.Println("0- Sair do programa")
}

func lerComando() int {
	var comando int
	fmt.Scan(&comando)
	fmt.Println("O comando escolhido foi:", comando)
	return comando
}

func iniciarMonitoramento() {
	fmt.Println("Monitoramento")
}

func exibirLogs() {
	fmt.Println("Exibindo logs")
}

```

```
go mod init
go build hello.go
go run hello
```

## Quarto programa

```hello.go
package main

import (
	"fmt"
	"net/http"
	"os"
)

func main() {
	for {
		exibirIntroducao()
		exibirMenu()
		comando := lerComando()
		switch comando {
		case 1:
			iniciarMonitoramento()
		case 2:
			exibirLogs()
		case 0:
			fmt.Println("Saindo do programa")
			os.Exit(0)
		default:
			fmt.Println("Comando inválido!")
			os.Exit(-1)
		}
	}
}

func exibirIntroducao() {
	nome := "Rodrigo"
	versao := 3.0
	fmt.Println("Olá", nome, ", seja bem-vindo!")
	fmt.Println("Este programa esta na versão", versao)
}

func exibirMenu() {
	fmt.Println("1- Iniciar monitoramento")
	fmt.Println("2- Exibir logs")
	fmt.Println("0- Sair do programa")
}

func lerComando() int {
	var comando int
	fmt.Scan(&comando)
	fmt.Println("O comando escolhido foi:", comando)
	return comando
}

func iniciarMonitoramento() {
	fmt.Println("Monitoramento")
	site := "https://api.github.com/users/rotoku"
	res, _ := http.Get(site)
	statusCode := res.StatusCode
	header := res.Header
	body := res.Body
	if statusCode == 200 {
		fmt.Println("O ambiente do ", site, ", esta OK!")
		fmt.Println("Header:", header)
		fmt.Println("Body:", body)
	} else {
		fmt.Println("O ambiente do ", site, ", NÃO esta OK! O status code é", statusCode)
	}
}

func exibirLogs() {
	fmt.Println("Exibindo logs")
}

```

```
go mod init
go build hello.go
go run hello
```

## Quinto programa

```hello.go
quinto programa
```

```
go mod init
go build hello.go
go run hello
```

## Orientação a Objetos

## Web Application

## REST Application