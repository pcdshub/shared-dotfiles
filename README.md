# shared-dotfiles

Shared configuration useful for PCDS engineers: "dot" files such as bash
configuration (.bashrc) and SSH configuration (.ssh/config).

## What is provided here?

* Off-site SSH configuration for VPN-free access of PCDS resources.
    * See the next section for what "on-site" and "off-site" mean here.
* On-site bash configuration (`~/.bashrc`, `~/.bash_profile`) with:
    * Detailed descriptions of what each line of what your bash configuration
      does and how to customize it further.
    * Enables fuzzy-finding of your bash history and files under your path
      via ``fzf``.
    * Automatically enables EPICS environment access.
    * Automatically allows access to common tools such as `engineering_tools`
      and other PCDS-specific scripts.
    * Enables bash tab completion.
    * Provides sample aliases, functions, and helpers for your usage.
    * Configures `http_proxy` settings on hosts that need it.
    * Disables/reconfigures some functionality that might confuse new - or even
      well-seasoned users - at times.
    * Closing sections which suggest on how to expand or further customize
      your settings.
* Sample git configuration (`~/.gitconfig`) with helpful aliases and
  pre-configured settings.
* Sample vim configuration (`~/.vimrc`) with detailed comments indicating
  why you might want each setting.
* Sample tmux configuration to give you a starting point for your own
  configuration, with mouse support, additional bindings, and comments to
  instruct you how to use it.
* Built-in documentation that can be accessed while using shared-dotfiles.
  ([helpme.md](helpme.md))
* Sample conda configuration file for using conda-forge.
* Off-site simple bash settings.

## On-site and off-site

Some configuration is broken up into "on-site" versus "off-site" here.

1. The off-site configuration is meant for your laptop or machine you use at home
   to connect to the PCDS network by way of SSH, OpenVPN, or similar.
   It works well on SLAC WiFi, too, so you don't need to switch back and forth.
2. The on-site configuration is meant to be used on PCDS machines like pslogin
   and psbuild-rhel7.  You have a shared home storage space on these machines,
   so you will only need to install it once.

### Use case: macOS/Linux machine at home/on-site

The off-site configuration is tailored for your use case.

See [here](https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=320479134) for
full setup instructions.

* Suggested use for your machine: off-site SSH configuration, and configuration files of your choice
* Suggested use for PCDS machines: on-site configuration installed on, for example, ``psbuild-rhel7``.


### Use case: Windows machine at home/on-site

Whether you use Windows at home or on-site, you should consider using our pre-configured
[MobaXterm](https://confluence.slac.stanford.edu/display/PCDS/Windows%3A+How+to+install+and+use+MobaXterm+to+access+PCDS+machines+and+software)
distribution.

* Suggested use for your machine: You will not need to use the provided off-site configuration here.
* Suggested use for PCDS machines: on-site configuration installed on, for example, ``psbuild-rhel7``.

## How to use these

### Trial run

You can try parts of these settings without installing anything by doing the
following:

```bash
# Start off on psbuild-rhel7
$ ssh psbuild-rhel7

# Go to your home directory
$ cd

# In your home directory, clone the dotfiles
$ git clone git@github.com:pcdshub/shared-dotfiles dotfiles

# Run the "try me" script which enables access to the bash configuration
# provided by this repository:
$ ./try_me.sh
```

Please note that this only applies to the bash and vim configuration and not
the SSH, git, and other provided configurations here.

If you like the experience provided by these scripts, use the following to
source the shared-dotfiles in your current bash configuration:

```bash
# Source the 'bash_all.sh' script from shared-dotfiles
$ echo 'source $HOME/dotfiles/on_site/bash_all.sh' >> $HOME/.bashrc
```

### Forking

Advanced users may want to start their own dotfiles repository based on this
one. We recommend that you version control your dotfiles. 

1. Fork pcdshub/shared-dotfiles to your-user/shared-dotfiles
2. ```bash
   $ ssh psbuild-rhel7
   $ cd   # <-- work in your home directory
   $ git clone git@github.com:your-user/shared-dotfiles dotfiles
   ```
3. Either use the sourcing method above or refer to ``.bashrc`` directly:
   ```bash
   # Use the dotfiles bashrc as your .bashrc
   $ ln -s dotfiles/bashrc .bashrc
   ```

Keeping up-to-date with upstream changes will be your responsibility.  You
may need to rebase or merge with shared-dotfiles as your configuration
gets customized.

### Install shared-dotfiles as-is

These dotfiles can be used as your entire configuration, if you are not picky
about customizations.

Note that this method includes *all* customizations provided here: from
the bash scripts to vim configuration, and the rest.

To link the scripts and configuration files provided and use them every time
when you login:

```bash
$ ssh psbuild-rhel7
$ cd
# In your home directory, clone the dotfiles:
$ git clone git@github.com:pcdshub/shared-dotfiles dotfiles
$ cd dotfiles
$ bash use_dotfiles.sh
```

Please note that the script will *not* overwrite existing files.  You will need
to manually move (or less preferably, remove) existing configuration files that
are from shared-dotfiles.

You will only need to do this once.

## Post-installation

### "On-site" configuration

If you've installed or are working in a shared-dotfiles "trial mode", consider
typing ``helpme`` to view the packaged [helpme.md](helpme.md) for a reminder
on how to navigate directories, find IOCs, and recall what important
directories there are.

## SSH configuration

SSH configurations for on-site versus off-site usage exist.

The ``use_dotfiles.sh`` script assumes an on-site configuration for now,
so it's recommended to run it on psbuild-rhel7 or similar.

## Issues / suggestions?

Please feel free to open an issue!

It's the author's opinion that this is a useful thing for the group to
collaborate on, and contributions/suggestions from the group can only make it
better.
