<div align="center">

# asdf-mint [![Build](https://github.com/amine2233/asdf-mint/actions/workflows/build.yml/badge.svg)](https://github.com/amine2233/asdf-mint/actions/workflows/build.yml) [![Lint](https://github.com/amine2233/asdf-mint/actions/workflows/lint.yml/badge.svg)](https://github.com/amine2233/asdf-mint/actions/workflows/lint.yml)

[mint](yonaskolb/Mint) plugin for the [asdf version manager](https://asdf-vm.com).

</div>

# Contents

- [asdf-mint  ](#asdf-mint--)
- [Contents](#contents)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Dependencies

- `bash`, `curl`, `tar`, and [POSIX utilities](https://pubs.opengroup.org/onlinepubs/9699919799/idx/utilities.html).

# Install

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

# Contributing

Contributions of any kind welcome! See the [contributing guide](contributing.md).

[Thanks goes to these contributors](https://github.com/amine2233/asdf-mint/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [mint](https://github.com/tuistyonaskolb/Mint)
