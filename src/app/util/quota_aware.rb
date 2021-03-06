#
#   Copyright 2012 Red Hat, Inc.
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

# In XML requests, the quota is embedded as a node in the container object,
# because more than one root nodes are not allowed.
#
# In other types of requests, the quota param is in the "root" and the
# controllers are written to expect that.
#
# For XML requests we need to move the quota params back to the "root".
module QuotaAware

  def set_quota_param(node_where_quota_is_embedded)
    if !params.has_key? :quota and !params[node_where_quota_is_embedded][:quota].nil?
      params[:quota] = params[node_where_quota_is_embedded][:quota]
      params[node_where_quota_is_embedded].delete(:quota)
    end
  end

  def set_quota(quota_aware_model)
    limit = if params.has_key? :quota and not params[:unlimited_quota]
              params[:quota][:maximum_running_instances]
            else
              nil
            end
    quota_aware_model.quota.set_maximum_running_instances(limit)
  end

end
