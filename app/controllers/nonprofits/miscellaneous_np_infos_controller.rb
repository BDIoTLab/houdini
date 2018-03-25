module Nonprofits
  class MiscellaneousNpInfosController < ApplicationController
    include NonprofitHelper

    helper_method :current_nonprofit_user?
    before_filter :authenticate_nonprofit_user!

    def show
      respond_to do |format|
        format.json do
          render_json { FetchMiscellaneousNpInfo.fetch(params[:nonprofit_id]) }
        end
      end

    end

    def update
      respond_to do |format|
        format.json {
          render_json {
            update = UpdateMiscellaneousNpInfo.update(params[:nonprofit_id], params[:miscellaneous_np_info])
            #flash[:notice] = "Your Miscellaneous Settings have been saved"
            update
          }
        }
      end
    end
  end
end
