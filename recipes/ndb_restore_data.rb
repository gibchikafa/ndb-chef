my_node_id = find_service_id("ndbd", 1)

# Don't ask
ndb_connectstring()
mgm_connection = node['ndb']['connectstring']
backup_id = 1
backup_directory = node['ndb']['local_backup_dir']
exclude_databases="glassfish_timers.EJB__TIMER__TBL,hopsworks.hosts,hopsworks.host_services"

bash 'ndb_restore data' do
    user 'root'
    group 'root'
    code <<-EOH
        #{node['ndb']['scripts_dir']}/restore_backup.sh ndb-restore -p #{backup_directory}/BACKUP/BACKUP-#{backup_id} -n #{my_node_id} -b #{backup_id} -c #{mgm_connection} -e #{exclude_databases} -m DATA
    EOH
    not_if { backup_directory.empty? }
end