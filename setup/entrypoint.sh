#!/bin/bash
cp /srv/repositories/server.conf /opt/ghidra/server/server.conf
/bin/bash -c "/opt/ghidra/server/ghidraSvr console"
