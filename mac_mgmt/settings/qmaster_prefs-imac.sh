#!/bin/bash

name=$(scutil --get ComputerName)

qmasterprefs -stopSharing

qmasterprefs -allowBonjourDiscovery on

qmasterprefs -cluster off autorestart off servername "${name}" quickclusterservername "${name} Cluster" maxactivetargets 40 maxactivesegments 400 storagepath "/var/spool/qmaster" privatestorage off publishedstorage on storagecleanupthreshold 7 unmanagedservices on unmanagedmulticapturethreshold 0 networkinterface en0 log 3 truncate on
 
qmasterprefs -statusMenu on

qmasterprefs -service "Compressor Processing" on sharing on instances 1 autorestart off unmanaged off log 3 truncate on
 
qmasterprefs -service "Rendering" off sharing off instances 1 autorestart off unmanaged off log 3 truncate on

qmasterprefs -startSharing servicesOnly
