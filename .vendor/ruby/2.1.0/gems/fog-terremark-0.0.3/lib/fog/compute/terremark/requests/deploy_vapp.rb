module Fog
  module Compute
    class Terremark
      class Real
        # Reserve requested resources and deploy vApp
        #
        # ==== Parameters
        # * vapp_id<~Integer> - Id of vApp to deploy
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #     * 'endTime'<~String> - endTime of task
        #     * 'href'<~String> - link to task
        #     * 'startTime'<~String> - startTime of task
        #     * 'status'<~String> - status of task
        #     * 'type'<~String> - type of task
        #     * 'Owner'<~String> -
        #       * 'href'<~String> - href of owner
        #       * 'name'<~String> - name of owner
        #       * 'type'<~String> - type of owner
        def deploy_vapp(vapp_id)
          request(
              :expects  => 202,
              :method   => 'POST',
              :parser   => Fog::Parsers::Terremark::Task.new,
              :path     => "vApp/#{vapp_id}/action/deploy"
          )
        end
      end
    end
  end
end
