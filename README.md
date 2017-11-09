# ansible-oracle10g
This playbook deploy Oracle10g on CentOS 7.

Variables
=========

You must specify download url:

    oracle_distro_url: "http://some_local_repository/10201_database_linux_x86_64.cpio.gz"

Example Playbook
================

    ---
    - hosts: oracle10g
      remote_user: root
      vars:
      - oracle_distro_url: "http://corp_repo.loc/10201_database_linux_x86_64.cpio.gz"
      - oracle_sys_password: "SomeStrongPassword"

      roles:
        - oracle10g

Dependencies
============

License
=======

BSD

Author Information
==================

Ivan Zharenkov

Special thanx
=============

to Habrauser vajadhava with your topic: https://habrahabr.ru/post/144403/

