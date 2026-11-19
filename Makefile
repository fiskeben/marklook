APP := build/Build/Products/Release/MarkdownPreview.app
INSTALL_DIR := $(HOME)/Applications
LSREGISTER := /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister

.PHONY: all project build test install uninstall clean

all: build

project:
	xcodegen generate

build: project
	xcodebuild -project MarkdownPreview.xcodeproj -scheme MarkdownPreview \
		-configuration Release -derivedDataPath build build

test:
	cd MarkdownRenderer && swift test

# Finder keeps extension processes alive and reuses them, so after replacing
# the bundle it must be relaunched or previews fail with "No valid extension".
install: build
	-pkill -f MarkdownQuickLook.appex
	mkdir -p "$(INSTALL_DIR)"
	rm -rf "$(INSTALL_DIR)/MarkdownPreview.app"
	cp -R "$(APP)" "$(INSTALL_DIR)/"
	# xcodebuild registers the build product too; keep only the installed copy.
	-pluginkit -r "$(APP)/Contents/PlugIns/MarkdownQuickLook.appex"
	-$(LSREGISTER) -u "$(APP)"
	open -g "$(INSTALL_DIR)/MarkdownPreview.app"
	qlmanage -r >/dev/null 2>&1; qlmanage -r cache >/dev/null 2>&1
	killall Finder
	@echo "Installed. Select a .md file in Finder and press Space."

uninstall:
	-pkill -f MarkdownQuickLook.appex
	pluginkit -r "$(INSTALL_DIR)/MarkdownPreview.app/Contents/PlugIns/MarkdownQuickLook.appex" || true
	rm -rf "$(INSTALL_DIR)/MarkdownPreview.app"
	qlmanage -r >/dev/null 2>&1

clean:
	rm -rf build MarkdownPreview.xcodeproj MarkdownRenderer/.build
