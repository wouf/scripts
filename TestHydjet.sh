#!/bin/sh

export SCRAM_ARCH=slc7_amd64_gcc700 
source /cvmfs/sft.cern.ch/lcg/contrib/gcc/7.2.0/x86_64-centos7-gcc7-opt/setup.sh

git clone https://github.com/cms-sw/pkgtools.git
cd pkgtools
git remote add upstream git://github.com/cms-sw/pkgtools.git
git fetch upstream
git branch --track upmaster remotes/upstream/V00-32-XX
git checkout upmaster
git pull
cd ..

git clone https://github.com/cms-sw/cmsdist.git
cd cmsdist
git remote add wf git://github.com/wouf/cmsdist.git
git fetch wf
git branch --track hj remotes/wf/patch-6

git remote add upstream git://github.com/cms-sw/cmsdist.git
git fetch upstream
git branch --track upmaster remotes/upstream/IB/CMSSW_11_0_X/gcc700
git checkout upmaster
git checkout hj hydjet.spec hydjet-toolfile.spec
git pull

cd ..

ln -fs cmsdist CMSDIST
ln -fs pkgtools PKGTOOLS

PKGTOOLS/cmsBuild --new-scheduler -i testFolder -a $SCRAM_ARCH --builders 4 build hydjet-toolfile
