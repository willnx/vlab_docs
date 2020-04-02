######
DataIQ
######

Website: https://www.dell.com/support/home/us/en/19/product-support/product/data-iq/overview

Intro
=====
DataIQ is a data discovery, classification and mobility software which addresses
the challenges of unstructured data such as explosive growth, data dispersion and
data trapped in silos. DataIQ provides a holistic, unified view into all file and
object data across an enterprise all on a single pane of glass.

Getting Started
===============

Credentials
-----------
Accessing the host OS running DataIQ has a separate set of credentials than
the web interface.

Host OS
^^^^^^^
Username - ``administrator``

Password -  ``administrator`` (username and password is the same)

Web Interface
^^^^^^^^^^^^^
When you install DataIQ a temporary password for ``administrator`` will be in
``/opt/dataiq/install/keycloak_admin.passwd``. Upon logging in, you will be
prompted to set a new password for the ``administrator`` user.

Username - ``administrator``

Password - No default password


Accessing the Web Interface
---------------------------
Logging into the web interface for DataIQ in vLab is a bit different. You can't
use the browser on your computer. Instead, you have to use a browser *inside*
your lab. To make this easier, vLab installs a GUI and an RDP server on the
host running DataIQ. When you run ``vlab connect dataiq --name mydataiq`` an
RDP session is made. So just pop open a browser in that RDP session and enter
the IP of your DataIQ machine.

ProTip - If you use get an error about an invalid parameter while logging into
DataIQ, checkout `KB 542477 <https://support.emc.com/kb/542477>`_.
