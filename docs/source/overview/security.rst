##########################
How Security Works in vLab
##########################

- Authentication: *Who you are*
- Authorization: *What you have permissions to do*


****************
Securing the API
****************

The vLab server uses `JSON Web Tokens <https://jwt.io>`_ (JWT) to identify *who you are*.
Inside the JWT is identity information, like your username and/or group memberships.
So, instead of storing authorization information in the token, authentication information
is stored. The individual services in vLab are responsible for authorization based
on the identity stored within the JWT. In production, asymmetric keys are used to
create and decode the JWTs. Using asymmetric keys enables a single source of
truth (the authentication service) to generate the tokens, while providing strong
guarantees to other services (including the CLI client app) that a token has not
been tampered with.

JSON Web Tokens expire after a defined period of time. Given the low threat level
of vLab, the tokens expire after a standard work-day length of time. This approach
balances the need for security with the usability of the system. Relying on the
expiration of the JWT enables are more state-less approach to authentication, but
at the cost of safety. If a user's token was compromised, there's be no way of
stopping a malicious entity from impersonating that user. To address this, the
authentication service can also be used to validate if a JWT has been explicitly
deleted. The API end points that create or delete items within a user's lab should
leverage this functionality of the authentication service. End points that simply
list items do not need this extra level of security because accessing a users lab
requires a different set of credentials than the JWT used by the API.
