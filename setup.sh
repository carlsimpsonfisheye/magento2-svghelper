#!/usr/bin/env bash

set -e # Exit on error

# Install Magento 2 if necessary
magento-installer

cd $MAGENTO_ROOT

# Add the extension via Composer
composer config repositories.meanbee_svghelper '{"type": "path", "url": "/src", "options": {"symlink": true}}'

composer require "meanbee/magento2-svghelper" "@dev"

# Workaround for Magento only allowing template paths within the install root
ln -s /src $MAGENTO_ROOT/src

# Enable the extension and run migrations
magento-command module:enable Meanbee_SVGHelper
magento-command setup:upgrade
magento-command setup:static-content:deploy
magento-command cache:flush