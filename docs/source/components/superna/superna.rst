#######
Superna
#######

Website: https://www.supernaeyeglass.com/

Intro
=====
Superna creates a product called Eyeglass that integrates with Dell EMC PowerScale
(aka OneFS) to automate processes like `Disaster Recovery <https://en.wikipedia.org/wiki/Disaster_recovery>`_
and defend files against `Ransomware <https://www.cisa.gov/ransomware>`_.


Getting Started
===============
This section will help you deploy a Superna Eyeglass machine in vLab. This document
does not cover configuring the device to work with Dell EMC PowerScale.


Create a Superna Account
------------------------
In order to request a license, you have to first create an account with Superna:

- https://support.superna.net/hc/en-us

Obtaining a license
-------------------
Licenses for Superna are single use. This means if you redeploy an Eyeglass server
you need to request a new license. To request a license, follow the directions
on this site:

- https://www.supernaeyeglass.com/license-keys

Credentials
-----------
The main user for Superna Eyeglass is ``admin`` with a default password of
``3y3gl4ss``.

Configuring
-----------
Once you've deployed your Superna Eyeglass device in vLab and have obtained a license,
you'll need to access the web interface to configure the device.

.. warning::

   The web interface can only be accessed from **inside** your lab. This means
   you have to connect from Windows/CentOS/etc device deployed in your lab.
   This is because the Superna web interface runs user authentication via a
   different port than the website, and in vLab, your device is behind a
   `NAT <https://en.wikipedia.org/wiki/Network_address_translation>`_ in vLab.

If you need help configuring Superna Eyeglass, checkout their offical documentation:

- https://manuals.supernaeyeglass.com/
