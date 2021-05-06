

for i in *.tar.gz
    gzip -dc $i | tar xf -
end
