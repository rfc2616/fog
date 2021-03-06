module Fog
  module Compute
    class Clodo
      class Real
        # Get details about a server
        #
        # ==== Parameters
        # * server_id<~Integer> - Id of server to get details for
        #
        # ==== Returns
        # * response<~Excon::Response>:
        #   * body<~Hash>:
        #   * 'server'<~Hash>:
        #     * 'addresses'<~Hash>:
        #       * 'public'<~Array> - public address strings
        #       * 'private'<~Array> - private address strings
        #     * 'id'<~Integer> - Id of server
        #     * 'imageId'<~Integer> - Id of image used to boot server
        #     * 'name<~String> - Name of server
        #     * 'status'<~String> - Current server status
        def get_server_details(server_id)
          request(
            :expects  => [200, 203],
            :method   => 'GET',
            :path     => "servers/#{server_id}"
          )
        end
      end

      class Mock
        def get_server_details(server_id)
          response = Excon::Response.new
          if server = list_servers_detail.body['servers'].detect {|_| _['id'] == "#{server_id}"}
            response.status = [200, 203][rand(1)]
            response.body = { 'server' => server }
            response.body['server']['id'] = server['id'].to_i
            response
          else
            raise Fog::Compute::Clodo::NotFound
          end
        end
      end
    end
  end
end
