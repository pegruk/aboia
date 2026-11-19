# Aboia 🛟

Uma ajuda para navegar pela Piscina da 42: execute a Norminette e testes da mini-moulinette com um comando no terminal.

> **Projeto independente da comunidade.** Aboia não é um produto oficial, não é afiliado à 42 e não pretende se passar pela Moulinette oficial. Ele integra ferramentas existentes, reconhecendo seus autores e licenças; não reivindica a autoria da Norminette ou dos testes da mini-moulinette. Os resultados servem de apoio ao aprendizado e não garantem aprovação.

## O que faz

- Executa a Norminette nos arquivos C e headers encontrados.
- Executa os testes disponíveis da mini-moulinette para um módulo ou exercício.
- Mostra erros de compilação e saída dos testes no terminal.
- Copia o exercício e os testes para uma pasta temporária, que é removida após a execução.

## Requisitos

Linux ou macOS com Python 3.10 ou superior, compilador `cc` e acesso à internet para baixar dependências ausentes. Git é necessário para baixar a mini-moulinette, e o Python precisa oferecer `venv` e `pip` para instalar a Norminette. A disponibilidade de testes e a compatibilidade variam conforme o sistema.

O instalador usa uma Norminette já disponível ou instala a versão 3.3.60 em um ambiente isolado. Ele usa uma mini-moulinette já instalada em `~/mini-moulinette` ou baixa uma revisão fixa para `~/.local/share/piscina/deps`. A instalação não requer `sudo`. Python, compilador e Git devem ser instalados pelo usuário quando ausentes.

## Instalação

Clone ou baixe este repositório, entre na pasta e rode:

```sh
cd aboia
./install.sh
```

O executável é instalado em `~/.local/bin/aboia`. O comando `piscina` também fica disponível para compatibilidade. Se o terminal informar `command not found`, adicione `~/.local/bin` ao `PATH`:

**Fish:**

```fish
fish_add_path ~/.local/bin
```

**Bash ou Zsh:** acrescente esta linha a `~/.bashrc` ou `~/.zshrc`, respectivamente, e abra um novo terminal:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Como usar

O Aboia também funciona com outros módulos de C. A mini-moulinette usada pelo projeto contém pastas de testes de **C00 a C08**, com cobertura que varia entre exercícios. A Norminette verifica arquivos C e headers; os testes funcionais dependem da disponibilidade no módulo escolhido.

Quando a pasta do módulo tem o nome `C00`, `C01`, `C02` etc., entre nela ou em um exercício diretamente dentro dela e execute:

```sh
aboia
```

Por exemplo, dentro de `C02/ex03`, `aboia` tenta identificar o C02 e verificar o ex03. Dentro de `C01`, ele procura testes dos exercícios do C01.

Se o nome da pasta do módulo for diferente, como `intra-uuid-...`, informe o módulo explicitamente. Por exemplo, para um repositório de C02:

```sh
aboia C02
```

Também é possível indicar uma pasta sem entrar nela:

```sh
aboia C03 --caminho /caminho/para/C03/ex00
```

### Exemplo: C00/ex00

Entre na pasta `ex00` do seu C00 e rode `aboia C00`. A primeira seção mostra o resultado da Norminette para `ft_putchar.c`. A segunda compila e executa os testes disponíveis para `ft_putchar`. Se houver erro, leia a mensagem, corrija o código e execute o comando novamente. Uma Norminette sem erros indica que a verificação de estilo passou; os testes mostram separadamente o comportamento observado.

Para ver todas as opções:

```sh
aboia --help
```

`--mini /caminho/mini-moulinette` ou a variável `MINI_MOULINETTE` permitem escolher outra cópia do testador. Os códigos de saída são `0` quando as verificações executadas passam, `1` quando há falha e `2` quando há verificação incompleta sem falha detectada.

## Cobertura e limitações

Aboia depende dos testes existentes na mini-moulinette: exercícios sem testes ou ausentes são informados. Ele não verifica todas as exigências do enunciado, funções proibidas nem arquivos extras; sempre confira o enunciado da sua turma. Shell, Rush e BSQ não são suportados. Os testes comunitários podem conter falhas, não cobrem todos os casos e não reproduzem necessariamente a avaliação oficial. Escrever seus próprios testes continua sendo útil.

O testador executa código C fornecido pelo usuário. Use-o apenas com código e testes em que você confia. A pasta temporária organiza os arquivos, mas não é uma barreira de segurança.

## Desinstalação

Remova `~/.local/bin/aboia` e `~/.local/bin/piscina` se eles apontarem para a instalação do Aboia, e depois remova `~/.local/share/piscina`. Uma Norminette ou mini-moulinette instaladas separadamente não precisam ser removidas.

## Créditos

Aboia coordena a [Norminette oficial da 42](https://github.com/42school/norminette) e os testes da [mini-moulinette de k11q e colaboradores](https://github.com/k11q/mini-moulinette). Cada projeto mantém seus próprios créditos e licença; consulte os repositórios originais para os termos completos. Aboia também aplica uma correção local ao teste de C00/ex00 para incluir o header necessário ao próprio teste.
