#!/bin/sh

set -e

virtualenv --no-site-packages .env
export PATH="$PWD/.env/bin:$PATH"
for pkg in pip setuptools wheel
do
  pip install -U "${pkg?}"
done

# Old systems that still have distribute will choke on some of the
# newer libraries, But once we've set up setuptools we can just remove
# it. The `|| true` is for newer systems with no distribute -- if the
# package isn't present this command will fail.
pip uninstall -y distribute || true

pip install -e .
