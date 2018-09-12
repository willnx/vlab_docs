########
vLab API
########

This section goes over the vLab server API, and provides some examples of interacting
direction with it.

************
API Overview
************

The vLab server has a basic RESTful API. Communication is done over HTTPS, is
secured using a `JSON Web Tokens <https://jwt.io>`_ (JWT), and most endpoints simply
use JSON as the Content-Type. The vLab API uses standard HTTP status codes when
responding to client requests. The API is also versioned, and the expectation is
that only non-backwards compatible changes rev the version. In other words, more
can be added to an existing API provides it doesn't not legacy clients.

The hardest part for most RESTful API is the hypermedia aspect of the REST model.
vLab's API addresses hypermedia in two ways:

- All service endpoints support the ``describe=true`` parameter to obtain schema information
- Most service responses leverage the `link header <https://tools.ieft.org/html/rfc5988>`_ as a means of *where to next*

The API can be thought of as two basic groupings:

1) Authentication/Authorization
2) Infrastructure interactions

The follow sections dig into these groups in more detail.


****************************
Authentication/Authorization
****************************

These API end points support generating and (if needed) validating the authentication
tokens. Below is a list of the API end points, and short description of what they're
used for:

- ``/api/1/auth/token`` - Create, delete, and validate auth tokens
- ``/api/1/auth/key`` - Obtain the public key for decrypting  a token


***************************
Examples using the Auth API
***************************

To make the examples easier to read, the JWTs are shorted to ``asdf.asdf.asdf``.

The Python examples use the `requests <http://docs.python-requests.org/en/master>`_ library because it's great!


Obtaining a token
=================

Python
------

.. code-block:: python

   import requests
   resp = requests.post('https://localhost/api/1/auth/token', json={'username' : 'sam', 'password': 'iLoveCats'})
   token = resp.json()['token']

cURL
----

.. code-block:: shell

   $ curl --fail -X POST -H "Content-Type: application/json" -d '{"username": "sam", "password": "iLoveCats"}' https://localhost/api/1/auth/token


Deleting a token
================

Python
------

.. code-block:: python

   import requests
   resp = requests.delete('https://localhost/api/1/auth/token', json={'token' : 'asdf.asdf.asdf'})
   resp.status_code

cURL
----

.. code-block:: shell

   $ curl --fail -X DELETE -H "Content-Type: application/json" -d '{"token": "asdf.asdf.asdf"}' https://localhost/api/1/auth/token

Verifying a token
=================

Python
------

.. code-block:: python

   import requests
   resp = requests.get('https://localhost/api/1/auth/token', headers={'X-Auth' : 'asdf.asdf.asdf'})
   resp.status_code

cURL
----

.. code-block:: shell

   $ curl --fail -H "X-Auth: asdf.asdf.asdf" https://localhost/api/1/auth/token

Obtaining the public key, and checking the user's identity
==========================================================

Python
------

This example uses the `pyjwt` library for decoding the JWT.

.. code-block:: python

   import jwt
   import requests
   resp = requests.get('https://localhost/api/1/auth/key')
   data = resp.json()
   public_key = data['key']
   algorithm = data['algorithm']
   token = 'asdf.asdf.asdf'
   user_info = jwt.decode(token, public_key, algorithm=algorithm)


**************
Infrastructure
**************

This is the bulk of the vLab end points. All interactions with the infrastructure
resources is asynchronous. This means that when you want to create, delete, or list
specific components, that action is not done within the single API request. The
pattern avoids the *"Unbound amount of work in a bound amount of time"* problem.
Creating a VM today might simply take longer because of load, or deploying a new
type of component simply takes longer. Most HTTP requests timeout after a minute
at most, and creating a VM typically takes more than that.

For example, image you want to create a new OneFS node. What happens is that the
initial API call to ``/api/1/inf/onefs`` generates a ``task-id``. While the vLab
server processes the request, and creates the OneFS ndoe, you call the ``/task``
end point with the specific ``task-id`` to check on the status of the deployment.
It's sort of like going to the Department of Motor Vehicles, where you walk in,
grab a ticket, then wait.

The general pattern for the API end points is:

- ``/api/1/inf/<resource>``
- ``/api/1/inf/<resource>/task``

Where ``<resource>`` is a specific component of infrastructure. Here's a list
of the currently available API end points. Please let us know if we forget to
update it!

- ``/api/1/inf/gateway`` - The NAT firewall in your lab
- ``/api/1/inf/jumpbox`` - What you login to when accessing your lab
- ``/api/1/inf/esrs`` - The Dell EMC ESRS component
- ``/api/1/inf/insightiq`` - The Dell EMC InsightIQ component
- ``/api/1/inf/onefs`` - The Dell EMC OneFS component
- ``/api/1/inf/cee`` - The Dell EMC Common Event Enabler component
- ``/api/1/inf/router`` - A way to connect different networks in your lab
- ``/api/1/inf/network`` - Create a new VLAN network in your lab
- ``/api/1/inf/link`` - A (terrible) URL shortner
- ``/api/1/inf/power`` - Turn on/off/reboot a VM in your lab
- ``/api/1/inf/inventory`` - The different VMs in your lab

*************************************
Examples using the Infrastructure API
*************************************

To make the examples easier to read, the JWTs are shorted to ``asdf.asdf.asdf``.

All of these examples are in Python, and use `requests <http://docs.python-requests.org/en/master>`_
library because it's great!


List all the items in your lab
==============================

This example pulls for the status once every second, and gives up after 5 minutes.

.. code-block:: python

   import time
   import requests
   resp = requests.get('https://localhost/api/1/api/inventory', headers={'X-Auth' : 'asdf.asdf.asdf'})
   task_id = resp.json()['content']['task-id']
   for _ range(300):
     status = requests.get('https://localhost/api/1/api/inventory/task/{}'.format(task_id), headers={'X-Auth' : 'asdf.asdf.asdf'})
     if status.status_code == 202:
       time.sleep(1)
     else:
       break
   print(status.json())
