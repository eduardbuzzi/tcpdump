#!/bin/bash
PLACA=$(ifconfig | cut -d ' ' -f1 | head -n1 | tail -n1 | sed 's/://')
principal () {
echo
echo "[1] Analyze 1 Host"
echo "[2] Analyze 2 Hosts"
echo "[3] Exit"
echo
read -p "Your Choice => " CHOICE
echo
case $CHOICE in
1) onehost;;
2) dualhosts;;
3) exit;;
*) principal;;
esac
}

tcpdumpp (){
read -p "Placa de Rede (Enter para usar $PLACA) ou use => " PLACARESPOSTA
if [[ "$PLACARESPOSTA" = "" ]]
then
PLACARESPOSTA=$PLACA
fi
echo
}

onehost (){
tcpdumpp
read -p "Informe o Host => " HOST
if [ -z $HOST ]
then
HOST=$(hostname -I | cut -d ' ' -f1)
tcpdump -vn -i $PLACA host $HOST
fi
tcpdump -vn -i $PLACA host $HOST
}

dualhosts () {
tcpdumpp
read -p "Informe o Primeiro Host => " HOST1
read -p "Informe o Segundo Host => " HOST2
if [ -z $HOST1 ] && [ -z $HOST2 ]
then
HOST1=$(hostname -I | cut -d ' ' -f1)
tcpdump -vn -i $PLACA host $HOST1
fi
if [ -z $HOST2 ]
then
tcpdump -vn -i $PLACA host $HOST1
fi
if [ -z $HOST1 ]
then
tcpdump -vn -i $PLACA host $HOST2
fi
echo
tcpdump -vn -i $PLACA host $HOST1 and $HOST2
}
principal
