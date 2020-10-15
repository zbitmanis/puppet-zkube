class resolver ( $search = "z-b.lv", ){
  augeas {'set resolv.conf search':
    context=>'/files/etc/resolv.conf',
    changes => [
      "set search/domain '${search}'"
    ],
  }
}

