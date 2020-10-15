class sysctl_settings (Array $sysctl_keys,
                       String $sysctl_target_file)  {
#  $sysctl_keys = ['net.bridge.bridge-nf-call-ip5tables', 'net.bridge.bridge-nf-call-iptables'] 
  $sysctl_keys.each |String $sysctl_key| {
    sysctl { "$sysctl_key":
      require => Kmod::Load['br_netfilter'],
      ensure => present,
      value  => "1",
      target => "/etc/sysctl.d/$sysctl_target_file",
    }
  }
}
