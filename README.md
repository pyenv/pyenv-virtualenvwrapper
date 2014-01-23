# pyenv-virtualenvwrapper

[![Build Status](https://travis-ci.org/yyuu/pyenv-virtualenvwrapper.png)](https://travis-ci.org/yyuu/pyenv-virtualenvwrapper)

An [alternative approach](https://github.com/yyuu/pyenv-virtualenv) to manage virtualenvs from pyenv.

pyenv-virtualenvwrapper is a [pyenv](https://github.com/yyuu/pyenv) plugin
which provides an `pyenv virtualenvwrapper` command to manage your virtualenvs
with [virtualenvwrapper](http://pypi.python.org/pypi/virtualenvwrapper).

## Installation

### Installing python

Because virtualenvwrapper is depending on python, you must first install
at least one version of python.

For example, install `2.7.6` and set it as `global` in pyenv.

    $ pyenv install 2.7.6
    $ pyenv global 2.7.6

(NOTICE: virtualenvwrapper will not work if you remove the python version
which is bound to virtualenvwrapper.)

### Installing pyenv-virtualenvwrapper as a pyenv plugin

Installing pyenv-virtualenvwrapper as a pyenv plugin will give you access to the
`pyenv virtualenvwrapper` and `pyenv virtualenvwrapper_lazy` command.

    $ git clone https://github.com/yyuu/pyenv-virtualenvwrapper.git ~/.pyenv/plugins/pyenv-virtualenvwrapper

This will install the latest development version of pyenv-virtualenvwrapper into
the `~/.pyenv/plugins/pyenv-virtualenvwrapper` directory. From that directory, you
can check out a specific release tag. To update pyenv-virtualenvwrapper, run `git
pull` to download the latest changes.

## Usage

### Using `pyenv virtualenvwrapper`

To setup a virtualenvwrapper into your shell, just run `pyenv virtualenvwrapper`.
For example,

    $ pyenv virtualenvwrapper

or, if you favor `virtualenvwrapper_lazy.sh`,

    $ pyenv virtualenvwrapper_lazy

## Version History

#### 20140122

  * Display errors when `pyenv virtualenvwrapper` is invoked as a command
  * Declare `VIRTUALENVWRAPPER_PYTHON` and `VIRTUALENVWRAPPER_VIRTUALENV` properly
    to follow the version changes in `pyenv` (#9, #10, #11)
  * Install `virtualenvwrapper` if it is not installed
  * Add `--unset` option for `virtualenvwrapper` and `virtualenvwrapper_lazy`
  * Fix broken install script
  * Add tests

#### 20130614

 * Improve error logging.

#### 20130306

 * Initial public release.

### License

(The MIT License)

* Copyright (c) 2013 Yamashita, Yuu

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
