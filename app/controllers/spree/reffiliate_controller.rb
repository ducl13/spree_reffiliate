module Spree
  class ReffiliateController < Spree::StoreController
    def referral
      flash[:success] = Spree.t(:referral_code_applied)
      session[:referral] = params[:code]
      redirect_to root_path
    end

    def affiliate
      session[:affiliate] = params[:path]
      affiliate = Spree::Affiliate.find_by(path: params[:path])
      flash[:success] = Spree.t(:affiliate_code_applied) unless affiliate.nil?
      if affiliate.nil? or affiliate.partial.blank? or !partial_exists affiliate.partial
        if params[:redirect_path].present?
          redirect_path = url_for('/' + params[:redirect_path])
          redirect_to(redirect_path)
        else
          redirect_to(root_path)
        end
      elsif partial_exists affiliate.partial
        render "spree/affiliates/#{affiliate.partial}", layout: affiliate.get_layout
      end
    end

    private
      def partial_exists partial
        Affiliate.lookup_for_partial lookup_context, partial
      end
  end
end
