######
[E]SRS
######

Website: https://www.dell.com/support/home/en-us/product-support/product/emc-secure-remote-services-virtual-edition/overview

.. warning::

   You need a valid license for OneFS 8.1.0 and newer to connect a cluster to ESRS.
   The trial license will not work.

Intro
#####
Secure Remote Services (formerly ESRS) is a secure, two-way connection between
Dell EMC products and Dell EMC Customer Support that helps customers avoid and
resolve issues up to 73% faster1. It is completely virtual and offers flexibility
for enterprise environments of any size.

Getting Started
###############

Credentials
===========
The default username and password for [E]SRS is:

**SSH** ``root`` and ``a``

**WebUI (first-time login)** ``root`` and ``a``

**WebUI** ``admin`` and you have to set a custom password

.. note::

   Logging into the WebUI as ``root`` is only valid for the first login.
   Part of the configuration of [E]SRS is setting up the ``admin`` account
   for subsequent logins.

Configuring
===========

Deploying [E]SRS
----------------

1. Update [E]SRS
^^^^^^^^^^^^^^^^
After you've deployed an instance of [E]SRS, connect to it via SSH and run:

.. code-block:: shell

   /opt/esrsve/vappconfig/update.sh

.. note::

   The machine will reboot, and you'll lose your SSH connection. This is expected.
   Please be patient while the machine reboots; it take several minutes.

2. Login to the WebUI
^^^^^^^^^^^^^^^^^^^^^
Click the ``Login`` button in the upper right of the web page:

.. image:: web_login.png

And login with the **WebUI (first-time login)** username and password (``root`` and ``a``).

3. Accept the EULA
^^^^^^^^^^^^^^^^^^
Scroll to the bottom of the EULA, check the ``Accept`` box and click ``Submit``:

.. image:: accept_eula.png

4. Set a password for ``admin``
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
Now you have to configure a custom password for the ``admin`` account:

.. image:: set_admin_password.png

.. note::

   After setting the password, the next page might appear to hang. Just be patient;
   it'll finish loading.

5. Register Contacts
^^^^^^^^^^^^^^^^^^^^
Fill out Primary Contact information, and then click the submit button in the
lower right:

.. image:: primary_contact.png

Skip the technical contact page by clicking this button:

.. image:: skip_tech_contact.png

6. Provision [E]SRS
^^^^^^^^^^^^^^^^^^^
Skip configuring a proxy by clicking ``Network Check`` in the upper left:

.. image:: skip_to_network_check.png

You **must** run the network test before being able to continue:

.. image:: run_network_test.png

On this page, you need to enter **your** RSA credentials:

.. image:: enter_rsa_creds.png

Finally, enter ``1004556575`` for the Site ID:


.. image:: enter_site_id.png


Once the Site ID is accepted and you click the ``Next`` button, the [E]SRS
server will go through the provision process. This can take several minutes
to complete.

7. Configure Email
^^^^^^^^^^^^^^^^^^
Enter **your** work email address, in the ``Notification Email(s)`` section.
Use the following for the remaining required fileds:

Server - ``mailhub.lss.emc.com``

Port   - ``25``

Sender Email: ``noreply@dell.com``

.. image:: email_config.png

.. note::

   If you get an error when configuring email, just skip it.

8. Complete Setup
^^^^^^^^^^^^^^^^^
Skip to the ``Connect Home`` page by clicking:

.. image:: skip_to_connect_home.png

And click the ``Complete setup`` button:

.. image:: complete_setup.png

Your [E]SRS instance is now ready for use! You can click on the Dashboard
button, which will take you back to the login page:

.. image:: to_dashboard.png


.. note::

   You'll have to login with the ``admin`` and custom password you created
   to access the dashboard.
