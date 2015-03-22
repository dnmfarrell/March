requires "AnyMQ" => "0";
requires "Carp" => "0";
requires "March::Action::Move" => "0";
requires "March::Action::Turn" => "0";
requires "March::Attribute::Shape" => "0";
requires "March::ConfigManager" => "0";
requires "March::Msg" => "0";
requires "Math::Shape::Circle" => "0";
requires "Math::Shape::LineSegment" => "0";
requires "Math::Shape::Rectangle" => "0";
requires "Math::Shape::Vector" => "0";
requires "Regexp::Common" => "0";
requires "Role::Tiny" => "0";
requires "Role::Tiny::With" => "0";
requires "Scalar::Util" => "0";
requires "Time::Piece" => "0";
requires "feature" => "0";
requires "perl" => "5.020";
requires "strict" => "0";
requires "warnings" => "0";

on 'test' => sub {
  requires "Test::More" => "0";
};

on 'configure' => sub {
  requires "ExtUtils::MakeMaker" => "0";
};

on 'develop' => sub {
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Test::EOL" => "0";
  requires "Test::More" => "0.88";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
};
