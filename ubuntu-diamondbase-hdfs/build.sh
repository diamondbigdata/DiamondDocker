#!/bin/bash
IMGNAME=diamond-hdfs
IMGVERSION=2.7.2
docker build -t localreg:5000/$IMGNAME:$IMGVERSION .

