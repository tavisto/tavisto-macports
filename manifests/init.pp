# Class macports
#
# This class manages all the configs macports
#
# Paramaters:
#   [*prefix*]
#      The prefix directory that all macports stuff is installed in
#
# Sample Usage:
#  class { 'macports':
#      prefix = '/opt/local',
#      applications_dir = '/Applications/MacPorts',
#  }
#
#
class macports (
  $prefix           = '/opt/local',
  $portdbpath       = "${prefix}/var/macports",
  $applications_dir = '/Applications/MacPorts',
  $frameworks_dir   = "${prefix}/Library/Frameworks",
  $sources_conf     = "${prefix}/etc/macports/sources.conf",
  $variants_conf    = "${prefix}/etc/macports/variants.conf",
  $portautoclean    = 'yes',
  $universal_archs  = 'x86_64 i386',
  $default_variants = 'UNSET'
) {
  case $::operatingsystem {
    darwin: {
          if ($default_variants != 'UNSET') {
            file {
              '/opt/local/etc/macports/variants.conf':
                ensure  => file,
                owner   => root,
                group   => admin,
                mode    => '0644',
                content => template("${module_name}/variants.conf.erb");
            }
          }
          file {
            '/opt/local/etc/macports/macports.conf':
              ensure  => file,
              owner   => root,
              group   => admin,
              mode    => '0644',
              content => template("${module_name}/macports.conf.erb");
          }

        }
    default: { fail(
        "${::operatinsystem} is Unsupoorted macports is only for OS-X")
    }
  }
}