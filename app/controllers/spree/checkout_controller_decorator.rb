Spree::CheckoutController.class_eval do
  before_action :set_affilate, only: :update
  after_action :clear_session, only: :update
  after_action :send_affilate_confirm_order_email, only: :update

  private
    def set_affilate
      # By session cookie
      if @order.payment? && session[:affiliate]
        @order.affiliate = Spree::Affiliate.find_by(path: session[:affiliate])
        return
      end

      # By promotion code
      affiliate = get_affiliate_by_promotion_code
      @order.affiliate = affiliate if affiliate
    end

    def clear_session
      session[:affiliate] = nil if @order.completed?
    end
    
    def get_affiliate_by_promotion_code
      @order.promotions.map do |p|
        affiliate = Spree::Affiliate.find_by(promotion_code: p.code)
        return affiliate if affiliate
      end
      return nil
    end
    
    def send_affilate_confirm_order_email
      Spree::AffiliateMailer.confirm_order_email(@order.id).deliver_later if @order.affiliate.present? && @order.completed?
    end
end
