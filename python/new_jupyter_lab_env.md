Use the script below as a convenience script for spinning up new Jupyter Lab environments.

``` 
#!/bin/bash
source /usr/local/Caskroom/miniconda/base/etc/profile.d/conda.sh
conda create -y -n $1 python=3.9 jupyter
conda activate $1
confa install -y jupyterlab
conda install -y -c conda-forge jupyterlab-git jupyterlab-lsp python-lsp-server
jupyter lab build --minimize=False
```
