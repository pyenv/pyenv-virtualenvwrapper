#!/usr/bin/env bats

load test_helper

setup() {
  export PYENV_ROOT="${TMP}/pyenv"
}

@test "display virtualenvwrapper version" {
  run eval "$(pyenv-sh-virtualenvwrapper --version)"
  assert_success
  assert_output_contains "pyenv-virtualenvwrapper v"
}

@test "display virtualenvwrapper_lazy version" {
  run eval "$(pyenv-sh-virtualenvwrapper_lazy --version)"
  assert_success
  assert_output_contains "pyenv-virtualenvwrapper_lazy v"
}
