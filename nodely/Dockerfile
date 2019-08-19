FROM node:slim

RUN apt-get update                                                          \
 && apt-get install --yes --no-install-recommends                           \
        bzip2                                                               \
        dos2unix                                                            \
        gcc                                                                 \
        python                                                              \
        python-dev                                                          \
        wget                                                                \
                                                                            \
 && wget -O - https://bootstrap.pypa.io/get-pip.py                          \
  | python -                                                                \
                                                                            \
 && pip install --no-cache-dir                                              \
        mercurial                                                           \
                                                                            \
 && apt-get purge --yes --auto-remove                                       \
        gcc                                                                 \
        python-dev                                                          \
        python3                                                             \
                                                                            \
 && apt-get clean                                                           \
 && rm -rf /var/lib/apt/lists/*

ENV CONDA_ROOT=/opt/conda                                                   \
    CONDA_ROOT_PACKAGES="                                                   \
        jupyter                                                             \
        nb_conda                                                            \
        "

RUN wget -O /Miniconda3.sh                                                  \
    https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh   \
                                                                            \
 && bash /Miniconda3.sh -b -p "${CONDA_ROOT}"                               \
 && rm /Miniconda3.sh                                                       \
                                                                            \
 && ln -s "${CONDA_ROOT}/bin/conda" /usr/local/bin/conda                    \
 && conda install --yes ${CONDA_ROOT_PACKAGES}

ENV PYTHON_PACKAGES="                                                       \
        nodely>=0.4.0                                                       \
        "

ADD nodely-install.bash /
RUN dos2unix /nodely-install.bash

ADD nodely-entrypoint-no-install.bash /
RUN dos2unix /nodely-entrypoint-no-install.bash

ADD nodely-entrypoint.bash /
RUN dos2unix /nodely-entrypoint.bash

ENTRYPOINT [ "/bin/bash", "/nodely-entrypoint.bash" ]
