#########
Snapshots
#########

Additional documentation: https://en.wikipedia.org/wiki/Snapshot_(computer_storage)

Intro
=====
A snapshot allows you to test out changes made to a virtual machine, then
quickly/easily revert the virtual machine back to the point in time before those
changes were made. This is really handy when attempting to recreate an issue,
and learning how to configure a specific feature.

Usage
=====
Snapshots in vLab are specifically intended for:

* Attempting to recreate reported issue
* Learning how to configure a given feature/service

Snapshots are not, and never will be, a mechanism for performing a periodic
refresh of a given environment. In other words, if you're looking for a way to
*revert your lab every Sunday night to a known good state*, snapshots are not
the solution.

Limits
======
Snapshots consume storage, and continue to grow as a virtual machine runs.
To avoid *"being that customer"* that fills up a storage array, vLab imposes
the following limits on snapshots:

* A virtual machine can have no more than 3 snapshots at once
* Snapshots expire 72 hours after creation
* Expired snapshots are automatically deleted

Getting Started
===============
This section goes over how to create, list, and delete snapshots, as well as
reverting to one.

Creating a snapshot (basic)
---------------------------
A snapshot is a point-in-time checkpoint of a given virtual machine in your lab.

To create a snapshot, the CLI command is like this:

.. code-block:: shell

 $ vlab create snapshot --name <name of the VM>

Where ``<name of the VM>`` is replaced with the literal name. For instance, if
you have a VM named ``ADServer`` the command to create a snapshot would be:

.. code-block:: shell

 $ vlab create snapshot --name ADServer

Creating a snapshot (shifting)
------------------------------
Because a virtual machine can only have 3 snapshots, you can tell vLab to *shift*
your snapshots around. This *shift* operation will create a new snapshot, and delete
the oldest when 3 snapshots already exist:

.. code-block:: shell

 $ vlab create snapshot --name ADServer --shift

Showing snapshots
-----------------
You see all the snapshots your virtual machines have by running the following
command:

.. code-block:: shell

 $ vlab show snapshot

Here's an example of that output::

  $ vlab show snapshot
  Looking up snapshots in your lab

   Component Name   | Snapshot ID   | Expiration Date
  ------------------+---------------+-------------------
   iiq              | 1aa1b2        | 06/16/2019 14:53
                    | 506353        | 06/16/2019 18:54
   isi02-1          | None          | N/A
   isi01-1          | 2aa389        | 06/17/2019 09:02
   defaultGateway   | None          | N/A



Deleting a snapshot
-------------------
To delete a snapshot, you must specify the snapshot ID **and** the name of virtual machine
that it belongs to.

Here's an example of deleting a snapshot owned by the virtual machine named ``ADServer``
with a snapshot ID of ``aabbcc``:

.. code-block:: shell

 $ vlab delete snapshot --name ADServer --snap-id aabbcc


Reverting to a snapshot
-----------------------
Once you've created a snapshot, you can revert the virtual machine to that point
in time (until I auto-delete that snapshot after 72 hours).

.. warning::

   Reverting to a snapshot means all the files, configs, etc created since that
   snapshot will be deleted.

To apply a snapshot you must supply the specific snapshot ID **and** the name
of the virtual machine that owns it.

Here's an example of reverting to a snapshot owned by ``SomeVM`` with an ID of ``aabbcc``:

.. code-block:: shell

 $ vlab apply snapshot --name SomeVM --snap-id aabbcc
