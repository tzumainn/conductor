#
#   Copyright 2011 Red Hat, Inc.
#
#   Licensed under the Apache License, Version 2.0 (the "License");
#   you may not use this file except in compliance with the License.
#   You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.
#

class CreateDeployments < ActiveRecord::Migration
  def self.up
    create_table :deployments do |t|
      t.string    :name, :null => false, :limit => 1024
      t.integer   :realm_id
      t.integer   :owner_id
      t.integer   :pool_id, :null => false
      t.integer   :legacy_deployable_id, :null => false
      t.integer   :lock_version, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :deployments
  end
end
