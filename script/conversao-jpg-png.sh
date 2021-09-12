#!/bin/bash


data_conversao=$(date '+%F')
horario_conversao=$(date '+%2H:%2M:%S')


percorre_arquivos_converte(){
    cd $1
    for arquivo in *;do
        local caminho_arquivo=$(find $DIRETORIO_ORIGINAL -name $arquivo)
        if [ -d $caminho_arquivo ];then
            percorre_arquivos_converte $caminho_arquivo
        else
            if [[ $arquivo =~ \.jpg$ ]];then
                local caminho_relativo_imagem_diretorio_original=$(realpath --relative-to=$DIRETORIO_ORIGINAL \
                    $caminho_arquivo)
                converte_imagem $caminho_arquivo $caminho_relativo_imagem_diretorio_original
            fi
        fi
    done

}


remove_extensao(){
    local sem_extensao=$(echo $1 | awk -F. '{ printf $1 }')
    echo $sem_extensao
}


converte_imagem(){
    local caminho_relativo_imagem=$(remove_extensao $2)
    convert $1 $DIRETORIO_PNG/$caminho_relativo_imagem.png
    }


# Verificar a possibilidade de colocar condição de caminho absoluto ou relativo na aplicação
DIRETORIO_ORIGINAL=$1

cd $DIRETORIO_ORIGINAL
find . -type d > dirs.txt  # imprime os caminhos relativos dos diretórios e subdiretórios ao diretório original no
# arquivo dirs.txt

# Realizar correção para teste para imagens e diretórios com mesmo nome, mas em lugares diferentes (obviamente)
# provável problema está na saída do find -name <nome arquivo> gera duas saídas.
cd ..
if [ ! -d png ]
    then
        mkdir png
fi
DIRETORIO_PNG=$(realpath png)

if [ ! -d logs ]
    then
        mkdir logs
fi
DIRETORIO_LOGS=$(realpath logs)

echo $data_conversao,$horario_conversao >> $DIRETORIO_LOGS/log-conversao-$data_conversao.log

cd $DIRETORIO_PNG
xargs mkdir -p < $DIRETORIO_ORIGINAL/dirs.txt
rm $DIRETORIO_ORIGINAL/dirs.txt

percorre_arquivos_converte $DIRETORIO_ORIGINAL 2>> $DIRETORIO_LOGS/log-conversao-$data_conversao.log

if [ $? -eq 0 ];then
    echo "Conversão realizada com sucesso" >> $DIRETORIO_LOGS/log-conversao-$data_conversao.log
    echo "Conversão realizada com sucesso"
else
    echo "Houve uma falha no processo de conversão. Por favor, verifique o arquivo de log em $DIRETORIO_LOGS/\
    log-conversao-$data_conversao.log"
fi
