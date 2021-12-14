# Install `saml2aws`

```shell
$ mkdir -p ${GOPATH}/src/github.com/Versent
$ mkdir -p ${GOPATH}/bin
$ export PATH="${PATH}:${GOPATH}/bin"
$ cd !$
$ git clone https://github.com/Versent/saml2aws.git
$ cd saml2aws
$ git checkout v2.33.0
$ make install
$ saml2aws login # should work now
```
