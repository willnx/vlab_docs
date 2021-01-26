############
vLab Connect
############

Additional documentation: https://github.com/willnx/vlab_cli/tree/master/vlab_cli/subcommands/connect

Intro
=====
vLab Connect is automation built into the vLab client that makes accessing the
components in your lab simpler. Because your lab is behind a
`NAT firewall <https://en.wikipedia.org/wiki/Network_address_translation>`_,
you cannot simply connect to the IP of a machine within your lab. The vLab
connect automation manages looking up the correct connection information and
then establishing a connection for you.


Getting Started
===============
This section goes over how the vLab Connect automation works, and what is supported.

Supported Clients by Protocol
-----------------------------
vLab supports establishing a connection via the following protocols.
Each protocol enumerates the clients that vLab Connection supports for that protocol.

`SSH <https://en.wikipedia.org/wiki/Secure_Shell>`_:
   * `Putty <https://www.chairk.greenend.org.uk/~sgtatham/putty/>`_
   * `SecureCRT <https://www.vandyke.com/products/securecrt/>`_
   * `Windows Terminal <https://docs.microsoft.com/en-us/windows/terminal/>`_

`HTTPS <https://en.wikipedia.org/wiki/HTTPS>`_
   * `Chrome <https://www.google.com/chrome/>`_
   * `Firefox <https://www.mozilla.org/en-US/firefox/new/>`_

`RDP <https://en.wikipedia.org/wiki/Remote_Desktop_Protocol>`_
  * `mstsc <https://docs.microsoft.com/en-us/windows-server/administration/windows-commands/mstsc>`_ (the default RDP client on Windows)

`SCP <https://en.wikipedia.org/wiki/Secure_copy>`_
  * `WinSCP <https://winscp.net/eng/index.php>`_
  * `FileZilla <https://filezilla-project.org/>`_ (via SFTP, not SCP. Not all components in vLab support SFTP.)

Not all components support all protocols. Part of the vLab Connect automation
manages this aspect for you as well.


The Configuration File
----------------------
In order to know *which client to use* the vLab CLI relies on a configuration file.
This file is stored in a directory labeled ``.vlab`` within your home directory.
The configuration file is a basic ``ini`` format, and simply named ``config``.

For example, if your username is Sam and you have a standard home directory on a
Windows machine, the configuration file path would be ``C:\Users\Sam\.vlab\config.ini``.

Format
^^^^^^
The format of the configuration file is in basic `ini <https://en.wikipedia.org/wiki/INI_file>`_
format. Each section represents a given network protocol, and each section contains
two keys.

Here's an example ``config.ini``::

  [SCP]
  agent=winscp
  location=C:\\some\\path\\WinSCP.exe

  [SSH]
  agent=putty
  location=C:\\some\\path\\putty.exe

  [BROWSER]
  agent=firefox
  location=C:\\some\\path\\firefox.exe

  [RDP]
  agent=mstsc
  location=C:\\some\\path\\mstsc.exe

The two keys in each section are ``agent`` and ``location``.


Feel free to edit this file whenever you want. If you supply an invalid config,
and are unable to fix it, just delete the entire config file and the vLab CLI
will recreate it the next time you run a ``vlab connect`` command.


How it Works
------------
The vLab CLI uses `Python click <http://click.palletsprojects.com/en/7.x/>`_ to
construct the CLI interface (i.e. how the commands all fit together). Every command
(i.e. the words without any ``-`` proceeding it) has the option in
`Python click <http://click.palletsprojects.com/en/7.x/>`_ to execute some code.
In the vLab CLI, this is where reading and validating the ``config.ini`` occurs.
If the config is missing or invalid, the `clippy <https://github.com/willnx/vlab_cli/tree/master/vlab_cli/lib/clippy>`_
module for connect is invoked to correct the problem.

Once the config is validated, it's passed along to the subcommand. Inside each
subcommand is logic that defines what protocols are valid, and how to look up
the portmapping rules.

At this point, the vLab CLI calls a (terribly named) module called the
`connectorizer <https://github.com/willnx/vlab_cli/blob/master/vlab_cli/lib/connectorizer.py>`_
to generate the syntax needed to launch the given client application via Python's
`subprocess <https://docs.python.org/3/library/subprocess.html>`_ library.

That's it! That's all there really is to how the ``vlab connect`` command works.
