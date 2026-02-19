# trimui toolchain Docker image

## Installation

With Docker installed and running, `make shell` builds the toolchain and drops into a shell inside the container. The container's `~/workspace` is bound to `./workspace` by default. The toolchain is located at `/opt/trimui-toolchain` inside the container, libraries are in `/opt/trimui-toolchain/arm-buildroot-linux-gnueabi/sysroot/usr/lib/`.

After building the first time, unless a dependency of the image has changed, `make shell` will skip building and drop into the shell.

## Workflow

- On your host machine, clone repositories into `./workspace` and make changes as usual.
- In the container shell, find the repository in `~/workspace` and build as usual.
  - Optionally, `source ~/env-setup.sh` in the shell to set common cross-compiling and path variables.

### Installing extra packages

To install extra packages into your container, add the ubuntu package names to `./extra_packages.txt`, one per line. They will be installed the next time you start a new shell. To keep git from tracking your changes to this file, run `git update-index --skip-worktree ./extra_packages.txt`.

### Adding libraries to the toolchain sysroot

Put files that you want included in the sysroot (libs and headers, you've built, etc.) in `./extras`. They will be copied to `$SYSROOT/usr` as the container is built.

### Changing the buildroot configuration

In `~/buildroot`:

- `make menuconfig`, change options
- `make savedefconfig BR2_DEFCONFIG=../workspace/defconfig`

Then, on the host, copy `./workspace/defconfig` to `./trimui_config/configs/trimui_defconfig`.

## Docker for Mac

Docker for Mac has a memory limit that can make the toolchain build fail. Follow [these instructions](https://docs.docker.com/docker-for-mac/) to increase the memory limit.
