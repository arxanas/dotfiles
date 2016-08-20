#!/bin/bash

gitignore() {
    curl -L -s https://www.gitignore.io/api/"$*"
}
