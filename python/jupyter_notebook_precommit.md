### .pre-commit-config.yaml
``` yaml
repos:
 - repo: local
   hooks:
    - id: jupyter-nb-clear-output
      name: jupyter-nb-clear-output
      files: \.ipynb$
      stages: [commit]
      language: system
      entry: jupyter nbconvert --ClearOutputPreprocessor.enabled=True —inplace
```

`conda install -c conda-forge pre-commit or pip install pre-commit`

`pre-commit install (from git dir in conda environment)`

> Reference: https://zhauniarovich.com/post/2020/2020-06-clearing-jupyter-output/![image](https://user-images.githubusercontent.com/213203/156226458-f3b5119d-dd65-488e-9b8a-daa9f2c75a56.png)
