class UuController < ApplicationController
  def get
    client = Elasticsearch::Client.new(
      log: true, logger: Logger.new("log/Elasticsearch.log"), host: ENV["ELASTICSEARCH_HOST"])

    begin
      gte = DateTime.parse(params[:gte]) - Rational(9, 24)
      lte = DateTime.parse(params[:lte]) - Rational(9, 24) - Rational(1, 24*60*60)
    rescue
      render :json => { result: nil, err: "illegal date format"}.to_json
      return
    end

    body = {
      size: 0,
      query: {
        bool: {
          must: [
            {range: {
              time_iso8601: {
                gte: gte.strftime("%Y-%m-%dT%H:%M:%SZ"),
                lte: lte.strftime("%Y-%m-%dT%H:%M:%SZ")
              }
            }},
            {match: { "type.keyword": "landing" }},
            {terms: { "dashboard_flg": [0,2] }}
          ]
        }
      },
      aggs: {
        aggs_cookie: {
          terms: {
            field: "cookie.keyword",
            size: 100000
          }
        }
      }
    }

    index = "axs_#{params[:client_id]}"

    begin
      ret = client.search(index: index, type: 'access_log', body: body)
    rescue => e
      render :json => { result: nil, err: e.to_s }.to_json
      return
    end

    render :json => {
      result: ret["aggregations"]["aggs_cookie"]["buckets"].size
    }.to_json
  end
end
