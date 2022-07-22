#!/bin/bash

gs      -sOutputFile=output.pdf \
        -q -dNOPAUSE -dBATCH -dSAFER \
        -sDEVICE=pdfwrite \
        -dCompatibilityLevel=1.3 \
        -dPDFSETTINGS=/screen \
        -dEmbedAllFonts=true \
        -dSubsetFonts=true \
        -sColorConversionStrategy=/Mono \
        -sColorConversionStrategyForImages=/Mono \
        -sProcessColorModel=/DeviceGray \
        $1
