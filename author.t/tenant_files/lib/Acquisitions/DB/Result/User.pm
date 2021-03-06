package Acquisitions::DB::Result::User;

use Moose;
use Wing::Perl;
extends 'Wing::DB::Result';
with 'Wing::Role::Result::User';
with 'Wing::Role::Result::UserTenantSSO';

__PACKAGE__->wing_finalize_class( table_name => 'users');

no Moose;
__PACKAGE__->meta->make_immutable(inline_constructor => 0);
