####
Kemp
####

Website: https://kemptechnologies.com/

Intro
=====
Kemp offers a load balancer specifically tailored for use with Dell EMC ECS
called the ECS Connection Manager. To use it in vLab you'll have to obtain
a trial license.

Getting Started
===============
This section will help you deploy the Kemp ECS Connection Manager in vLab. This
document does not go over configuring the device to work with ECS.

Create a Kemp Account
---------------------
To obtain a trail license, you'll first have to create an account. They've
setup a specific page for Dell EMC employees:

- https://kemptechnologies.com/dell-emc-ecs-nfr-virtual-appliance-license-request/

For vLab, skip the step directing you to download the Virtual Appliance. That's
already been done for you.

.. note::

   The email sent from Kemp might have been caught by your SPAM filter. At Dell
   this means you have to manually release it via one of those ``EmailDigest``
   emails.


Credentials
-----------
After deploying the machine in vLab, you need to open the console to obtain
the login credentials. To open the console, run the following command, replacing
``<name>`` with the literal name of your Kemp device:

.. code-block:: shell

   $ vlab connect kemp --name <name> --protocol console


Configuring
-----------
Once you've deployed your Kemp device in vLab, and obtained the login credentials
from the console, open the web interface:

.. code-block:: shell

   $ vlab connect kemp --name <name>

You'll be guided through the initial system configuration. If you have issues
or need additional documentation to configure the device for ECS, checkout Kemp's
official documentation:
(Skip to the "Get Started with ECS Connection Manager" secion)

- https://kemptechnologies.com/ecs-connection-manager/
