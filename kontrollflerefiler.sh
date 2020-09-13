#!/usr/bin/env bash

FILER=$*

if [ ! "$FILER" ]; then
    echo "Ingen filer er definert"
    exit 0
fi

# Ensure entire group is killed.
# Negating the scripts process id (-$$ part) tells kill to kill the entire process group.
trap 'kill -- -$$' EXIT


echo "Kontrollerer filer: $FILER"

for FIL in $FILER ; do
    ./filkontroll.sh "$FIL" 60 &
done

wait
