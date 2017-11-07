class PvController < ApplicationController

  def get
    esh = EsHelper.new()
    unless esh.setDate(params[:gte], params[:lte])
      render :json => { result: nil, err: "illegal date format" }.to_json
      return
    end

    body = {
      size: 0,
      query: {
        bool: {
          must: [
            {range: {
              time_iso8601: {
                gte: esh.gte.strftime("%Y-%m-%dT%H:%M:%SZ"),
                lte: esh.lte.strftime("%Y-%m-%dT%H:%M:%SZ")
              }
            }},
            {match: { "type.keyword": "landing" }},
            {terms: { "dashboard_flg": [0,2] }}
          ]
        }
      }
    }

    ret = esh.search("axs_#{params[:client_id]}", 'access_log', body, 'hits.total')
    unless ret.kind_of? Hash
      render :json => { result: nil, err: ret.to_s }.to_json
    else
      render :json => { result: ret["hits"]["total"] }.to_json
    end
  end
end
