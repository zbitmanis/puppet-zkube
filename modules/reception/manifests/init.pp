class reception {
  contain reception::motd 
  contain reception::issue
  contain reception::issue_confidential
}

class reception::motd (String $role = 'kube'){
  file { '/etc/motd': 
        mode => '0644',
       	owner=> 0,
        group=> 0 ,
        content =>  inline_template ("Role: <%= @role %>\nManaged Node: <%= @hostname %>\nManaged by Puppet\n "),  
      }
}

class reception::issue (String $domain = 'fogc.space') {
  concat {'issue':
    path => '/etc/issue', 
    }
  concat::fragment{ 'issue_top':
    target => 'issue',
    content => "$domain\n",
    order => 01,
  }
}

class reception::issue_confidential { 
  include reception::issue
  concat::fragment{'issue_confidential':
    target  =>'issue',
    content => "All information contained on this system is protected, no information may be removed from this system until authorised.\n",
    order   => 10,
  }
}

class issue_topsec { 
  include reception::issue
  concat::fragment{'issue_topsec':
    target  =>'issue',
    content => "All information contained on this system is protected.\n",
    order   => 15,
  }
}

class issue_local {
  include reception::issue
  file{ 'issue_local':
    path => '/etc/issue.local',
    ensure => 'file',
  }
  concat::fragment{'issue_local':
    order=>99,
    target=> 'issue',
    source => '/etc/issue.local',
    require => File['/etc/issue.local']
  }
}
