#!/usr/bin/env bats

load test_helper

setup() {
  export PYENV_ROOT="${TMP}/pyenv"
  export PYENV_VERSION="3.3.3"
  create_executable "python" <<-EOS
#!/usr/bin/env bash
echo python is invoked
EOS
  create_executable "virtualenv" <<-EOS
#!/usr/bin/env bash
echo virtualenv is invoked
EOS
  create_executable "virtualenv-clone" <<-EOS
#!/usr/bin/env bash
echo virtualenv-clone is invoked
EOS
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

@test "install virtualenvwrapper if not available" {
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "prefix ${PYENV_VERSION} : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}\""
  stub pyenv "which virtualenvwrapper.sh : false"
  stub pyenv "exec pip install virtualenvwrapper : d=\"${PYENV_ROOT}/versions/${PYENV_VERSION}/bin\";mkdir -p \"\$d\";touch \"\$d/virtualenvwrapper.sh\";touch \"\$d/virtualenvwrapper_lazy.sh\";echo \"\$@\""
  stub pyenv "which virtualenvwrapper.sh : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/virtualenvwrapper.sh\""

  VIRTUALENVWRAPPER_VERSION="" run pyenv-sh-virtualenvwrapper

  unstub pyenv
  assert_success
  assert_output_contains "exec pip install virtualenvwrapper"
}

@test "install virtualenvwrapper version if not available" {
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "prefix ${PYENV_VERSION} : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}\""
  stub pyenv "which virtualenvwrapper.sh : false"
  stub pyenv "exec pip install virtualenvwrapper==4.2 : d=\"${PYENV_ROOT}/versions/${PYENV_VERSION}/bin\";mkdir -p \"\$d\";touch \"\$d/virtualenvwrapper.sh\";touch \"\$d/virtualenvwrapper_lazy.sh\";echo \"\$@\""
  stub pyenv "which virtualenvwrapper.sh : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/virtualenvwrapper.sh\""

  VIRTUALENVWRAPPER_VERSION="4.2" run pyenv-sh-virtualenvwrapper

  unstub pyenv
  assert_success
  assert_output_contains "exec pip install virtualenvwrapper==4.2"
}

@test "install virtualenvwrapper with unsetting troublesome pip options" {
  stub pyenv "version-name : echo \"${PYENV_VERSION}\""
  stub pyenv "prefix ${PYENV_VERSION} : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}\""
  stub pyenv "which virtualenvwrapper.sh : false"
  stub pyenv "exec pip install virtualenvwrapper : d=\"${PYENV_ROOT}/versions/${PYENV_VERSION}/bin\";mkdir -p \"\$d\";touch \"\$d/virtualenvwrapper.sh\";touch \"\$d/virtualenvwrapper_lazy.sh\";echo PIP_REQUIRE_VENV=\${PIP_REQUIRE_VENV} \"\$@\""
  stub pyenv "which virtualenvwrapper.sh : echo \"${PYENV_ROOT}/versions/${PYENV_VERSION}/bin/virtualenvwrapper.sh\""

  PIP_REQUIRE_VENV="true" VIRTUALENVWRAPPER_VERSION="" run pyenv-sh-virtualenvwrapper

  unstub pyenv
  assert_success
  assert_output_contains "PIP_REQUIRE_VENV= exec pip install virtualenvwrapper"
}
