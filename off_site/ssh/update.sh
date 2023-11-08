#!/bin/bash

for host in $(ssh psbuild /cds/sw/tools/bin/netconfig search \'*\' --brief|sort|grep -e "^ioc-" -e "^ctl-" -e "-console" -e "-daq" | grep -v -e "psbuild" -e "pslogin"); do
  echo "Host $host"; echo "    ProxyJump %r@psbuild";
done
