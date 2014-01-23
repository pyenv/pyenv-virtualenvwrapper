#!/usr/bin/env bats

load test_helper

setup() {
  export PYENV_ROOT="${TMP}/pyenv"
  export PYENV_VIRTUALENVWRAPPER_VERSION="20140122"
}

@test "display virtualenvwrapper version" {
  stub pyenv "pip show virtualenvwrapper: echo \"---\";echo \"Name: virtualenvwrapper\";echo \"Version: 4.2\""
  run eval "$(pyenv-sh-virtualenvwrapper --version)"
  unstub pyenv
  assert_success
  assert_output_contains "pyenv-virtualenvwrapper ${PYENV_VIRTUALENVWRAPPER_VERSION} (virtualenvwrapper 4.2)"
}

@test "display virtualenvwrapper_lazy version" {
  stub pyenv "pip show virtualenvwrapper: echo \"---\";echo \"Name: virtualenvwrapper\";echo \"Version: 4.2\""
  run eval "$(pyenv-sh-virtualenvwrapper_lazy --version)"
  unstub pyenv
  assert_success
  assert_output_contains "pyenv-virtualenvwrapper ${PYENV_VIRTUALENVWRAPPER_VERSION} (virtualenvwrapper 4.2)"
}
