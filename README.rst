Installation
============

Bashir can be installed by ``setup-arch.sh`` scripts by including the code
snippet below.

.. code-block:: bash

    if ! which bashir &> /dev/null; then
        cd /tmp
        git clone gitolite@foxdogstudios.com:bashir
        ./bashir/scripts/install.sh
        rm -fr bashir
    fi

