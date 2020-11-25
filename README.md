# docker-kubeval

## Ultra brief description (straight to the point)

Kubeval docker image built from alpine to run CircleCI pipelines.
Please note that, although the scope is quite simple and straightforward, this image is not built to run on production environments. Use it under your own risk.

## Ok, tell me how to use it

### Running locally

If you want to see it working outside your pipeline, use the below docker run command to evaluate your yaml files (note that you will have to pass the directory where the yaml files are as a volume)

```sh
sudo docker run -it -v /your-yaml-dir:/kubeval --name kubeval lauan/kubeval
```

The result will be either PASS or ERR, depending on the content of the files

### Running on a CircleCI pipeline

Below you have a simple config.yml file to add as a pipeline spec on a CircleCI project. Use it as a starting point to build a more complex config.yml file.
If you want to use it exactly as it is, make sure to keep your yaml files in a folder called _specs_ on you repository root.

```yaml
version: 2.1
executors:
  jarbas:
    docker:
      - image: lauan/kubeval
jobs:
  build:
    executor: jarbas
    working_directory: /kubeval
    steps:
      - checkout
      - run:
          command: |
            kubeval -d /kubeval/specs
```

Thanks!
