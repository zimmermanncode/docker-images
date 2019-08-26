FROM zimmermanncode/nodely:latest

ENV PYTHON_PACKAGES="                                                       \
        ${PYTHON_PACKAGES}                                                  \
        morepy>=0.1.0                                                       \
        "

ADD morepy-install.bash /
RUN dos2unix /morepy-install.bash

ADD morepy-entrypoint-no-install.bash /
RUN dos2unix /morepy-entrypoint-no-install.bash

ADD morepy-entrypoint.bash /
RUN dos2unix /morepy-entrypoint.bash

ENTRYPOINT [ "/bin/bash", "/morepy-entrypoint.bash" ]
