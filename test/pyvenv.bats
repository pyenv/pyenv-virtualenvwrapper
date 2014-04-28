#!/usr/bin/env bats

load test_helper

setup() {
  export PYENV_ROOT="${TMP}/pyenv"
  PYENV_VERSION="3.3.3" create_executable "python" <<EOS
#!/usr/bin/env bash
echo python is invoked
EOS
  PYENV_VERSION="3.3.3" create_executable "virtualenv" <<EOS
#!/usr/bin/env bash
echo virtualenv is invoked
EOS
  PYENV_VERSION="3.3.3" create_executable "virtualenv-clone" <<EOS
#!/usr/bin/env bash
echo virtualenv-clone is invoked
EOS

  install -p "${BATS_TEST_DIRNAME}/virtualenvwrapper"/* "${PYENV_ROOT}/versions/3.3.3/bin/"
}

create_executable() {
  name="${1?}"
  shift 1
  bin="${PYENV_ROOT}/versions/${PYENV_VERSION}/bin"
  mkdir -p "$bin"
  { if [ $# -eq 0 ]; then cat -
    else echo "$@"
    fi
  } | sed -Ee '1s/^ +//' > "${bin}/$name"
  chmod +x "${bin}/$name"
}

gen_script() {
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "prefix ${PYENV_VERSION} : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}\""

  run pyenv-sh-virtualenvwrapper

  unstub pyenv
  assert_success

  echo "${output%;}"
}

@test "prefer virtualenv by default" {
  export PYENV_VERSION="3.3.3"
  unset PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV
  rm -f "${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/pyvenv"

  script="$(gen_script)"

  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""

  run eval "${script}; mkvirtualenv venv33"

  unstub pyenv
  assert_success
  assert_output <<EOS
virtualenvwrapper.sh is loaded
virtualenvwrapper_verify_workon_home is invoked
PYTHON=${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/python VIRTUALENV=${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/virtualenv mkvirtualenv venv33
EOS
}

@test "prefer pyvenv if PYENV_VIRTUALENVWRAPPER_REFER_PYVENV has set" {
  export PYENV_VERSION="3.3.3"
  export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=1
  PYENV_VERSION="3.3.3" create_executable "pyvenv" <<EOS
#!/usr/bin/env bash
echo virtualenv is invoked
EOS

  script="$(gen_script)"

  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""

  run eval "${script}; mkvirtualenv venv33"

  unstub pyenv
  assert_success
  assert_output <<EOS
virtualenvwrapper.sh is loaded
virtualenvwrapper_verify_workon_home is invoked
PYTHON=${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/python VIRTUALENV=${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/pyvenv mkvirtualenv venv33
EOS
}

@test "prefer virtualenv if PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV does not exist" {
  export PYENV_VERSION="3.3.3"
  export PYENV_VIRTUALENVWRAPPER_PREFER_PYVENV=1
  rm -f "${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/pyvenv"

  script="$(gen_script)"

  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""

  run eval "${script}; mkvirtualenv venv33"

  unstub pyenv
  assert_success
  assert_output <<EOS
virtualenvwrapper.sh is loaded
virtualenvwrapper_verify_workon_home is invoked
PYTHON=${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/python VIRTUALENV=${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/virtualenv mkvirtualenv venv33
EOS
}
