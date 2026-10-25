#!/bin/bash

geometry=$(slurp) || exit 0
grim -g "$geometry" - | swappy -f -
