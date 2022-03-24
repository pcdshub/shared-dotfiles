#!/bin/bash

shellcheck ./*.sh
shellcheck ./off_site/bash*
shellcheck ./on_site/bash*
cd tests && make
