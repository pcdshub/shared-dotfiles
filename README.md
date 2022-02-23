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
