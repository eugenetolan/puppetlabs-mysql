module Fog
  module Compute
    class Brightbox
      class Real
        # @param [String] identifier Unique reference to identify the resource
        #
        # @return [Hash] if successful Hash version of JSON object
        #
        # @see https://api.gb1.brightbox.com/1.0/#load_balancer_unlock_resource_load_balancer
        #
        def unlock_resource_load_balancer(identifier)
          return nil if identifier.nil? || identifier == ""
          wrapped_request("put", "/1.0/load_balancers/#{identifier}/unlock_resource", [200])
        end
      end
    end
  end
end
