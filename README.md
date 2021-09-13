# scripts-bash
Scripts bash para automação de tarefas

## Conversão <img src="scripts/images/jpg-to-png.png" alt="jpg-to-png" width="80"/>

Converte todos as imagens jpg em png

### Comando da aplicação

**bash conversao-jpg-png <\caminho absoluto do diretório a ser convertido\>**

- *Exemplo: bash conversao-jpg-png $(realpath <\caminho relativo\>)*
- Cria uma cópia com a estrutura de diretórios internos ao diretório pai com as imagens convertidas no mesmo diretório em que aquele se encontra
- Cria arquivo de log na pasta logs para cada dia que o processo é executado
    - *Exemplo*: O arquivo **log-conversao-2021-09-12.log** contém todas as execuções de todos os processos realizados na data apresentada.
    - Cada execução de arquivo é registrada como a data e hora de execução
    - Caso ocorra algum erro na conversão, é mostrada a razão.
- É impresso uma mensagem final de sucesso ou erro na conversão.
