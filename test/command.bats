#!/usr/bin/env bats

load test_helper

setup() {
  export PYENV_ROOT="${TMP}/pyenv"
}

@test "library functions for virtualenvwrapper" {
  run pyenv-virtualenvwrapper --lib
  assert_success
  assert_output_contains "lib ()"
}

@test "library functions for virtualenvwrapper_lazy" {
  run pyenv-virtualenvwrapper_lazy --lib
  assert_success
  assert_output_contains "lib ()"
}

@test "virtualenvwrapper cannot be invoked as command" {
  run pyenv-virtualenvwrapper
  assert_failure
}

@test "virtualenvwrapper_lazy cannot be invoked as command" {
  run pyenv-virtualenvwrapper_lazy
  assert_failure
}
