Help
====

This file may not be the most up-to-date.  Check the following for up-to-date
information.

* [Confluence environment](https://confluence.slac.stanford.edu/display/PCDS/How+to+access+PCDS+environments) information
* [shared-dotfiles](https://github.com/pcdshub/shared-dotfiles) repository
* [Engineering tools](https://github.com/pcdshub/engineering_tools/blob/master/README.md) README

To view this document while using the dotfiles, type ``helpme``.

Key bindings
============

``fzf`` support is enabled by default. Use the following key combinations to use the fuzzy-finding
features:

* ``Ctrl-r`` - press this to fuzzily search through your bash history.
    * Type to filter items in your history.
    * Find the item you're looking for? Press enter to put it in your command-line.
    * To cancel, hit ``Ctrl-c``.
* ``Ctrl-t`` - press this to fuzzily search through files in your current directory.
    * Type to filter the items in your directory.
    * Find the file/directory you're looking for? Press enter to insert it in the command line.
    * To cancel, hit ``Ctrl-c``.

The rest are common readline key mappings that I find useful:

* ``Ctrl-a`` - press this to go to the beginning of your input while typing in bash.
* ``Ctrl-e`` - press this to go to the end of your input while typing in bash.
* ``Ctrl-l`` - press this to clear your screen quickly.
* ``Ctrl-c`` - press this to stop your current process.
* ``Ctrl-z`` - press this to pause your current process.
    * Use ``bg`` to let it run in the background.
    * Use ``fg`` to bring it back to the foreground.
    * Type ``jobs`` to see what's been backgrounded or paused.
* ``Ctrl-u`` to cut everything up to your cursor.
    * ``Ctrl-y`` to paste it back.
* ``Ctrl-w`` to cut the previous word(s).
    * ``Ctrl-y`` to paste it/them back.


tmux
----

* ``Ctrl-q`` is used as the default prefix.
* See [tmux.conf](tmux.conf) for further bindings for working with panels.


vim
---

* Ex mode is disabled by default, rebinding ``Q`` to ``gq`` (reformat).
* Otherwise, no specific bindings are added to the default vim configuration.

Tools
=====

Engineering Tools
-----------------

Most of these tools support ``--help``. Take a look to see what options they
have before running them.

* ``ami_offline_psana`` run offline AMI analysis.
* ``archive-status`` get the status of the specified PV in the archiver.
* ``camViewer`` start the viewer for controls cameras.
* ``checkcnf`` which host is running the daq in the current hutch?
* ``configdb_readxtc`` run readxtc for a given experiment.
* ``daq_control`` control the DAQ with a given command.
* ``daq_waitwin`` waits for the LCLS-I daq windows to load, then exits.
* ``dev_conda`` source this to activate a development pcds conda environment.
* ``elog_par_post`` post information to the experimental ELog
* ``eloggrabber`` start the ELog grabber "grubber" tool
* ``epicsArchChecker`` checks epicsArch files for mismatches of PVs and
  aliases, missing files, and unconnected PVs.
* ``epix_gains`` check gain modes for the ePIX
* ``evrStatus`` Displays a status GUI for the EVRs of the selected hutch or EVR
  PVs. GUI includes links to event code expert screens. The List of EVRs is not
  exhaustive, but rather displays one EVR per host.
* ``get_curr_exp`` get the current experiment name.
* ``get_hutch_name`` get the current hutch name.
* ``get_info`` get the current {run,experiment,hutch,station,etc}.
* ``get_lastRun`` get the last run.
* ``gige`` (deprecated)
* ``grep_ioc`` grep IOCManager configuration files for keywords
* ``grep_pv`` Searches through IOC data directories for PVs that match keyword
* ``imgr`` IOC Manager command-line interface.
* ``iocmanager`` IOC manager GUI interface.
* ``ioctool`` get IOC information given a PV or IOC name (tools for cd, telnet,
  etc, too)
* ``ipmConfigEpics`` configure IPM.
* ``makepeds``  make a pedestal file for offline use.
* ``makepeds_psana`` make a pedestal file for psana.
* ``motor-expert-screen`` start a motor expert screen, given a PV.
* ``motor-typhos`` start a typhos motor screen, given a PV.
* ``motorInfo`` get parameter manager motor information.
* ``pcds_conda`` source this to activate a production pcds conda environment.
* ``pkg_release`` checks out a package from the pcdshub github at a particular
  tag.
* ``pmgr`` parameter manager tool.
* ``pydev_env`` Source this file to activate a development environment based on
  the latest shared environment and on past calls to pydev_register``.
* ``pydev_register``  Use this script to register development packages so
  that they will be available when you source pydev_env
* ``pyps-deploy`` Sets up a pyps/apps deployment for a particular github python
  package.
* ``questionnaire_tools`` tools for interacting with the questionnaire.
* ``restartdaq`` restart the DAQ.
* ``serverStat`` check the status of a server or restart it.
* ``startami`` start a new AMI session.
* ``stopami`` stop the AMI session.
* ``stopdaq`` stop the DAQ.
* ``takepeds`` takes a run with dark images for use in pedestals, and posts to
  the elog.
* ``wheredaq`` discover what host is running the daq in the current hutch, if
  any.
* ``wherepsana`` checks where we have shared memory servers for psana running
  and could run psana jobs.


pcds_shortcuts
--------------

See https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=295099127

| Script              | Description                                                                              |
|---------------------|------------------------------------------------------------------------------------------|
| find_pv             | This script will search for each specified EPICS PV in pvlist files and startup scripts. |
| gsed                | Wrapper for sed, operating on multiple files in-place and noting which changed.          |
| show_epics_sioc     | Similar to ssh_show_procServ, this shows a table of IOCs - but on one or more hosts.     |
| show_epics_versions | An alias for the epics-versions tool.                                                    |
| ssh_show_procServ   | Shows a table of procServ information including port numbers.                            |


Screens

| Script            | Description                                                          |
|-------------------|----------------------------------------------------------------------|
| cxi               | CXI screen.                                                          |
| det               | Top-level detector screen.                                           |
| fee               | Deprecated - no longer launches the FEE screen. (aliases: xrt, xtod) |
| gw                | Gateway screen.                                                      |
| hpl               | HPL screen.                                                          |
| kfe               | LUCID KFE screen.                                                    |
| kpmps             | KFE PMPS screen.                                                     |
| las               | Laser screen.                                                        |
| lfe               | LUCID LFE screen.                                                    |
| lpmps             | LFE PMPS screen.                                                     |
| mec               | MEC screen.                                                          |
| mfx               | MFX screen.                                                          |
| pcds              | Top-level PCDS screen.                                               |
| pydm_lclshome     | Top-level PyDM screen.                                               |
| tmo               | LUCID TMO screen.                                                    |
| tst               | TST screen.                                                          |
| updateScreenLinks | Update screen links for given hutches.                               |
| xcs               | XCS screen.                                                          |
| xpp               | XPP screen.                                                          |

/reg/common/tools/bin
---------------------

/reg/common/tools/bin contains scripts such as:
* Tools for inspecting or interacting with released EPICS modules:
   - ``epics-checkout``
   - ``epics-release``
   - ``epics-versions`` (and other eco_tools)
   - ``svnIocToGit``
   - ``svnModuleToGit``
* Tools for inspecting or modifying networking configuration:
   - ``netconfig``
   - ``digiconfig``
   - ``psipmi``


Other commands
--------------

There are a lot of commands available in your environment.

To see a list of all of them and where they come from, type:

```bash
$ which_command
```

Consider piping that into fzf to find the command you are looking for:

```bash
$ which_command | fzf
```

Navigation
==========

Navigating up directories
-------------------------

```bash
$ cd ..

# Or try our handy aliases. This is the same as cd ../../..
$ ..3
```

Navigating over SSH
-------------------

```
sshcd - ssh to a host, retaining your current directory
  Usage:   sshcd hostname [optional command to run]
  Example: sshcd lfe-console ls -l
```

Navigating to the newest subdirectory
-------------------------------------

```bash
$ cdnewest
```

Navigating to IOC directories
-----------------------------

Navigating to an IOC's directory via "ioctool":

```bash
$ source ioctool PV:NAME cddir
$ source ioctool ioc-name cddir
```

Navigating to an IOC's directory via "cdioc":

```bash
$ cdioc
# (type to filter the list and select an item)
```

or, if you know the name already:

```bash
$ cdioc iocname
```

To get to an IOC data directory quickly:

```bash
$ cdiocdata
```

To list all IOCs:

```bash
$ list_all_iocs
```

To get basic or more detailed JSON information about a certain IOC:

```bash
$ which_ioc
$ which_ioc_json
```

Navigating to hutch-python directories
--------------------------------------

* ``cdhutchconfig`` hutch configuration directory
* ``cdhutchp`` hutch-python configuration directory
* ``cdhutchp_logs`` hutch-python log directory


Viewing logs
------------

```bash
$ ioclog iocname
```

Shared filesystems
==================

| Directory        | Description                                                    |
|------------------|----------------------------------------------------------------|
| /afs             | Global, multi-facility shared filesystem                       |
| /afs/slac/       | SLAC's part of AFS                                             |
| /cds/            | Shared weka fileystem (faster, more modern than AFS)           |
| /cds/data/       | Shared weka filesystem for data storage                        |
| /cds/group/pcds/ | PCDS's group location for weka                                 |
| /cds/home/       | Base directory for PCDS users' home storage (i.e., your $HOME) |
| /reg/g/          | Older, deprecated path for /cds/group                          |

Python environments
-------------------

To access our deployed conda environments, see:
https://confluence.slac.stanford.edu/display/PCDS/PCDS+Conda+Python+Environments

Generally, you should only need to run the following on a machine like
psbuild-rhel7:

```bash
$ source /cds/group/pcds/pyps/conda/pcds_conda
```

And note that the source of these configurations is:
<https://github.com/pcdshub/pcds-envs>

Happi configuration
-------------------

HAPPI_CFG is set automatically in our Python environment scripts. We store that
configuration in

``/cds/group/pcds/pyps/apps/hutch-python/device_config``

and push it to <https://github.com/pcdshub/device_config/>

Hutch-python configuration paths
--------------------------------

See [Hutch Python
Seminar](https://confluence.slac.stanford.edu/display/PCDS/Hutch+Python+Seminar)
for more details.  You must be added to the relevant instrument group
(ps-<hutch>, e.g. ps-xpp) for write access to these files

For a given hutch, e.g., `xpp`:

| Directory                                          | Description                                                                                           |
|----------------------------------------------------|-------------------------------------------------------------------------------------------------------|
| /reg/g/pcds/pyps/apps/hutch-python/xpp/            | Base configuration directory, a git repository                                                        |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/xppenv      | Environment script - source this to enter XPP's pcds-envs-based python environment                    |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/xpppython   | Script to run XPP's hutch-python                                                                      |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/set-dev     | Tool for using a development version of a given package                                               |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/xpp         | Python package named "xpp", imported by default in the environment (see conf.yml)                     |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/experiments | Per-experiment configurations, loaded automatically by xppython                                       |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/conf.yml    | Configuration file that indicates to load the happi database file and xpp.beamline as above (details) |
| /reg/g/pcds/pyps/apps/hutch-python/xpp/presets/    | Directory where per-positioner (motor) presets are stored                                             |

PLC environment
===============

The plcprog-console node allows for access to production and test network PLCs.
Access to its is documented above in the "remote access" section.

We have our own suite of tools for generating IOCs and checking PLC projects
called "[ads-deploy](https://github.com/pcdshub/ads-deploy)" which wraps
"[pytmc](https://github.com/pcdshub/pytmc)".

You can use ads-deploy easily on plcprog-console by following the [guide
here](https://confluence.slac.stanford.edu/display/PCDS/ads-deploy+on+plcprog-console),
or alternatively on *your own* machine with [this
guide](https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=295099767).

Engineering tools
=================

Tools that are of general use to PCDS engineers called
[engineering_tools](https://github.com/pcdshub/engineering_tools) are deployed
and available in: `/reg/g/pcds/engineering_tools/latest/`

shared-dotfiles includes engineering tools in your PATH by default.

GitHub
======
Most of our git repositories are on github. You can browse these at
"[pcdshub](https://github.com/pcdshub)".

Typically these repositories follow a "fork" and "pull request" model for
development. You can read about this in our
"[local](https://pcdshub.github.io/development.html)" documentation and on
"[github](https://docs.github.com/en/get-started/quickstart/hello-world)" itself.

The shared dotfiles contains some helper scripts for keeping your github forks
in sync with the pcdshub upstream:

- git_setup_fork: clones your fork and adds a reference to upstream
- git_sync_upstream: pulls from upstream, pushes to your fork

To make sure this works to your preferences, you should update the "GITHUB_"
variables from the starter .bashrc. Here are the defaults and what they do:

| Variable        | Default   | Description                                            |
|-----------------|-----------|--------------------------------------------------------|
| GITHUB_USERNAME | "${USER}" | Your login name for github, used to locate your forks. |
| GITHUB_UPSTREAM | upstream  | The remote name to use for the main/canonical remote.  |
| GITHUB_ORIGIN   | origin    | The remote name to use for your fork.                  |
| GITHUB_MASTER   | master    | The branch name of the organization's main branch.     |

The most common variable to edit is "GITHUB_USERNAME", which often differs from your
SLAC unix username. "GITHUB_UPSTREAM" and "GITHUB_ORIGIN" are user preference- some people
prefer "origin" to point to their fork, while others prefer "origin" to point to the
original repository. "GITHUB_MASTER" should be "master" until we decide to rename all
of our "master" branches to "main" as per latest practices.


Git
===

While not an environment per se, we have git repositories stored on AFS. They
are located here: `/afs/slac/g/cd/swe/git/repos/`

Shared IOCs, for example, are located here:
`/afs/slac/g/cd/swe/git/repos/package/epics/ioc/common/`

EPICS environments
==================

To use the latest EPICS environment, source the following:

Additional shortcuts are automatically included with the above when using the
bash shell. You can see those shortcuts in:

This includes commonly used shortcuts like the LUCID ones (`kfe`, `lfe`, `rix`,
etc.) and others listed in [PCDS EPICS Shortcuts
(pcds_shortcuts.sh)](https://confluence.slac.stanford.edu/pages/viewpage.action?pageId=295099127)

Old (maybe outdated) software environments
==========================================

pkg_mgr / pspkg
---------------

`/reg/g/pcds/pkg_mgr` defines a set of isolated environments. Some may still be
in use, but largely we are working with our conda environments (listed above)
now.

See [Package
Manager](https://confluence.slac.stanford.edu/display/PCDSArchive/Package+Manager)
(archived) for more details.

Releases are defined in `/reg/g/pcds/pkg_mgr/source/releases`

Per-package information is defined `/reg/g/pcds/pkg_mgr/source/pkg_info`

Released packages and environments are here `/reg/g/pcds/pkg_mgr/release`

controls-basic
--------------

There are some special pkg_mgr environments that remain in use for booting IOCs:

`/reg/g/pcds/pkg_mgr/release/controls-basic-0.0.1`

(See [Detailed Soft IOC boot
process](https://confluence.slac.stanford.edu/display/PCDS/Detailed+Soft+IOC+boot+process)
for ~~too much~~ more information)

Per-hutch configuration directories
===================================

Per-hutch IOC configuration and tooling can be found here:
`/cds/group/pcds/pyps/config/`

Each hutch has its own configured set of tools, such as those for XCS as of January 2022:

| Directory                                     | Description                                                    |
|-----------------------------------------------|----------------------------------------------------------------|
| /cds/group/pcds/pyps/config/xcs/camrecord.sh  | Controls recorder                                              |
| /cds/group/pcds/pyps/config/xcs/camviewer.sh  | Camera viewer tool                                             |
| /cds/group/pcds/pyps/config/xcs/expstate.sh   | Experiment state tracking tool (for XCS)                       |
| /cds/group/pcds/pyps/config/xcs/iocmanager.sh | IOC manager (for XCS) to start/stop/add new IOCs (staff guide) |
| /cds/group/pcds/pyps/config/xcs/pmgr.sh       | Parameter manager (for XCS)                                    |
| /cds/group/pcds/pyps/config/xcs/trigtool.sh   | EVR Trigger Tool                                               |


Per-user important directories
==============================

``/cds/group/pcds/epics-dev/${USER}`` is the top-level directory for iocs for
${USER}. You may need to create your own directory here.

IOC data directories and important files
========================================

| Directory                                              | Description                                                                                                                                                          |
|--------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| /cds/group/pcds/epics/ioc/<area>/<ioc-name>/<version>/ | Released IOCs go here, on a per-hutch, per-IOC, and per-released version. These files should not be changed in-place. Clone from git and follow the release process. |
| /cds/data/iocData/                                     | Top-level directory for IOC data.  Subdirectories are created on a per-IOC basis.                                                                                    |
| /cds/data/iocData/*/iocInfo/IOC.log                    | The IOC log file.                                                                                                                                                    |
| /cds/data/iocData/*/iocInfo/IOC.pvlist                 | The IOC's auto-generated list of PVs.                                                                                                                                |
| /cds/data/iocData/*/iocInfo/IOC.epicsEnvShow           | Created at each IOC startup with a list of the EPICS environment variables and their values                                                                          |
| /cds/data/iocData/*/autosave/*.sav                     | PV state is saved to these files (generated periodically by the IOC support module autosave)                                                                         |
| /cds/data/iocData/.zfs/snapshot                        | 30 days of daily snapshots of backed up iocData. Weekly and monthly snapshots are on a separate server (psbackup02)                                                  |


#### How do these files get generated?

The above files and directories are created through a rather complicated
process.

If you *really* need to get into the weeds of it - for issue debugging or just
a general interest - the following document may be of use to you: [Detailed
Soft IOC boot
process](https://confluence.slac.stanford.edu/display/PCDS/Detailed+Soft+IOC+boot+process)

Otherwise, just ask an expert!

Web-facing applications
=======================

| Directory                                     | Description                                                          |
|-----------------------------------------------|----------------------------------------------------------------------|
| /cds/group/psdm/web/ws/prod/apps              | The experimental logbook, questionnaire, and related web apps source |

Websites
========

Accessing websites from hutches without direct internet access
--------------------------------------------------------------

To use command-line tooling such as curl or wget, set the following environment
variables. Not all hosts will need this - pslogin, psbuild-rhel7 and similar
have direct access.

```bash
export http_proxy=http://psproxy:3128
export https_proxy=http://psproxy:3128
```

Alternatively, ensure that your firefox settings use the above proxy settings
in preferences.
