#!/bin/bash
#
# asteriskActiveCalls.sh - Programa feito para checar a quantidade de chamadas simultaneas
# do Asterisk e bilhetar dentro de um arquivo
#
# Autor: Anderson Freitas <tmsi.freitas@gmail.com>
# Site: http://www.dialplanreload.com/
# Repositorio: https://github.com/DialplanReload/AAC
#
# Desenvolvido sob licensa GPL. 
# Fique a vontade para contribuir com a evolucao deste programa.
#
#-----------------------------------------------------------------------------------------------
#
#
# Execucao simples - ./asteriskActiveCalls.sh
#
#
date=$(date +%d%h%Y_%H:%M)
directory=(/root/)

is_number() {
    re='^[0-9]+$'
    if ! [[ $1 =~ $re ]]; then
        echo 0
    fi

    echo 1
}

calls=$(rasterisk -x "core show channels verbose" | grep "active call" | awk '{print $1}')

if [ -z $calls ]; then
    echo -1
    exit -1
fi

if [ $(is_number $calls) -gt 0 ]
then
    echo $calls           $date >> $directory/callsHistory.md
    exit 0
else
    echo -1
    exit -1

fi
