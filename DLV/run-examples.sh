#!/usr/bin/env bash

for file in examples/*/*.dlv
do
#  dlv rcc5 bl sd de "$file" -silent -stats -v -filter=e,o,pp 2> "$file".stats > "$file".out  # Don't use if |PWs| is large ... 
  dlv rcc5 bl sd de "$file" -silent -stats -v -filter=e,o,pp 2> "$file".stats > /dev/null
done
