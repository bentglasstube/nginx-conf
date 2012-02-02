all: update restart

update:
	ssh eatabrick.org 'cd /etc/nginx; git pull'

restart:
	ssh eatabrick.org 'sudo service nginx restart'
