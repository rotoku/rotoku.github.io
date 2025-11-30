systemctl unmask rsyslog.service
systemctl enable rsyslog.service
systemctl start rsyslog.service



sh ./Assessor-CLI.sh -i -rd /var/www/html/ -nts -rp index

./kube-bench --config-dir `pwd`/cfg --config `pwd`/cfg/config.yaml