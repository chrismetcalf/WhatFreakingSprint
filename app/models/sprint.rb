class Sprint
  PROPERTIES = [ :name, :jiraKey, :start, :message ]
  PROPERTIES.each { |prop| attr_accessor prop }

  def initialize(hash = {})
    hash.each { |k,v|
      if PROPERTIES.member? k.to_sym
        self.send((k.to_s + "=").to_s, v)
      end
    }
  end

  def self.lookup(&block)
    BW::HTTP.get("http://whatfuckingsprintarewe.in", :headers => {"Content-type" => "application/json"}) do |response|
      result_data = BW::JSON.parse(response.body.to_str)
      sprint = Sprint.new(result_data)
      block.call(sprint)
    end
  end
end
