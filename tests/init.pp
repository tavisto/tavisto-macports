class { 'macports':
  prefix           => '/tmp/macports',
  default_variants => ['+bash_completion', '+python27', '-x11'];
}
