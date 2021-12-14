# Install AWS CLI

```shell
$ curl -sL 'https://github.com/Termux-pod/termux-pod/raw/main/aarch64/python/python-3.9.7/python_3.9.7_aarch64.deb' -o python_3.9.7_aarch64.deb
$ dpkg -i python_3.9.7_aarch64.deb
$ git clone https://github.com/aws/aws-cli.git
$ cd aws-cli
$ git checkout v2
$ python -m venv venv
$ source venv/bin/activate
$ vim setup.cfg
$ git diff
diff --git a/setup.cfg b/setup.cfg
index d7f8c2cca..cd9adacaf 100644
--- a/setup.cfg
+++ b/setup.cfg
@@ -31,7 +31,7 @@ install_requires =
     colorama>=0.2.5,<0.4.4
     docutils>=0.10,<0.16
     cryptography>=3.3.2,<3.4.0
-    ruamel.yaml>=0.15.0,<0.16.0
+    ruamel.yaml>=0.15.0,<0.17.18
     wcwidth<0.2.0
     prompt-toolkit>=2.0.0,<3.0.0
     distro>=1.5.0,<1.6.0
$ pip install ruamel.yaml==0.17.17
$ pip install -e .
$  aws --version
aws-cli/2.4.6 Python/3.9.7 Linux/5.10.43-android12-9-00001-g3b35c4eea2da-ab7739787 source/aarch64 prompt/off
```
