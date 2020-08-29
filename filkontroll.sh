#!/bin/bash


FILNAVN=$1
EXISTS=false


declare -i TIDSINTERVALL=$2

echo "Filnavn: $FILNAVN, Intervall: $TIDSINTERVALL sekund(er)"

if [ "$TIDSINTERVALL" -lt 1 ]; then
    echo "Intervallet må være minst 1 sekund."
    exit 0
fi


if [ -f "$FILNAVN" ]; then
    echo "$FILNAVN finnes allerede."
    EXISTS=true
    LASTMODIFIED=$(stat -c %Y "$FILNAVN")
    echo "Sist endret: $LASTMODIFIED"
else
    echo "$FILNAVN finnes ikke."
fi

while true; do
    if [ "$EXISTS" = true ]; then
        if [ ! -f "$FILNAVN" ]; then
            echo "Filen $FILNAVN ble slettet."
            EXISTS=false
        elif [ ! "$LASTMODIFIED" = "$(stat -c %Y "$FILNAVN")" ]; then
            echo "Filen $FILNAVN ble oppdatert."
            LASTMODIFIED=$(stat -c %Y "$FILNAVN")
        fi
    elif [ -f "$FILNAVN" ]; then
        echo "Filen $FILNAVN ble opprettet."
        EXISTS=true
        LASTMODIFIED=$(stat -c %Y "$FILNAVN")
    fi
    sleep "$TIDSINTERVALL"
done
