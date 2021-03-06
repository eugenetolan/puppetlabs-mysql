module Fog
  module Compute
    class Terremark
      class Real
        # Get details for a Network
        #
        # ==== Parameters
        # * network_id<~Integer> - Id of the network to look up
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #   FIXME
        def get_network(network_id)
          request(
              :expects  => 200,
              :method   => 'GET',
              :parser   => Fog::Parsers::Terremark::Network.new,
              :path     => "network/#{network_id}"
          )
        end
      end

      class Mock
        def get_network(network_id)
          network_id = network_id.to_i
          response = Excon::Response.new
          network = self.data[:organizations].map { |org| org[:vdcs].map { |vdc| vdc[:networks] } }.flatten.find { |network| network[:id] == network_id }
          if network

            body = { "links" => [],
                     "type" => "application/vnd.vmware.vcloud.network+xml",
                     "href" => "#{@base_url}/network/#{network_id}" }

            network.each_key do |key|
              body[key.to_s] = network[key]
            end

            link = { "name" => "IP Addresses",
                     "rel"  => "down",
                     "type" => "application/xml" }
            link["href"] = case self
                             when Fog::Terremark::Ecloud::Mock
                               "#{@base_url}/extensions/network/#{network_id}/ips"
                             when Fog::Terremark::Vcloud::Mock
                               "#{@base_url}/network/#{network_id}/ipAddresses"
                           end
            body["links"] << link

            response.status = 200
            response.body = body
            response.headers = Fog::Compute::Terremark::Mock.headers(response.body,
                                                                    case self
                                                                      when Fog::Terremark::Ecloud::Mock
                                                                        "application/vnd.vmware.vcloud.network+xml"
                                                                      when Fog::Terremark::Vcloud::Mock
                                                                        "application/xml; charset=utf-8"
                                                                    end
            )
          else
            response.status = Fog::Compute::Terremark::Mock.unathorized_status
            response.headers = Fog::Compute::Terremark::Mock.error_headers
          end

          response
        end
      end
    end
  end
end
