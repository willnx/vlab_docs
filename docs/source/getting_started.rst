###############
Getting Started
###############

If you've found this page, then congratulations!
You're most of the way to being able to use vLab.

All you have to do now is:

1. :ref:`install`
2. :ref:`create`
3. :ref:`connect`


.. _install:

*************************
Install & Initialize vLab
*************************

To use vLab, you'll need a client program (unless you want to build your own
tool to use the RESTful API directly). vLab ships with a reference client that
has a command-line interface. The installation process is painless
thanks to the `MSI packaging <https://en.wikipedia.org/wiki/Windows_Installer>`_.

Once the CLI client is installed, you **must** run a single command to initialize
your lab on the vLab server.


Prerequisites/Dependencies
==========================

The ``vlab connect`` feature requires Putty, WinSCP and the VMware Remote Console
(VMRC) to be installed on Windows. If you do not have those applications installed,
please download and install them before proceeding.

.. only:: builder_html

   :download:`Putty <putty-64bit-0.70-installer.msi>`

   :download:`WinSCP <WinSCP-5.13.6-Setup.exe>`

   :download:`VMware VMRC <VMware-VMRC-10.0.4-11818843.zip>`

vLab MSI
========

You should be able to simply download the file from below, then run it to
install the vLab CLI:

.. only:: builder_html

   :download:`vLab CLI client (Windows 10 MSI) <vlab-cli-2020.1.29-amd64.msi>`.


Initialize your lab
===================

Once the CLI is installed, you'll have to tell the vLab server to create a new
lab for you. Every user has their own, individual virtual lab space. This way
when someone breaks their lab, it wont impact your lab.

You only need to initialize your lab one time (even if you install the CLI on a
new laptop/computer). The initialization process is easy, but will take several
minutes and require you to answer a few questions.

To initialize your lab, run the following command::

  $ vlab init


Install Video
=============

This is a short video tutorial on how to install & initialize the vLab CLI client in Windows.

.. raw:: html

   <video width="320" height="240" controls>
     <source src="_static/vLabInstallAndInit.mp4" type="video/mp4">
   </video>
   <p></p>


.. _create:

*********************
Create Lab Components
*********************

The different things you can deploy into your lab are called components. Components
consist of:

- Servers: Like OneFS, Windows Server, EMC CEE, etc
- Clients: Like CentOS, Windows Desktop, etc
- Networks: You know, `LANs <https://en.wikipedia.org/wiki/Local_area_network>`_
- Routers: To connect networks together and form `WANs <https://en.wikipedia.org/wiki/Wide-area_network>`_


The best way to think about the vLab CLI is to use the format of::

  vlab VERB COMPONENT

Verbs are the actions you want to perform. Like create or delete.
The component is the type of thing you want to act upon, like an InsightIQ instance.


In addition, everything is non-plural. Even if this makes the syntax sound a bit
weird, it's worth it in the end. So if you ever find yourself thinking *"is it network or networks,"*
just assume it's *network*. Mixing plural and non-plural words makes
using a CLI harder than it needs to be. The goal of the vLab CLI is that it
should be pretty simple to use.

.. note::

   Remember, different commands take different arguments. Use ``--help`` to check the syntax.


Creating a Component
====================
The basic syntax for creating anything in vLab is::

 $ vlab create <component> --name <it's name> --image <the version>

Where ``<component>`` is replaced with whatever it is you want to make.
``<it's name>`` is whatever you want to call it, and ``<the version>`` is simply
the version of the component to create. The argument is ``--image`` because no one
wants to talk about *"a version of software that deploys versions of software"*;
just reading that hurts my head...

Examples
--------

Below are example CLI commands to create different vLab components in your lab.


Short vs Long arguments
^^^^^^^^^^^^^^^^^^^^^^^

Virtually every argument in the vLab CLI supports both long and short syntax.
Long version syntax is great for including in documentation because it provides
more context to the command. Short version syntax is really handy when you're
familiar with a command because there's less typing involved.

This command will create an InsightIQ instance running version 4.1.2.

.. code-block:: shell

 $ vlab create insightiq --name myIIQ --image 4.1.2


This command does the same thing, but is simply shorter.

.. code-block:: shell

 $ vlab create insightiq -n myIIQ -i 4.1.2

**Protip:** Long arguments are whole words that are prefixed with a double-dash (``--``).
Short arguments are single letters that start with a single-dash (`-`).


Auto-configuration
^^^^^^^^^^^^^^^^^^
Some components can be *auto-configured* by the vLab server. The following
command will create a 1-node cluster running OneFS 8.0.0.7 that's ready to use.
The ``--external-ip-range`` command tells the vLab server *what front-end IP range the
cluster should use*.

.. code-block:: shell

 $ vlab create onefs --name isi01 --image 8.0.0.7 --external-ip-range 192.168.1.20 192.168.1.25


Deleting a Component
====================
To delete just about anything in vLab, the syntax is like this::

 $ vlab delete <component> --name <it's name>

Where ``<component>`` is the type of component, and ``<it's name>`` is the name you
gave when originally creating the component.


Examples
--------

Basic Delete Syntax
^^^^^^^^^^^^^^^^^^^
In this example, the command would delete an instance of EMC CEE with the name of
myCEE.

.. code-block:: shell

 $ vlab delete cee --name myCEE


Cluster Delete
^^^^^^^^^^^^^^
Some components have extra-handy arguments to make deletions easier. For example,
you can delete an entire OneFS cluster by using the ``--cluster`` argument.

.. code-block:: shell

 $ vlab delete onefs --cluster isi01

Using the ``--name`` argument for OneFS would only delete a single node (without
Smartfailing it).

.. warning::

  Once you delete a component, there's no getting it back. It's gone forever.


Listing/Showing Components
==========================
There are two different commands that will display information about your lab.
To obtain a general overview of your lab just run:

.. code-block:: shell

  $ vlab status

This will give you a list of all the components in your lab, IP information, etc.

To see  a single component, the CLI syntax has the following pattern::

  $ vlab show <component>


Examples
--------
These are some example of the ``vlab show`` syntax for components not captured by the
``vlab status`` command.


List available images
^^^^^^^^^^^^^^^^^^^^^
To see the different versions of OneFS you can deploy, run this command:

.. code-block:: shell

  $ vlab show onefs --images

The same pattern applies to all components. For example, the command to view
all available version of InsightIQ that can be deployed is:

.. code-block:: shell

  $ vlab show insightiq --images


Display port mapping rules
^^^^^^^^^^^^^^^^^^^^^^^^^^
If you want to see the dynamic port mapping rules for accessing components in
your lab, run this command.

.. code-block:: shell

  $ vlab show portmap


Display networks
^^^^^^^^^^^^^^^^

If you've created extra networks, but cannot remember the names, this command will
help.

.. code-block:: shell

  $ vlab show network


CLI Usage Video
===============

This video goes over using the vLab CLI.

.. raw:: html

   <video width="320" height="240" controls>
     <source src="_static/vLabCLI.mp4" type="video/mp4">
   </video>
   <p></p>

.. _connect:

*******************
Connect To Your Lab
*******************

Remember how you had to run ``vlab init`` earlier because every user's lab is
isolated? The network *inside* your lab is also isolated behind a
`NAT firewall <https://en.wikipedia.org/wiki/Network_address_translation>`_.

To make accessing components behind the NAT easier, vLab creates port mapping
firewall rules when you create a new component. The vLab CLI can look up those
rules and directly connect to the component with the following sytnax::

  vlab connect COMPONENT --name NAME


**Protip:** Once you've established a connect to one component, you can *hop* to other
components. For instance, if you connect to a Windows client you can then use Putty *on
that client* to connect to OneFS. This is how you can test SmartConnect or IPv6,
or any other feature that ``vlab connect`` isn't able to leverage.


Using vLab Connect Video
========================

This video shows how the ``vlab connect`` command works.

.. raw:: html

   <video width="320" height="240" controls>
     <source src="_static/vLabNetworkConnect.mp4" type="video/mp4">
   </video>
   <p></p>


Examples
========

Connect to the WebUI on node 2
------------------------------

This command will connect you to the WebUI on node 2 in a cluster named isi01.

.. code-block:: shell

 $ vlab connect onefs --name isi01-2

.. note::

  Make sure to include the node number in the name when connecting to a OneFS
  cluster.

Connect via SSH to node 1
-------------------------

.. code-block:: shell

 $ vlab connect onefs --name isi01-1 --protocol ssh
