#
# MIT License
#
# (C) Copyright 2024 Hewlett Packard Enterprise Development LP
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
# OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
# ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
# OTHER DEALINGS IN THE SOFTWARE.
#
# If you wish to perform a local build, you will need to clone or copy the contents of the
# cms-meta-tools repo to ./cms_meta_tools

runbuildprep:
		./cms_meta_tools/scripts/runBuildPrep.sh

lint:
		./cms_meta_tools/scripts/runLint.sh

pymod_build:
		${PY_BIN} --version
		${PY_BIN} -m pip install --upgrade --user pip build setuptools wheel
		${PY_BIN} -m build --sdist
		${PY_BIN} -m build --wheel

pymod_lint_setup:
		${PY_BIN} -m pip install --user pylint
		${PY_BIN} -m pip install --user \
			--trusted-host arti.hpc.amslabs.hpecorp.net \
			--trusted-host artifactory.algol60.net \
			--index-url https://arti.hpc.amslabs.hpecorp.net:443/artifactory/api/pypi/pypi-remote/simple \
			--extra-index-url http://artifactory.algol60.net/artifactory/csm-python-modules/simple \
			./dist/bos_utils*.whl 

pymod_lint_errors:
		${PY_BIN} -m pylint --py-version ${MIN_PY_VERSION} --errors-only bos_utils

pymod_lint_full:
		${PY_BIN} -m pylint --py-version ${MIN_PY_VERSION} --fail-under 9 bos_utils
