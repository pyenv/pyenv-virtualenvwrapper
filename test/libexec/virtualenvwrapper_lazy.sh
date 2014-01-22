#!/usr/bin/env bash

echo "virtualenvwrapper_lazy.sh is loaded"

VIRTUALENVWRAPPER_SCRIPT="${VIRTUALENVWRAPPER_SCRIPT:-undefined}"

virtualenvwrapper_load() {
  echo "virtualenvwrapper_load is invoked"
}

mkvirtualenv() {
  virtualenvwrapper_load
  mkvirtualenv "$@"
}

lsvirtualenv() {
  virtualenvwrapper_load
  lsvirtualenv "$@"
}
