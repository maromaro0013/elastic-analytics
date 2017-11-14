class IndexController < ApplicationController
  def create
    esh = EsHelper.new()

    body = {
      settings: {
        index: {
          number_of_shards: 3,
          number_of_replicas: 1,
          max_result_window: 200000
        }
      },
      mappings: {
        access_log: {
          properties: {
            cID: { type: "keyword" },
            cookie: { type: "keyword" },
            cvID: { type: "keyword" },
            dashboard_flg: { type: "long" },
            device: { type: "keyword" },
            host: { type: "keyword" },
            referer: { type: "keyword" },
            request: { type: "keyword" },
            request_time: { type: "long" },
            session_id: { type: "keyword" },
            size: { type: "long" },
            spent_time: { type: "long" },
            status: { type: "long" },
            time_iso8601: { type: "date" },
            type: { type: "keyword" },
            ua: { type: "keyword" },
            upstream_response_time: { type: "keyword" }
          }
        },
        campaign_master: {
          properties: {
            campaign_id: { type: "keyword" },
            campaign_name: { type: "keyword" },
            campaign_type: { type: "long" },
            create_date: { type: "date" },
            id: { type: "long" },
            is_delete: { type: "long" },
            pv_exist_flg: { type: "boolean" }
          }
        },
        campaign_type_detail: {
          properties: {
            campaign_type: { type: "long" },
            created: { type: "date" },
            id: { type: "long" },
            modified: { type: "date" },
            name: { type: "keyword" }
          }
        },
        cookies: {
          properties: {
            cookie: { type: "keyword" },
            created: { type: "date" },
            id: { type: "long" },
            mail: { type: "keyword" },
            modified: { type: "date" }
          }
        },
        cv_log: {
          properties: {
            cID: { type: "keyword" },
            campaign_id: { type: "keyword" },
            cookie: { type: "keyword" },
            cvID: { type: "keyword" },
            referer: { type: "keyword" },
            time_iso8601: { type: "date" },
            ua: { type: "keyword" }
          }
        },
        exclude_info: {
          properties: {
            created_at: { type: "date" },
            id: { type: "long" },
            resource: { type: "keyword" },
            resource_type: { type: "long" },
            updated_at: { type: "date" }
          }
        },
        mail_activity_log: {
          properties: {
            category: { type: "keyword", },
            email: { type: "keyword", },
            event: { type: "keyword", },
            id: { type: "long" },
            timestamp: { type: "date" },
            url: { type: "keyword" }
          }
        },
        outer_site_info: {
          properties: {
            cID: { type: "keyword", },
            url: { type: "keyword", },
            title: { type: "keyword", },
            id: { type: "long" },
            created_at: { type: "date" },
            updated_at: { type: "date" }
          }
        },
        pv_count_history: {
          properties: {
            count: { type: "long" },
            date: { type: "date" },
            id: { type: "long" },
            mail: { type: "keyword" }
          }
        },
        score_history: {
          properties: {
            id: { type: "long" },
            mail: { type: "keyword" },
            model_name: { type: "keyword" },
            score: { type: "long" },
            score_date: { type: "date" },
            score_info: { type: "keyword" },
            score_reason: { type: "keyword" }
          }
        },
        search_log: {
          properties: {
            cookie: { type: "keyword" },
            dashboard_flg: { type: "long" },
            host: { type: "keyword" },
            query_string: { type: "keyword" },
            referer: { type: "keyword" },
            request: { type: "keyword" },
            request_time: { type: "long" },
            size: { type: "long" },
            spent_time: { type: "long" },
            status: { type: "long" },
            time_iso8601: { type: "date" },
            ua: { type: "keyword" },
            upstream_response_time: { type: "keyword" }
          }
        }
      }
    }

    ret = esh.client.indices.create(index: "axs_#{params[:client_id]}", body: body)

    render :json => {
      result: ret
    }.to_json
  end

  def delete
    esh = EsHelper.new()
    ret = esh.client.indices.delete(index: "axs_#{params[:client_id]}")

    render :json => {
      result: ret
    }.to_json
  end

  def list
    render :json => {
      result: "true"
    }.to_json
  end
end
