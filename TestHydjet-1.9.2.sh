#!/bin/sh

export SCRAM_ARCH=slc7_amd64_gcc900
source /cvmfs/sft.cern.ch/lcg/contrib/gcc/9/x86_64-centos7-gcc9-opt/setup.sh

git clone https://github.com/cms-sw/pkgtools.git
cd pkgtools
git remote add upstream git://github.com/cms-sw/pkgtools.git
git fetch upstream
git branch --track upmaster remotes/upstream/V00-33-XX
git checkout upmaster
git pull
cd ..

git clone https://github.com/cms-sw/cmsdist.git
cd cmsdist
git remote add wf git://github.com/wouf/cmsdist.git
git fetch wf
git branch --track hj remotes/wf/IB/CMSSW_11_2_X/master

git remote add upstream git://github.com/cms-sw/cmsdist.git
git fetch upstream
git branch --track upmaster remotes/upstream/IB/CMSSW_11_2_X/gcc9
git checkout upmaster
git checkout hj hydjet.spec
git pull

cd ..

ln -fs cmsdist CMSDIST
ln -fs pkgtools PKGTOOLS

PKGTOOLS/cmsBuild --new-scheduler -i testFolder -a $SCRAM_ARCH --builders 4 build hydjet-toolfile
