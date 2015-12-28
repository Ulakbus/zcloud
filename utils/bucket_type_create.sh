#!/usr/bin/env bash
bucket_type=$(sudo riak-admin bucket-type list | grep buildbot);
if [ "buildbot_test (active)" == "$bucket_type" ]; then
    echo "bucket type exists";
else
    sudo riak-admin bucket-type create buildbot_test '{"props":{"consistent":true, "n_val":5}}'
    sudo riak-admin bucket-type activate buildbot_test
fi