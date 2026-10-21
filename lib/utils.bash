#!/usr/bin/env bash

set -euo pipefail

GH_REPO="https://github.com/yonaskolb/Mint"
TOOL_NAME="mint"
TOOL_TEST="mint --help"

fail() {
	echo -e "asdf-$TOOL_NAME: $*"
	exit 1
}

curl_opts=(-fsSL)

if [ -n "${GITHUB_API_TOKEN:-}" ]; then
	curl_opts=("${curl_opts[@]}" -H "Authorization: token $GITHUB_API_TOKEN")
fi

list_github_tags_sorted() {
	git -c 'versionsort.suffix=-beta' ls-remote --tags --refs --sort version:refname "$GH_REPO" |
		grep -o 'refs/tags/.*' | cut -d/ -f3- |
		sed 's/^v//' # NOTE: You might want to adapt this sed to remove non-version strings from tags
}

list_all_versions_sorted() {
	# TODO: Adapt this. By default we simply list the tag names from GitHub releases.
	# Change this function if mint has other means of determining installable versions.
	list_github_tags_sorted
}

get_os() {
	case "$(uname -s)" in
	Darwin) echo "darwin" ;;
	Linux) echo "linux" ;;
	*) fail "asdf-$TOOL_NAME: unsupported OS $(uname -s)" ;;
	esac
}

download_release() {
	local version download_path
	version="$1"
	download_path="$2"

	case "$(get_os)" in
	darwin) download_release_macos "$version" "$download_path" ;;
	linux) build_release_linux "$version" "$download_path" ;;
	esac
}

download_release_macos() {
	local version download_path filename url
	version="$1"
	download_path="$2"
	filename="$download_path/mint.zip"
	url="$GH_REPO/releases/download/${version}/mint.zip"

	echo "* Downloading $TOOL_NAME release $version..."
	curl "${curl_opts[@]}" -o "$filename" -C - "$url" || fail "Could not download $url"

	unzip -o "$filename" -d "$download_path" >/dev/null || fail "Could not extract $filename"
	rm "$filename"
}

build_release_linux() {
	local version download_path src_dir
	version="$1"
	download_path="$2"
	src_dir="$download_path/src"

	command -v swift >/dev/null 2>&1 || fail "Swift toolchain not found in PATH. Install it first (e.g. 'mise use -g swift@latest' or 'asdf plugin add swift') before installing $TOOL_NAME on Linux."
	command -v git >/dev/null 2>&1 || fail "git is required to build $TOOL_NAME from source on Linux."

	echo "* No prebuilt Linux binary is published for $TOOL_NAME $version; building from source..."
	git clone --quiet --branch "$version" --depth 1 "$GH_REPO" "$src_dir" 2>/dev/null ||
		git clone --quiet --branch "v$version" --depth 1 "$GH_REPO" "$src_dir" ||
		fail "Could not clone $GH_REPO at tag $version or v$version"

	(cd "$src_dir" && swift build -c release) || fail "swift build failed for $TOOL_NAME $version"

	install -m 755 "$src_dir/.build/release/mint" "$download_path/mint" || fail "Could not install built $TOOL_NAME binary"
	rm -rf "$src_dir"
}

install_version() {
	local install_type="$1"
	local version="$2"
	local install_path="${3%/bin}/bin"

	if [ "$install_type" != "version" ]; then
		fail "asdf-$TOOL_NAME supports release installs only"
	fi

	(
		mkdir -p "$install_path"
		cp -r "$ASDF_DOWNLOAD_PATH"/* "$install_path"

		# TODO: Assert mint executable exists.
		local tool_cmd
		tool_cmd="$(echo "$TOOL_TEST" | cut -d' ' -f1)"
		test -x "$install_path/$tool_cmd" || fail "Expected $install_path/$tool_cmd to be executable."

		echo "$TOOL_NAME $version installation was successful!"
	) || (
		rm -rf "$install_path"
		fail "An error occurred while installing $TOOL_NAME $version."
	)
}
