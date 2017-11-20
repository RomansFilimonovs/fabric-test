#!/bin/bash

#
# Copyright IBM Corp. All Rights Reserved.
#
# SPDX-License-Identifier: Apache-2.0
#

########## CI test ##########

CWD=$PWD
PREFIX="result"   # result log prefix

cd ~/gopath/src/github.com/hyperledger/fabric-test/fabric-sdk-node/test/PTE/CITest/scripts


#### Lauch network and execute testcase
#### FAB-3833-2i: 2 invokes, couchDB
./test_driver.sh -n -m FAB-3833-2i -p -c samplecc -t FAB-3810-2q
rm -f ../Logs/FAB-3810-2q*.log
./test_driver.sh -t FAB-3833-2i
./get_peerStats.sh -r FAB-3833-2i -p peer0.org1.example.com peer0.org2.example.com -n $PREFIX -o $CWD -v

#### execute testcase
#### FAB-3810-2q: 2 queries, couchDB
./test_driver.sh -t FAB-3810-2q
grep Summary ../Logs/FAB-3810-2q*.log | grep "QUERY" >> $CWD/$PREFIX"_FAB-3833-2i.log"

