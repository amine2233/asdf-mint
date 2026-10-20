<div align="center">

# asdf-mint [![Build](https://github.com/amine2233/asdf-mint/actions/workflows/build.yml/badge.svg)](https://github.com/amine2233/asdf-mint/actions/workflows/build.yml) [![Lint](https://github.com/amine2233/asdf-mint/actions/workflows/lint.yml/badge.svg)](https://github.com/amine2233/asdf-mint/actions/workflows/lint.yml)

[mint](yonaskolb/Mint) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-mint  ](#asdf-mint--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
  - [asdf](#asdf)
  - [mise](#mise)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).
- On Linux, upstream [mint](https://github.com/yonaskolb/Mint) does not publish a
  prebuilt binary, so this plugin builds it from source instead. You'll additionally
  need `git` and a Swift toolchain (Swift 5.9+) available in `PATH` — e.g. via
  `mise use -g swift@latest` or `asdf plugin add swift`.
  Per [mint's own Linux notes](https://github.com/yonaskolb/Mint#linux), the Swift
  runtime must stay installed at run time too (Linux builds aren't statically linked),
  and package/executable names are case-sensitive.

# Install

## asdf

Plugin:

```shell
asdf plugin add mint
# or
asdf plugin add mint https://github.com/amine2233/asdf-mint.git
```

mint:

```shell
# Show all installable versions
asdf list-all mint

# Install specific version
asdf install mint latest

# Set a version globally (on your ~/.tool-versions file)
asdf global mint latest

# Now mint commands are available
mint --help
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

## mise

[mise](https://mise.jdx.dev) consumes asdf plugins directly, so this plugin works
there unchanged on both macOS and Linux:

```shell
# Add the plugin (not in the mise/asdf registry, so pass the git url)
mise plugin add mint https://github.com/amine2233/asdf-mint.git

# Show all installable versions
mise ls-remote mint

# Install specific version
mise install mint@latest

# Set a version globally (in ~/.config/mise/config.toml)
mise use -g mint@latest

# Or pin it per-project (writes/updates mise.toml)
mise use mint@latest

# Now mint commands are available
mint --help
```

Check [mise's plugin docs](https://mise.jdx.dev/plugins.html) for more instructions
on how to install & manage versions.

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/amine2233/asdf-mint/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [mint](https://github.com/tuistyonaskolb/Mint)
