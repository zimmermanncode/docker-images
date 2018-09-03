source /nodely-install.bash

python -m notebook --allow-root                                             \
    --ip 0.0.0.0 --no-browser                                               \
    "$@"
