#####################
Tips, Tricks, and FAQ
#####################

The single best piece of advice for working with vLab is:

    *"If it hurts, do it more often"*
    - `Martin Fowler <https://martinfowler.com/bliki/FrequencyReducesDifficulty.html>`_

What this means is that your lab should be impermanent. Deleting a component and
replacing it should be as time consuming and painful as logging into your
workstation. Starting all over shouldn't be *"the end of the world"* or an all-day
event. This advice sounds counter intuitive, but the reality is that the more
transient your lab is, the more it benefits you.

***
FAQ
***

Who/where can I ask questions about vLab?
=========================================

Check out our Slack channel (#vlab-beta) at https://isilon-support.slack.com/messages/CCQJMMHHR/


What's the username/password for ... ?
======================================

Most components allow users to login as either ``root``, ``admin``, or ``administrator``.
If you're trying to access the vCenter HTML console, the generic user is ``readonly@vsphere.local``.

The password is probably a lower-case ``a``. Unless it's your Jumpbox; you should
have changed that password.


How to I request a new feature?
===============================

Easy! Just file an issue at https://github.com/willnx/vlab/issues
Keep in mind that we'll have questions about your feature request, so please
make sure to follow up in the issue with us.


I found a bug, what do I do?
============================

Awesome, thanks for finding that!
Please file an issue at https://github.com/willnx/vlab/issues

When you file an issue, please include:

1) The version of vLab CLI your using (the output of ``vlab --version``)
2) What command you ran
3) What the output was
4) What you expected to happen
