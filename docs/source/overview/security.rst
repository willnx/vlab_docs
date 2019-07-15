##########################
How Security Works in vLab
##########################

- `Authentication <https://en.wikipedia.org/wiki/Authentication>`_: *Who you are*
- `Authorization <https://en.wikipedia.org/wiki/Authorization>`_: *What you have permissions to do*

.. _auth-tokens:

****************
Securing the API
****************

The vLab server uses `JSON Web Tokens <https://jwt.io>`_ (JWT) to identify *who you are*
once a user successfully authenticates with
`Active Directory <https://en.wikipedia.org/wiki/Active_Directory>`_.
Inside the JWT is identity information (i.e. your
`sAMAccountName <https://docs.microsoft.com/en-us/windows/win32/ad/naming-properties#samaccountname>`_)
the client IP that requested the token (to prevent
`session hijacking <https://www.owasp.org/index.php/Session_hijacking_attack>`_)
a version number (because...) and some
`registered claims <https://tools.ietf.org/html/rfc7519#section-4.1>`_
that are recommend for all JWTs.

In production,
`asymmetric keys <https://en.wikipedia.org/wiki/Public-key_cryptography>`_
are used to create and decode the JWTs. Using asymmetric keys enables a single source of
truth (the `authentication service <https://github.com/willnx/vlab_auth_service>`_)
to generate the tokens, while providing strong guarantees to other services
(including the :ref:`vlab-cli`) that a token has not been tampered with.
