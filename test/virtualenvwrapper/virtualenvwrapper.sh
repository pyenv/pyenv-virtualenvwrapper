#!/usr/bin/env bash

echo "virtualenvwrapper.sh is loaded"

VIRTUALENVWRAPPER_PYTHON="${VIRTUALENVWRAPPER_PYTHON:-undefined}"
VIRTUALENVWRAPPER_VIRTUALENV="${VIRTUALENVWRAPPER_VIRTUALENV:-undefined}"
VIRTUALENVWRAPPER_VIRTUALENV_CLONE="${VIRTUALENVWRAPPER_VIRTUALENV_CLONE:-undefined}"

virtualenvwrapper_verify_resource() {
  echo "virtualenvwrapper_verify_resource is invoked"
}

virtualenvwrapper_verify_workon_home() {
  echo "virtualenvwrapper_verify_workon_home is invoked"
}

virtualenvwrapper_verify_virtualenv() {
  virtualenvwrapper_verify_resource "${VIRTUALENVWRAPPER_VIRTUALENV}"
}

mkvirtualenv() {
  virtualenvwrapper_verify_workon_home || return 1
  virtualenvwrapper_verify_virtualenv || return 1
  echo "PYTHON=${VIRTUALENVWRAPPER_PYTHON} VIRTUALENV=${VIRTUALENVWRAPPER_VIRTUALENV} mkvirtualenv $@"
}

lsvirtualenv() {
  virtualenvwrapper_verify_workon_home || return 1
  echo "PYTHON=${VIRTUALENVWRAPPER_PYTHON} VIRTUALENV=${VIRTUALENVWRAPPER_VIRTUALENV} lsvirtualenv"
}
