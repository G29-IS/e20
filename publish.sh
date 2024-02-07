#!/bin/sh

flutter build web
git subtree push --prefix build/web origin gh-pages