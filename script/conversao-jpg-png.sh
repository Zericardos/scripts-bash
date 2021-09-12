#!/bin/bash

# Criar uma estrutura de pastas igual ao lado da pasta a ser modificada. arquivo de log também ao lado
# Verificar a possibilidade de colocar condição de caminho absoluto ou relativo a aplicação

data_conversao=$(date '+%F')
horario_conversao=$(date '+%2H:%2M:%S')

percorre_arquivos_converte(){
    cd $1
    diretorios_locais=()
    for arquivo in *;do
        caminho_arquivo=$(find $DIRETORIO_ORIGINAL -name $arquivo)
        if [ -d $caminho_arquivo ];then
            diretorios_locais+=($caminho_arquivo)
        else
            if [[ $arquivo =~ \.jpg$ ]];then
                converte_imagem $arquivo $caminho_arquivo
            fi
        fi
    done
    for diretorio in $diretorios_locais;do
        percorre_arquivos_converte $diretorio
    done
}
# encontrar um jeito de pegar os nomes dos diretorios locais e empregá-los junto aos nomes das imagens para espelhar a
# mesma estrutura de arquivos original
converte_imagem(){
    local $PNG/nome_imagem=$(ls $1 | awk -F. '{ print $1 }')
    convert $2 $DIRETORIO_ORIGINAL/png/$nome_imagem.png
}

DIRETORIO_ORIGINAL=$1

cd $DIRETORIO_ORIGINAL
find . -type d > dirs.txt
cd ..
# aplicar comando case para substituir esses ifs abaixo
if [ ! -d png ]
    then
        mkdir png
fi
if [ ! -d log ]
    then
        mkdir log
fi

cd png
PNG=realpath .
xargs mkdir -p < $DIRETORIO_ORIGINAL/dirs.txt
cd $DIRETORIO_ORIGINAL
rm dirs.txt



echo $data_conversao,$horario_conversao >> log/log-conversao-$data_conversao.log

percorre_arquivos_converte $DIRETORIO_ORIGINAL 2>> log/log-conversao-$data_conversao.log

cd $DIRETORIO_ORIGINAL

if [ $? -eq 0 ]
    then
        echo "Conversão realizada com sucesso" >> log/log-conversao-$data_conversao.log
        echo "Conversão realizada com sucesso"
else
    echo "Houve uma falha no processo de conversão. Por favor, verifique o arquivo de log em $DIRETORIO_ORIGINAL/../log"
fi
