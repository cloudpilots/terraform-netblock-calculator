#!/bin/bash
# generate README with terraform-docs

terraform-docs markdown . --output-file README.md
