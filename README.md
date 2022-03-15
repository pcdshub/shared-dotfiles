# shared-dotfiles

Shared configuration useful for PCDS engineers: "dot" files such as .ssh/config.

## How to use these

### Out-of-the-box

```bash
$ ssh psbuild-rhel7
$ git clone git@github.com:pcdshub/shared-dotfiles dotfiles
$ cd dotfiles
$ bash use_dotfiles.sh
```

### Advanced or custom usage

Advanced users may want to start their own dotfiles repository based on this one.
You can then version-control your dotfiles, simply soft-linking the files
in your fork.  For example:

1. Fork pcdshub/shared-dotfiles to your-user/shared-dotfiles
2.
```bash
$ ssh psbuild-rhel7
$ cd   # <-- work in your home directory
$ git clone git@github.com:your-user/shared-dotfiles dotfiles
$ ln -s dotfiles/bashrc .bashrc
```

## SSH configuration

SSH configurations for on-site versus off-site usage exist.

1. The off-site configuration is meant for your laptop or machine you use at home
   to connect to the PCDS network.
   It works well on SLAC WiFi, too, so you don't need to switch back and forth.
2. The on-site configuration is meant to be used on PCDS machines like pslogin
   and psbuild-rhel7.  You have a shared home storage space on these machines,
   so you will only need to install it once.
   The ``use_dotfiles.sh`` script assumes an on-site configuration for now.
