#!/usr/bin/env bash

set -x

export CGO_ENABLED="1"
export GO111MODULE=on

rm -r packages
rm -r /usr/local/go/pkg/linux_amd64_dynlink/

# Works fine, output in "packages"
go install -pkgdir packages -buildmode=shared std

# Does not output anything, no errors
#go install -pkgdir packages -buildmode=shared -linkshared myLibrary/myLibrary.go

# Fails, building dynamically linked plugins does not work
go build -pkgdir packages -buildmode=plugin -linkshared -o build/myPlugin.so myPlugin/myPlugin.go

# Works, dynamically linked application
go build -pkgdir packages -linkshared -o build/myApplication myApplication/myApplication.go
