#!/bin/bash
IMGNAME=diamond-ansible
IMGVERSION=1.0
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

