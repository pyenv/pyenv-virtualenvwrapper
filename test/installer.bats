#!/usr/bin/env bats

load test_helper

@test "installs pyenv-virtualenvwrapper into PREFIX" {
  cd "$TMP"
  PREFIX="${PWD}/usr" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success ""

  cd usr

  assert [ -x bin/pyenv-sh-virtualenvwrapper ]
  assert [ -x bin/pyenv-sh-virtualenvwrapper_lazy ]
  assert [ -x bin/pyenv-virtualenvwrapper ]
  assert [ -x bin/pyenv-virtualenvwrapper_lazy ]
}

@test "overwrites old installation" {
  cd "$TMP"
  mkdir -p bin
  touch bin/pyenv-virtualenvwrapper

  PREFIX="$PWD" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success ""

  assert [ -x bin/pyenv-virtualenvwrapper ]
  run grep "virtualenvwrapper" bin/pyenv-virtualenvwrapper
  assert_success
}

@test "unrelated files are untouched" {
  cd "$TMP"
  mkdir -p bin share/bananas
  chmod g-w bin
  touch bin/bananas

  PREFIX="$PWD" run "${BATS_TEST_DIRNAME}/../install.sh"
  assert_success ""

  assert [ -e bin/bananas ]

  run ls -ld bin
  assert_equal "r-x" "${output:4:3}"
}
