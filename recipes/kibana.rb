node.set['kibana']['file']['config_template_cookbook'] = cookbook_name

include_recipe 'et_kibana_lwrp::install'
