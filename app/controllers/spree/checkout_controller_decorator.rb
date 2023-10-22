Spree::CheckoutController.class_eval do
  before_action :set_affilate, only: :update
  after_action :clear_session, only: :update
  after_action :send_affilate_confirm_order_email, only: :update

  private
    def set_affilate
      if @order.payment? && session[:affiliate]
        @order.affiliate = Spree::Affiliate.find_by(path: session[:affiliate])
      end
    end

    def clear_session
      session[:affiliate] = nil if @order.completed?
    end

    def send_affilate_confirm_order_email
      Spree::AffiliateMailer.confirm_order_email(@order.id).deliver_later if @order.affiliate.present? && @order.completed?
    end
end
