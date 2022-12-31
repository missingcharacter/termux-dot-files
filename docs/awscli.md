# Install AWS CLI

<!-- markdownlint-disable MD013 -->

```shell
$ pkg install git python rust build-essential
$ git clone -b v2 https://github.com/aws/aws-cli.git
$ python -m venv venv
$ source venv/bin/activate
$ vim setup.cfg
$ pip install ruamel.yaml==0.17.17 awscrt==0.13.0
$ pip install -e .
$ aws --version
aws-cli/2.7.29 Python/3.10.6 Linux/5.10.107-android13-4-00008-g466e95df8c7c-ab8760753 source/aarch64 prompt/off
```

<!-- markdownlint-enable MD013 -->
