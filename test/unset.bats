#!/usr/bin/env bats

load test_helper

setup() {
  export PYENV_ROOT="${TMP}/pyenv"
}

@test "reset virtualenvwrapper" {
  run pyenv-sh-virtualenvwrapper --unset
  assert_success
  assert_output <<EOS
unset PYENV_VIRTUALENVWRAPPER_PYENV_VERSION
EOS
}

@test "reset virtualenvwrapper_lazy" {
  run pyenv-sh-virtualenvwrapper_lazy --unset
  assert_success
  assert_output <<EOS
unset PYENV_VIRTUALENVWRAPPER_PYENV_VERSION
EOS
}
