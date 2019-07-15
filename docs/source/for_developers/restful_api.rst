############
RESTful APIs
############

This section contains documentation for the public RESTful APIs of vLab.

Intro
=====

The vLab server has a basic RESTful API. Communication is done over HTTPS, is
secured using `JSON Web Tokens <https://jwt.io>`_ (JWT), and most endpoints simply
use JSON as the Content-Type. The vLab API uses standard HTTP status codes when
responding to client requests. The API is also versioned, and the expectation is
that only non-backwards compatible changes increment the version. In other words,
more can be added to an existing API provides it doesn't not legacy clients.

The vLab API can be broken down into two different categories: synchronous and asynchronous.
The synchronous API end points complete the requests in a single call, where as
the async end points return a task id (aka ticket, job id) and the caller must make
additional calls to check on the status of the task.

It's easy to identify which end points generate tasks: only the ``inf``
(short for infrastructure) resources are asynchronous. These resources interact
with virtual machines in a user's lab performing actions like creating, deleting,
enumerating, configuring, snapshoting, etc. The bulk of these actions take minutes
to complete, so if vLab attempted these actions in a single API call then most
clients would timeout before the request could be completed. To make the API more
consistent (that's a big goal for vLab), all actions under the ``inf`` resource
are async, even if completing the request is possible in a single request.


Here's a (probably out of date) list of the base end points in vLab:


Authentication
--------------
These end points are owned by the :ref:`auth-service` service
- /api/1/auth/key
- /api/1/auth/token
- /api/2/auth/token

Port Forwarding
---------------
These end points are owned by the :ref:`vlab-ipam` service
- /api/1/ipam/addr
- /api/1/ipam/portmap

Other
-----
Checkout the :ref:`link-service` doc for some context.

- /api/1/link

Infrastructure
--------------
All ``inf`` based resources contain a ``task`` subpoint for checking the status
of an async task.
Links to their docs are :ref:`inventory`, :ref:`power-service`, and :ref:`snapshot-service`.

- /api/1/inf/inventory
- /api/1/inf/power
- /api/1/inf/snapshot

.. _inf-vms:

Virtual Machines
----------------
All virtual machine end points have a ``/images`` subpoint for obtaining a list
of available images/versions that can be deployed.

The OneFS and ECS resouces have a ``/config`` subpoint which automates the
configuration of the machine into a *ready to use* thing.

- /api/2/inf/cee
- /api/2/inf/centos
- /api/2/inf/claritynow
- /api/2/inf/ecs
- /api/2/inf/esrs
- /api/2/inf/esxi
- /api/2/inf/gateway
- /api/2/inf/icap
- /api/2/inf/insightiq
- /api/2/inf/onefs
- /api/2/inf/router
- /api/2/inf/vlan
- /api/2/inf/windows
- /api/2/inf/winserver

.. _hypermedia:

Discovery
=========
The hardest part for most RESTful API is the hypermedia aspect of the REST model.
vLab's API addresses hypermedia in a few ways:

- All service endpoints support the ``describe=true`` parameter to obtain schema information
- Most service responses leverage the `link header <https://tools.ieft.org/html/rfc5988>`_ as a means of *where to next*

For example, assume the FQDN for the vLab server is ``vlab.org``. To view
the schema of the OneFS resource the HTTP request would look like::

  GET /api/2/inf/onefs?describe=true
  Host: vlab.org

The response would be a JSON object that defines the support methods, those methods
required `JSON schema <https://json-schema.org/>`_ for a request body, and the
schema of the respond body.

Auth tokens
===========
This section talks about using the vLab auth tokens to make API requests.
To get an idea about *what they are* checkout the :ref:`auth-tokens` page.

While maybe a bit
`controversial <https://stackoverflow.com/questions/3561381/custom-http-headers-naming-conventions>`_,
vLab requires a customer HTTP header labled ``X-Auth`` when sending an auth token.
Why? Because browsers are horrible caching monsters, and I don't want to deal with
them caching an expired token.

Here's an example of including the auth token in an HTTP request::

    GET /api/1/inf/ipam/addrs
    Host: vlab.org
    X-Auth: asdf.asdf.asdf


This is what it would look like in a ``cURL`` command:

.. code-block:: shell

   $ curl --fail -X GET -H "X-Auth: asdf.asdf.asdf" https://vlab.org/api/1/ipam/addr


Examples
========
This section contains examples of how to interact with some of the resources
in vLab.

- These example use ``vlab.org`` for the server; make sure to update your syntax.
- To make the examples easier to read, the JWTs are shortened to ``asdf.asdf.asdf``.
- The Python examples use the `requests <http://docs.python-requests.org/en/master>`_ library because it's great!


Obtaining a token
-----------------
To do just about anything in vLab, you'll need to obtain an auth token.


Python
^^^^^^

.. code-block:: python

   import requests
   resp = requests.post('https://vlab.org/api/2/auth/token', json={'username' : 'sam', 'password': 'iLoveCats'})
   token = resp.json()['token']

cURL
^^^^

.. code-block:: shell

   $ curl --fail -X POST -H "Content-Type: application/json" -d '{"username": "sam", "password": "iLoveCats"}' https://vlab.org/api/1/auth/token


Use the public key to decode an auth token
------------------------------------------
This example uses the `pyjwt <https://pyjwt.readthedocs.io/en/latest/>`_
library for decoding the JWT.

.. code-block:: python

   import jwt
   import requests
   resp = requests.get('https://vlab.org/api/1/auth/key')
   data = resp.json()
   public_key = data['key']
   algorithm = data['algorithm']
   token = 'asdf.asdf.asdf'
   user_info = jwt.decode(token, public_key, algorithm=algorithm)


List all the items in your lab
------------------------------
This example pulls for the status once every second, and gives up after 5 minutes.

.. code-block:: python

  import time
  import requests
  inventory_url = 'https://vlab.org/api/1/api/inventory'
  headers = {'X-Auth' : 'asdf.asdf.asdf'}
  resp = requests.get(inventory_url, headers=headers)
  task_id = resp.json()['content']['task-id']
  for _ range(300):
    status = requests.get('{}/task/{}'.format(inventory_url, task_id), headers=headers)
    if status.status_code == 202:
      time.sleep(1)
    else:
      break
  print(status.json())


This example is the same thing, except it leverages the link header note in the :ref:`hypermedia` section.

.. code-block:: python

  import time
  import requests
  inventory_url = 'https://vlab.org/api/1/api/inventory'
  headers = {'X-Auth' : 'asdf.asdf.asdf'}
  resp = requests.get(inventory_url, headers=headers)
  status_url = requests.links['status']['url']
  for _ range(300):
    status = requests.get(status_url, headers=headers)
    if status.status_code == 202:
      time.sleep(1)
    else:
      break
  print(status.json())


Create a Port Forwarding rule
-----------------------------
This example will create a port forwarding rule on a user's gateway

.. code-block:: python

   import requests
   ipam_url = 'https://vlab.org/api/1/ipam/portmap'
   headers = {'X-Auth' : 'asdf.asdf.asdf'}
   payload = {'target_addr' : '192.168.1.20',
              'target_port' : '22',
              'target_name' : 'isi01-1',
              'target_component' : 'OneFS'}
   resp = requests.post(ipam_url, json=body, headers=headers)
   print(resp.json())
