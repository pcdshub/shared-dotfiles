# shared-dotfiles

Shared configuration useful for PCDS engineers: "dot" files such as bash
configuration (.bashrc) and SSH configuration (.ssh/config).

## How to use these

### Trial run

```bash
$ ssh psbuild-rhel7
$ git clone git@github.com:pcdshub/shared-dotfiles dotfiles
$ cd dotfiles
$ bash --rcfile try_me.sh
```

### Out-of-the-box

To link the scripts here and use them every time when you login:

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
