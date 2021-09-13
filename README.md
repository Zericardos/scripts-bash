# scripts-bash
Scripts bash para automação de tarefas

## Conversão <img src="scripts/images/jpg-to-png.png" alt="jpg-to-png" width="80"/>

Converte todas as imagens no formato *jpg* em formato *png*

### Comando da aplicação

**bash conversao-jpg-png <\caminho absoluto do diretório a ser convertido\>**

*Exemplo geral: bash conversao-jpg-png $(realpath <\caminho relativo\>)*

*Exemplo específico na pasta do projeto:*

*bash scripts/conversao-jpg-png.sh $(realpath imagens-novos-livros/)*

- É necessário que cada imagem *jpg* tenha extensão *.jpg*
- Cria uma cópia com a estrutura de diretórios internos ao diretório pai com as imagens convertidas além de um diretório *logs*
- Cria arquivo de log na pasta logs para cada dia que o processo é executado no formato *conversao-YYYY-MM-DD.log*
    - *Exemplo*: O arquivo **conversao-2021-09-12.log** contém a mensagem final de todas as execuções realizadas na data apresentada.
    - Cada execução da aplicação é registrada como a data e hora de execução no arquivo de log
    - Caso ocorra algum erro na conversão, é mostrada a razão.
- Mostra-se uma mensagem final de sucesso ou erro na conversão.
