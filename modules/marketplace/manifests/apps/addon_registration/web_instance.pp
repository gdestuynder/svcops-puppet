# describe addon_registration on a webserver.
define marketplace::apps::addon_registration::web_instance(
    $project_dir,
    $port,
    $server_names, # a list of names
    $workers = '12',
    $worker_name = 'addon-registration',
    $user = 'addon_registration_prod',
    $appmodule = 'wsgi:app'
) {
    $config_name = $name

    $app_dir = "${project_dir}/addon_registration"
    $venv = "${project_dir}/venv"
    $environ = "CONFIG=${app_dir}/production.ini"

    uwsgi::instance {
        $worker_name:
            app_dir   => $app_dir,
            appmodule => $appmodule,
            port      => $port,
            home      => $venv,
            user      => $user,
            workers   => $workers,
            environ   => $environ,
            scl       => 'python27'
    }

    marketplace::nginx::addon_registration {
        $config_name:
            server_names => $server_names
    }

}
