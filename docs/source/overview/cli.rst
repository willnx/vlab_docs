###############
vLab Client CLI
###############

This section goes over how the CLI for vLab works. For tips on using the CLI,
checkout the Getting Started page.

********
Overview
********

The vLab CLI is really more like a web page than a traditional CLI. Instead of
interacting with the OS to modify settings, change files, etc, the vLab CLI
makes HTTP requests to the vLab server.

The design goal of the CLI is to be apparent and simple to use. Inconsistencies
in the CLI are always considered high priority bugs. Things like mixing plural
and singular words makes it harder for users to *guess and get it right* when
trying to recall what the command syntax is. The harder the CLI is to use, the
less people will use it.

The authentication tokens used by the CLI are stored under the user's home directory,
in a hidden folder named ``.vlab``. Only the specific user should have access to
this folder and all files inside it for security reasons. When you run the CLI,
it defaults to assuming that you're identity is the same as your login name. In
other words, if you're logged in as ``root``, you'll have to tell the CLI *who you are*
with the ``--username`` argument. This argument is only used when attempting to
authenticate and generate a new auth token. If a token already exists, the CLI
will use the identity defined within the token. This is why you must **never**
share logins on the same system with the CLI. Never use the CLI on a system that
you do not own unless you really trust the people that have ``root`` access to
that machine.
