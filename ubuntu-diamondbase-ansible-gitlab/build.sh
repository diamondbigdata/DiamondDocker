#!/bin/bash
IMGNAME=diamond-ansible-gitlab
IMGVERSION=1.0
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

