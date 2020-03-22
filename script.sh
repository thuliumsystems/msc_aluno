#!/bin/bash

#remove as 3 primeiras linhas
sed -e '1,3d' <arquivo.txt >sem_header.txt

#remove os espaços em branco e substitui por ;
awk '{$1=$1}1' OFS=";" sem_header.txt >sem_espacos.txt

#filtra apenas as colunas tempo e valor
cat sem_espacos.txt | cut -d ";" -f1,2 >filtrado.txt

#cria o cabeçalho
echo "time branch-instructions branch-misses bus-cycles cache-misses cache-references cpu-cycles instructions ref-cycles" >r.txt

y=1
while IFS=";" read -r time value; do
  if [ $y -eq 1 ]; then
    r_1=$value
  fi
  if [ $y -eq 2 ]; then
    r_2=$value
  fi
  if [ $y -eq 3 ]; then
    r_3=$value
  fi
  if [ $y -eq 4 ]; then
    r_4=$value
  fi
  if [ $y -eq 5 ]; then
    r_5=$value
  fi
  if [ $y -eq 6 ]; then
    r_6=$value
  fi
  if [ $y -eq 7 ]; then
    r_7=$value
  fi
  if [ $y -eq 8 ]; then
    r_8=$value
    #adiciona os valores linha por linha
    echo $time $r_1 $r_2 $r_3 $r_4 $r_5 $r_6 $r_7 $r_8 >>r.txt
    y=0
  fi
  let y=y+1
done <filtrado.txt