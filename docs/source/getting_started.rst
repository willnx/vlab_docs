###############
Getting Started
###############

If you've found this page, then congratulations!
You're most of the way to being able to use vLab.

All you have to do now is:

1. :ref:`install`
2. :ref:`initialize`
3. :ref:`use-it`


.. _install:

***************************
Install the vLab CLI client
***************************

The vLab client comes in two varieties: A giant binary for Windows, and a pure
Python package for Linux users.
You have to decide which one works for you.

Windows
=======

This section is for installing the vLab CLI on a Windows 10 machine.

Prerequisites/Dependencies
--------------------------

The ``vlab connect`` feature requires Putty and WinSCP to be installed on Windows.
If you do not have those applications installed, please download and install them
before proceeding.

.. only:: builder_html

   :download:`Putty <putty-64bit-0.70-installer.msi>`

   :download:`WinSCP <WinSCP-5.13.6-Setup.exe>`

vLab CLI MSI
------------

The giant binary is packaged in an `MSI <https://whatis.techtarget.com/fileformat/MSI-Installer-package-Microsoft-Windows>`_
file. You should be able to simply download the file from below, then run it to
install the vLab CLI:

.. only:: builder_html

   :download:`vLab CLI client (Windows 10 MSI) <vlab-cli-0.2.6-amd64.msi>`.

Install Video
=============

This is a short video tutorial on how to install the vLab CLI client in Windows.

.. raw:: html

   <video width="320" height="240" controls>
     <source src="_static/vLabClientInstall.mp4" type="video/mp4">
   </video>
   <p></p>


Linux
======

This section is for installing the vLab CLI on a Linux machine.

Prerequisites/Dependencies
--------------------------

You'll need ``ssh`` and ``remmina`` for the ``vlab connect`` feature to work.
Due to the shear number of Linux flavors, instructions on how to install each
is listed below:

`SSH Install instructions <https://www.cyberciti.biz/faq/how-to-installing-and-using-ssh-client-server-in-linux/>`_

`Remmina Install instruction <https://remmina.org/how-to-install-remmina/>`_


vLab CLI Wheel
--------------

If you have Python installed on your OS already, you can download the
`Python wheel <https://pythonwheels.com/>`_ and install it with `Pip <https://pip.pypa.io/en/stable/installing/>`_.

Assuming the wheel file is in your current working directory, the syntax to install
the vLab CLI client with ``pip`` is like this::

  $ sudo pip install *.whl

.. only:: builder_html

   :download:`vLab CLI client (Python) <vlab_cli-0.2.6-py3-none-any.whl>`.


.. _initialize:

***************
Set up your lab
***************

Now that you have installed the vLab CLI client, you need to initialize your lab.

Run this command, then go grab some coffee. When you come back, your lab should be ready::

  $ vlab init

Accessing your lab
==================
Your lab exists behind a NAT firewall. To access a specific component in your lab,
simply run::

  vlab connect COMPONENT --name NAME

to establish a direct connect to that specific machine. For example, to connect
to node 1 in a OneFS cluster named ``isi01`` the syntax would be::

  vlab connect onefs --name isi01-1

.. note::

   Make sure to include the node number in the name when connecting to a OneFS
   cluster.

Most of the components in vLab support multiple connection protocols. To connect
via a different protocol, just define the specific protocol via the ``--protocol``
argument.

**PROTIP:** Once you've established a connect to one component, you can *hop* to other
components. For instance, if you connect to a Windows client you can use Putty *on
that client* to connect to OneFS and test SmartConnect or IPv6, or any other feature
that ``vlab connect`` isn't able to leverage.

Video Setting Up and Accessing Lab
==================================

This video demonstrates how to initialize your lab, and how to access it via
SSH or RDP.

.. raw:: html

   <video width="320" height="240" controls>
    <source src="_static/InitAndAccess.mp4" type="video/mp4">
  </video>
  <p></p>

.. _use-it:

*******************
Start using the CLI
*******************

This section goes over basic usage of the vLab CLI.

The best way to think about the vLab CLI is to use the format of::

  vlab VERB COMPONENT

Verbs are the actions you want to perform. Like create or delete.

The component is the type of thing you want to act upon.
Components are things like a OneFS node, and InsightIQ instance, a network, etc.

While not 100% true (some commands have no verbs/components), thinking of the CLI this way
will get to you the right command nearly every time.

In addition, everything is non-plural. Even if this makes the syntax sound a bit
off, it's worth it in the end. So if you ever find yourself thinking *"is it network or networks,"*
just assume it's *network*. Mixing plural and non-plural words makes
using a CLI harder than it needs to be. The goal of the vLab CLI is that it
should be pretty simple to use.

.. note::

   Remember, different commands take different arguments. Use ``--help`` to check the syntax.


Video Using the CLI
===================

.. raw:: html

   <video width="320" height="240" controls>
    <source src="_static/vLabCLI.mp4" type="video/mp4">
  </video>
  <p></p>

Creating something
==================
The basic syntax for creating anything in vLab is::

  $ vlab create <component> --name <it's name> --image <the version>

Where ``<component>`` is replaced with whatever it is you want to make.
``<it's name>`` is whatever you want to call it, and ``<the version>`` is simply
the version of the component to create. The argument is --image because no one
wants to talk about *"a version of software that creates versions of software"*;
just reading that hurts my head...

For example, to create a new InsightIQ instance, the command syntax would look like this::

  $ vlab create iiq --name myIIQ --image 4.1.2

Some components that you can create support additional arguments.
For example, when creating OneFS nodes, you can specify how many nodes to make like this::

  $ vlab create onefs --name isi01 --image 8.0.0.7 --node-count 5

Which will create 5 nodes running OneFS 8.0.0.7.

Whenever you're not sure of what the CLI syntax is, the first thing to check is
the built-in help.

For example, to see the available arguments, and check the command syntax for
creating a new ESRS instance, run this command::

  $ vlab create esrs --help


Deleting something
==================
To delete just about anything in vLab, the syntax is like this::

  $ vlab delete <component> --name <it's name>

Where ``<component>`` is the type of component, and ``<it's name>`` is the name you
gave when originally creating the component.

For example, to delete an instance of a CEE sever, the syntax would be like::

  $ vlab delete cee --name myCEE

Some components have extra-handy arguments to make deletions easier. For example,
you can delete an entire OneFS cluster like this::

  $ vlab delete onefs --cluster isi01

.. note::

   Once you delete something, there's no getting it back. It's gone forever.


Listing/showing things
======================
The verb to display information about your vLab components is ``show``, and typically
takes no arguments like this::

  $ vlab show <component>

If you wanted to look at information about all the networks you own, the command
would look like this::

  $ vlab show network

In addition to the ``show`` sub-command, there's the ``info`` sub-command.
The basic difference is that ``info`` gives you a basic view of all the different
components you own. You can almost think of it as like a status page. To see
all the different components you own, the syntax is::

  $ vlab info
