#!/usr/bin/python

"""
Rudimentary utility to cleanup old/unused/obsolete EBS snapshots from AWS
based on values in description
"""

import boto
import boto.ec2

region="us-east-1"
acess_key="BLAHBLAHBLAH"
secret_key="BlahBlahBlahBlahBlahBlahBlah"
conn = boto.ec2.connect_to_region(region, aws_access_key_id=access_key, aws_secret_access_key=secret_key)
		
snapshots = conn.get_all_snapshots(owner="self")

for snapshot in snapshots:
	description=getattr(snapshot, 'description')
	id=getattr(snapshot, 'id')
	tags=getattr(snapshot, 'tags')
	if 'Created by CreateImage' in description:
#	if description == "":
		#if "DeleteOn" not in tags.keys():
		print(id, description, tags)
		try:
			snapshot.delete(dry_run=False)
		except:
			pass

