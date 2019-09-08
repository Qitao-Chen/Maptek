class Account < ApplicationRecord
  ROLE = {0 => "customer", 1 => "admin", 2 => "super admin"}
end
