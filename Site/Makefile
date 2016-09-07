PATH          := $(PROJECT_HOME)/WDK/View/node_modules/.bin:$(PATH)
SHELL         := /bin/bash

site_bundle  := dist/wdkCustomization/js/common.build.js
site_source  := $(PROJECT_HOME)/EuPathSiteCommon/Site/webapp/wdkCustomization/js/common.js

.PHONY: all clean

all: $(site_bundle)

clean:
	rm -rf $(site_bundle)

$(site_bundle): $(site_source)
	webpack --config $(PROJECT_HOME)/EuPathSiteCommon/Site/webpack.config.js $< $@
