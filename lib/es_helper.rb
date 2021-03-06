class EsHelper
  attr_reader :client, :gte, :lte

  def initialize
    initClient()
  end

  def initClient
    hosts = [ENV["ELASTICSEARCH_HOST00"], ENV["ELASTICSEARCH_HOST01"], ENV["ELASTICSEARCH_HOST02"]]
    @client = Elasticsearch::Client.new(log: true, logger: Logger.new("log/Elasticsearch.log"), hosts: hosts, randomize_hosts: true)
    p @client.transport.hosts
  end

  def setDate(gte, lte)
    begin
      @gte = DateTime.parse(gte) - Rational(9, 24)
      @lte = DateTime.parse(lte) - Rational(9, 24) - Rational(1, 24*60*60)
    rescue
      return nil
    end
    return true
  end

  def search(index, type, body, filter_path)
    begin
      ret = client.search(index: index, type: type, body: body, filter_path: filter_path)
    rescue => e
      return e
    end
    return ret
  end
end
