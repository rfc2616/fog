module Fog
  module Compute
    class Ovirt
      class Real
        def storage_domains filter={}
          client.storagedomains(filter)
        end
      end

      class Mock
        def storage_domains(filters = {})
          xml = read_xml 'storage_domains.xml'
          Nokogiri::XML(xml).xpath('/storage_domains/storage_domain').collect do |sd|
            OVIRT::StorageDomain::new(self, sd)
          end
        end
      end
    end
  end
end
