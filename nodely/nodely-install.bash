expose-python-version () { cat << EOF > "/usr/local/bin/python$1"
#!/bin/bash
source "${CONDA_ROOT}/bin/activate" py"${1/./}"
python $(echo '"$@"')
EOF
chmod +x "/usr/local/bin/python$1"
}

for py_version in ${PYTHON_VERSIONS}
do
    py_version_nodot=(${py_version/./})
    conda_env_name="py${py_version_nodot}"
    conda create --yes --name "${conda_env_name}"                           \
        python="${py_version}"                                              \
        ipykernel                                                           \
        ipython

    expose-python-version ${py_version}

    "python${py_version}" -m pip install                                    \
        ${PYTHON_PACKAGES}                                                  \
        nodely

    for file in ${PYTHON_REQUIREMENT_FILES}
    do
        "python${py_version}" -m pip install --requirement ${file}
    done

    for dir in ${PYTHON_DEVELOPMENT_DIRS}
    do
        "python${py_version}" -m pip install --editable ${dir}
    done
done

python () {
    "${CONDA_ROOT}/bin/python" "$@"
}

pip_requirement_options=
for file in ${JUPYTER_EXTENSION_REQUIREMENT_FILES}
do
    pip_requirement_options="                                               \
        ${pip_requirement_options} --requirement ${file}"
done
python -m pip install ${pip_requirement_options}

for dir in ${JUPYTER_EXTENSION_DEVELOPMENT_DIRS}
do
    python -m pip install --editable ${dir}
done

for ext in ${JUPYTER_NOTEBOOK_EXTENSIONS}
do
    python -m notebook.nbextensions                                         \
        install --py ${ext} --sys-prefix

    python -m notebook.nbextensions                                         \
        enable --py ${ext} --sys-prefix
done

for ext in ${JUPYTER_SERVER_EXTENSIONS}
do
    python -m notebook.serverextensions enable ${ext}
done
