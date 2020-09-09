#!/bin/bash


FILNAVN=$1
exists=false


declare -i TIDSINTERVALL=$2

echo "Filnavn: $FILNAVN, Intervall: $TIDSINTERVALL sekund(er)"

if [ "$TIDSINTERVALL" -lt 1 ]; then
    echo "Intervallet må være minst 1 sekund."
    exit 0
fi


if [ -e "$FILNAVN" ]; then
    echo "$FILNAVN finnes allerede."
    exists=true
    last_modified=$(stat -c %Y "$FILNAVN")
    # echo "Sist endret: $last_modified"
else
    echo "$FILNAVN finnes ikke."
fi

while true; do
    if [ "$exists" = true ]; then
        if [ ! -e "$FILNAVN" ]; then
            echo "Filen $FILNAVN ble slettet."
            exists=false
        elif [ ! "$last_modified" = "$(stat -c %Y "$FILNAVN")" ]; then
            echo "Filen $FILNAVN ble oppdatert."
            last_modified=$(stat -c %Y "$FILNAVN")
        fi
    elif [ -e "$FILNAVN" ]; then
        echo "Filen $FILNAVN ble opprettet."
        exists=true
        last_modified=$(stat -c %Y "$FILNAVN")
    fi
    sleep "$TIDSINTERVALL"
done
