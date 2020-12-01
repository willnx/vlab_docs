###########
Deployments
###########

Intro
=====
Deployments allow users to share infrastructure without having to share the same
instance of that infrastructure. Problems always arise when multiple labs share
the same Active Directory Domain Controller, DNS, etc. One user will need to break
that piece of infrastructure to test something, then forget to fix it after they're
done testing. This is why a lot of labs get the reputation for "always being broken."
Deployments in vLab solve this problem by allowing users to convert machines in
*their* lab into a template. These templates can then be deployed by other users,
into their private lab.


Getting Started
===============
This section goes over creating deployment templates, and how to deploy a template
in your lab.

Deploying a template
--------------------
This is really simple! Just run the following command, replacing ``<name>`` with
literal name of a deployment template:

.. code-block:: shell

   vlab create deployment --image <name>

The argument is called ``--image`` to maintain consistency with other ``vlab create``
commands.

.. note::

   You are only allowed one active deployment in your lab at a time.

To see all the available deployment templates, the command is like every other
vLab component:

.. code-block:: shell

   vlab show deployment --images

To see additional information about the template, like the IPs used by the different
machines, append ``-v``/``--verbose`` to the above command.

Creating a template
-------------------
This is the not so simple part. It's not difficult, but there are rules. Rules
that you **must** follow:

1) IP addresses must be statically defined for each machine in your template.
2) The state of a machine must persist a reboot.

The first rule is to avoid IP address collisions (i.e. two machines trying to use
the same IP address). The second rule applies mostly to training scenarios. If
rebooting the machine fixes the problem, then there's nothing for students to
troubleshoot.

.. note::

   Don't forget, every OS on the planet has a way to run a script upon boot. So
   even if a reboot fixes the issue, there's probably a way to script it to break
   upon boot.

Static IP range for deployments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
The following IP range is reserved in ever users lab for deployed templates:

* ``192.168.1.220`` to ``192.168.1.255``

.. warning::

   If you *change* the IP of a machine after creating it, you need to update
   the portmap rules for that machine. Use ``vlab create portmap`` and ``vlab delete portmap``
   to update these rules.

Command Syntax
^^^^^^^^^^^^^^
The creation process is slow, so it's best to double check your work before wasting
time creating a broken template. Here's a simple check list you should perform
before creating a template:

* Does ``vlab show portmap --verbose`` show the correct IPs for the machines in your template?
* Do your machines work after rebooting all of them?

When you're ready to create a new template, the syntax is fairly simple:

.. code-block:: shell

   vlab create template --name <name> --machines <vm01> <vm02> --summary <a short description>

Here's a more concret example of creating a template named ``nick`` consisting
of 3 VMs named ``isi01-1``, ``isi01-2``, and ``isi01-3``:

.. code-block:: shell

   vlab create template --name nick --machines isi01-1 isi01-2 isi01-3 --summary Basic 3-node OneFS cluster

.. warning::

   Template names are limited to upper case, lower case, numbers, underbars, and dashes
   (i.e. this `regular expression <https://en.wikipedia.org/wiki/Regular_expression>`_: ``^[A-Za-z0-9_-]+$``).
   Adding something like a ``@`` in the name will SPAM a not easy to understand error.


Modifying a template
--------------------
This section goes over how to change aspects of a template. Only the owner of
a template is able to make changes to it.

Changing the summary
^^^^^^^^^^^^^^^^^^^^
To change the summary/description of a template the syntax is:

.. code-block:: shell

   vlab apply template --name <name> --summary <a description of the template>

Where ``<name>`` is related with the literal name of a template, and ``<a description
of the template>`` is the new summary.

Changing the owner
^^^^^^^^^^^^^^^^^^
To change the owner of a template, run:

.. code-block:: shell

   vlab apply template --name <name> --owner <username>

Where ``<name>`` is related with the literal name of a template, and ``<username>``
is the vLab username of the new owner.


Changing the VMs in a template
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
No. Delete the template and remake it with the correct VMs.
