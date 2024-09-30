#!/bin/bash

dart run easiest_localization

echo "Setting new source"

find "./localization/merged" -type f -exec sed -i '' 's/Easiest Localization/Remote Easiest Localization/g' {} +

echo "Done!"